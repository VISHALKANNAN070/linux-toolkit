# Linux Toolkit (Bash)

A lightweight, menu-driven TUI (Text User Interface) for Linux system administration. Built with Bash and `dialog`, this toolkit allows users to quickly monitor processes, view system logs, and check hardware specs in a clean, themeable interface.

## Features

- **Process Viewer** — Interactive process monitoring with customizable count
- **Log Viewer** — Quickly check recent system logs
- **System Info** — Displays hardware and software details (integrates with Fastfetch for a visual summary)
- **Themes** — Switch between Dark Mode and Light Mode instantly
- **Error Handling** — Robust input validation and crash protection

## Prerequisites

This tool requires the following utilities:

- `bash`
- `dialog` (required for the menu interface)
- `fastfetch` (optional, recommended for System Info)

### Installing Dependencies

**Arch Linux:**
```
sudo pacman -S dialog fastfetch
```

**Ubuntu/Debian:**
```
sudo apt update
sudo apt install dialog
# Note: Check the Fastfetch GitHub for Ubuntu installation instructions if not in apt
```

**Fedora:**
```
sudo dnf install dialog fastfetch
```

## Installation

Clone the repository:
```
git clone https://github.com/VISHALKANNAN070/linux-toolkit.git
cd linux-toolkit
```

Make the scripts executable:
```
chmod +x *.sh
```

## Usage

Run the main script to launch the toolkit:
```
./toolkit.sh
```

## Themes

The toolkit supports custom themes using `.dialogrc` configuration files located in the `themes/` directory.

- **Dark Mode** — A subtle, professional dark theme with grey text and blue borders, designed for low-light environments
- **Light Mode** — A clean, high-contrast white theme

Toggle between themes directly from the "Change Theme" option in the main menu.
