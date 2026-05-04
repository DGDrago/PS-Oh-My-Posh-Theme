# PS-Oh-My-Posh-Theme

A PowerShell module for browsing and installing [Oh My Posh](https://ohmyposh.dev/) themes directly from the terminal.

## Installation

```powershell
# Clone into your PowerShell modules directory
git clone https://github.com/DGDrago/PS-Oh-My-Posh-Theme "$HOME\Documents\PowerShell\Modules\PS-Oh-My-Posh-Theme"
```

Add to your `$PROFILE`:

```powershell
Import-Module "$env:USERPROFILE\Documents\PowerShell\Modules\PS-Oh-My-Posh-Theme\PS-Oh-My-Posh-Theme.psm1"
```

## Usage

```powershell
# List all available themes (122+) from GitHub
PS-Oh-My-Posh-Theme -List

# Install and activate a theme
PS-Oh-My-Posh-Theme -Install grandpa-style

# Help
PS-Oh-My-Posh-Theme -h
```

## How it works

- Fetches theme list from the [official Oh My Posh GitHub repo](https://github.com/JanDeDobbeleer/oh-my-posh/tree/main/themes)
- Downloads selected theme to `~/.config/oh-my-posh/`
- Automatically updates `$PROFILE` to activate the new theme

## Legend

| Symbol | Meaning |
|--------|---------|
| `▶` | Currently active theme |
| `✓` | Installed locally |
| `·` | Not installed |

## Requirements

- [Oh My Posh](https://ohmyposh.dev/docs/installation/windows) installed
- PowerShell 5.1+
