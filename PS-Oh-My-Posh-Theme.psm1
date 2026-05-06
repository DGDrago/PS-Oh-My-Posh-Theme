function Invoke-OhMyPoshTheme {
    [CmdletBinding(DefaultParameterSetName = 'Help')]
    param(
        [Parameter(ParameterSetName = 'List')]
        [switch]$List,

        [Parameter(ParameterSetName = 'Install', Position = 0, Mandatory)]
        [string]$Install,

        [Parameter(ParameterSetName = 'Help')]
        [Alias('h')]
        [switch]$Help
    )

    $themesDir = "$env:USERPROFILE\.config\oh-my-posh"
    $rawBase   = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes"
    $apiUrl    = "https://api.github.com/repos/JanDeDobbeleer/oh-my-posh/contents/themes"

    switch ($PSCmdlet.ParameterSetName) {

        'List' {
            Write-Host ""
            Write-Host "  Fetching theme list from GitHub..." -ForegroundColor DarkGray

            try {
                $items = Invoke-RestMethod -Uri $apiUrl `
                    -Headers @{ 'User-Agent' = 'PS-Oh-My-Posh-Theme' } `
                    -ErrorAction Stop
            } catch {
                Write-Host "  ERROR: Could not reach GitHub API. Check your connection." -ForegroundColor Red
                return
            }

            $themes = $items |
                Where-Object { $_.name -like "*.omp.json" } |
                ForEach-Object { $_.name -replace '\.omp\.json$', '' } |
                Sort-Object

            $installed = Get-ChildItem $themesDir -Filter "*.omp.json" -ErrorAction SilentlyContinue |
                ForEach-Object { $_.Name -replace '\.omp\.json$', '' }

            $currentTheme = $null
            $profileContent = Get-Content $PROFILE -ErrorAction SilentlyContinue
            if ($profileContent) {
                $m = [regex]::Match(($profileContent -join "`n"), '\\([^\\]+)\.omp\.json')
                if ($m.Success) { $currentTheme = $m.Groups[1].Value }
            }

            $total = $themes.Count
            Write-Host ""
            Write-Host "  Oh My Posh — $total themes available" -ForegroundColor Yellow
            Write-Host ("  " + ("─" * 52)) -ForegroundColor DarkGray
            Write-Host "  ▶ = active   ✓ = installed locally   · = not installed" -ForegroundColor DarkGray
            Write-Host ""

            foreach ($t in $themes) {
                $isCurrent   = $t -eq $currentTheme
                $isInstalled = $installed -contains $t

                if ($isCurrent) {
                    $icon  = "  ▶ "
                    $color = "Green"
                } elseif ($isInstalled) {
                    $icon  = "  ✓ "
                    $color = "Cyan"
                } else {
                    $icon  = "  · "
                    $color = "Gray"
                }

                Write-Host "$icon$t" -ForegroundColor $color
            }

            Write-Host ""
            Write-Host "  Install a theme: PS-Oh-My-Posh-Theme -Install <name>" -ForegroundColor DarkGray
            Write-Host ""
        }

        'Install' {
            $themeName = $Install -replace '\.omp\.json$', ''
            $themeUrl  = "$rawBase/$themeName.omp.json"
            $themePath = "$themesDir\$themeName.omp.json"

            Write-Host ""
            Write-Host "  Installing: $themeName" -ForegroundColor Cyan

            New-Item -ItemType Directory -Path $themesDir -Force | Out-Null

            try {
                Invoke-WebRequest -Uri $themeUrl -OutFile $themePath -ErrorAction Stop
                Write-Host "  ✓ Saved to $themePath" -ForegroundColor Green
            } catch {
                Write-Host "  ✗ Theme '$themeName' not found." -ForegroundColor Red
                Write-Host "    Use -List to browse available themes." -ForegroundColor DarkGray
                return
            }

            $initLine = 'oh-my-posh init pwsh --config "{0}\.config\oh-my-posh\{1}.omp.json" | Invoke-Expression' `
                -f $env:USERPROFILE, $themeName

            $profileContent = Get-Content $PROFILE -ErrorAction SilentlyContinue
            if ($profileContent -and ($profileContent -match 'oh-my-posh init pwsh')) {
                $newContent = $profileContent | ForEach-Object {
                    if ($_ -match 'oh-my-posh init pwsh') { $initLine } else { $_ }
                }
            } else {
                $newContent = @($profileContent) + $initLine
            }

            try {
                Set-Content -Path $PROFILE -Value $newContent -Encoding UTF8 -ErrorAction Stop
                $written = Get-Content $PROFILE -Raw -ErrorAction SilentlyContinue
                if ($written -notmatch [regex]::Escape($themeName)) {
                    throw "Read-back check failed — write silently blocked (check Windows Defender / antivirus)"
                }
                Write-Host "  ✓ Profile updated: $PROFILE" -ForegroundColor Green
                Write-Host ""
                Write-Host "  Reload now: . `$PROFILE" -ForegroundColor Yellow
            } catch {
                Write-Host "  ✗ Could not write to profile: $_" -ForegroundColor Red
                Write-Host "    Profile path: $PROFILE" -ForegroundColor DarkGray
                Write-Host "    Run manually to apply (this session only):" -ForegroundColor DarkGray
                Write-Host "    $initLine" -ForegroundColor White
            }
            Write-Host ""
        }

        default {
            Write-Host @"

  PS-Oh-My-Posh-Theme  —  Oh My Posh theme manager

  USAGE
    PS-Oh-My-Posh-Theme -List
    PS-Oh-My-Posh-Theme -Install <theme-name>
    PS-Oh-My-Posh-Theme -h

  OPTIONS
    -List              Fetch and show all available themes from GitHub
                       ▶ marks the active theme, ✓ marks locally installed
    -Install <name>    Download theme and save it to `$PROFILE
    -h / -Help         Show this help

  EXAMPLES
    PS-Oh-My-Posh-Theme -List
    PS-Oh-My-Posh-Theme -Install grandpa-style
    PS-Oh-My-Posh-Theme -Install jandedobbeleer

  Themes source:  https://github.com/JanDeDobbeleer/oh-my-posh/tree/main/themes
  Config dir:     $env:USERPROFILE\.config\oh-my-posh\

"@
        }
    }
}

Set-Alias -Name "PS-Oh-My-Posh-Theme" -Value "Invoke-OhMyPoshTheme"
Export-ModuleMember -Function Invoke-OhMyPoshTheme -Alias PS-Oh-My-Posh-Theme
