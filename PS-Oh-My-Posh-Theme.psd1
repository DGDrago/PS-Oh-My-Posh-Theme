@{
    ModuleVersion     = '1.0.0'
    GUID              = 'a3f2e1d4-bc56-4789-a012-3456789abcde'
    Author            = 'DGDrago'
    Description       = 'Browse and install Oh My Posh themes directly from the terminal'
    PowerShellVersion = '5.1'
    RootModule        = 'PS-Oh-My-Posh-Theme.psm1'
    FunctionsToExport = @('Invoke-OhMyPoshTheme')
    AliasesToExport   = @('PS-Oh-My-Posh-Theme')
    PrivateData       = @{
        PSData = @{
            Tags       = @('oh-my-posh', 'theme', 'prompt', 'terminal', 'powershell')
            LicenseUri = 'https://github.com/DGDrago/PS-Oh-My-Posh-Theme/blob/master/LICENSE'
            ProjectUri = 'https://github.com/DGDrago/PS-Oh-My-Posh-Theme'
        }
    }
}
