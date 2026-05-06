# PS-Oh-My-Posh-Theme

Browse and install [Oh My Posh](https://ohmyposh.dev/) themes directly from the terminal.  
Two tools, same functionality — pick the one that fits your shell.

| Tool | Shell |
|------|-------|
| `PS-Oh-My-Posh-Theme` | PowerShell |
| `OMP-Th` | Git Bash / bash |

---

## PowerShell module

### Installation

```powershell
git clone https://github.com/DGDrago/PS-Oh-My-Posh-Theme "$HOME\Documents\PowerShell\Modules\PS-Oh-My-Posh-Theme"
```

Add to your `$PROFILE`:

```powershell
Import-Module "$env:USERPROFILE\Documents\PowerShell\Modules\PS-Oh-My-Posh-Theme\PS-Oh-My-Posh-Theme.psm1"
```

### Usage

```powershell
# List all available themes from GitHub (multi-column, colour-coded)
PS-Oh-My-Posh-Theme -List

# Download theme and activate it in $PROFILE
PS-Oh-My-Posh-Theme -Install grandpa-style
PS-Oh-My-Posh-Theme -Install jandedobbeleer

# Help
PS-Oh-My-Posh-Theme -h
```

### Requirements

- PowerShell 5.1+
- [Oh My Posh](https://ohmyposh.dev/docs/installation/windows) installed

---

## Bash script (Git Bash)

### Installation

```bash
# Copy to ~/bin and make executable
mkdir -p ~/bin
cp OMP-Th ~/bin/OMP-Th
chmod +x ~/bin/OMP-Th
```

Make sure `~/bin` is on your PATH (add to `~/.bashrc` if needed):

```bash
export PATH="$HOME/bin:$PATH"
```

### Usage

```bash
# List all available themes from GitHub (multi-column, colour-coded)
OMP-Th --list

# Download a theme and activate it in ~/.bashrc / ~/.bash_profile
OMP-Th --install grandpa-style
OMP-Th --install jandedobbeleer

# Download ALL themes to ~/.config/oh-my-posh/ at once
# Already downloaded themes are skipped automatically
OMP-Th --all

# Help
OMP-Th --help
```

### Requirements

- Git Bash (bash 4+)
- `curl` (included with Git for Windows)
- [Oh My Posh](https://ohmyposh.dev/docs/installation/windows) installed

---

## How it works

- Fetches the theme list from the [official Oh My Posh GitHub repo](https://github.com/JanDeDobbeleer/oh-my-posh/tree/main/themes) via GitHub API
- Downloads selected theme(s) to `~/.config/oh-my-posh/`
- `--install` / `-Install` automatically updates your shell profile to activate the new theme
- `--all` bulk-downloads every theme and skips files already present locally

## Legend

| Symbol | Meaning |
|--------|---------|
| `▶` | Currently active theme |
| `✓` | Installed locally |
| `·` | Not installed |
