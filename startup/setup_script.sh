#!/bin/bash

# --- Configuration Variables ---
DEFAULT_SHELL="/usr/bin/fish"
RUSTUP_INIT_URL="https://sh.rustup.rs"

# --- Utility Functions ---

# Function to check if a command exists
command_exists () {
    command -v "$1" >/dev/null 2>&1
}

# Function to check for and enable a COPR repository
enable_copr() {
    local copr_name="$1"
    if ! dnf copr list enabled | grep -q "$copr_name"; then
        echo "--> Enabling COPR repository: $copr_name"
        if sudo dnf copr enable -y "$copr_name"; then
            echo "Successfully enabled $copr_name."
        else
            echo "ERROR: Failed to enable COPR $copr_name. Aborting COPR installation step."
            return 1
        fi
    else
        echo "COPR repository $copr_name is already enabled."
    fi
    return 0
}

# --- Installation Functions ---

## 1. Flatpak and Flathub Setup
setup_flatpak() {
    echo "## 1. Setting up Flatpak and Flathub..."
    if command_exists flatpak; then
        echo "Flatpak is already installed."
    else
        echo "Installing flatpak..."
        sudo dnf install -y flatpak
    fi
    
    echo "Adding Flathub remote..."
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    echo "Flathub setup complete."
    echo "---"
}

## 2. Shell Installation (Fish) and Configuration
install_fish() {
    echo "## 2. Installing Fish Shell and setting as default..."
    
    # Install Fish from default Fedora repos
    if command_exists fish; then
        echo "Fish is already installed."
    else
        sudo dnf install -y fish
    fi

    # Set Fish as default shell
    if [ "$SHELL" != "$DEFAULT_SHELL" ]; then
        echo "Setting Fish as the default shell. You may be prompted for your password."
        if chsh -s "$DEFAULT_SHELL"; then
            echo "Fish set as default shell. It will take effect on your next login."
        else
            echo "WARNING: Failed to set Fish as default shell. Please do so manually with 'chsh -s /usr/bin/fish'."
        fi
    else
        echo "Fish is already the default shell."
    fi
    echo "---"
}

## 3. Developer Tools (Git, Lazygit, Neovim, NVR, Go, Rust, Python)
install_dev_tools() {
    echo "## 3. Installing Developer Tools (Git, Lazygit, Neovim, Go, Rust, Python)..."

    # Install Git (Default Fedora repos)
    echo "Installing Git..."
    sudo dnf install -y git
    
    # Install Lazygit (Using Copr)
    if enable_copr "atim/lazygit"; then
        echo "Installing Lazygit..."
        sudo dnf install -y lazygit
    fi

    echo "Ensuring Python 3 is installed..."
    sudo dnf install -y python3 python3-pip
    
    # Install Neovim and Neovim-Remote (Using Copr)
    # Note: Fedora often has neovim in repos, but a COPR might offer a newer stable version.
    # The script uses the official dnf package for simplicity and reliability.
    echo "Installing Neovim and Neovim-Remote..."
    # nvim-remote is often a python package, but some coprs or official packages may include it.
    # We install the main package and the required python package for nvim-remote.
    sudo dnf install -y neovim python3-neovim

    # Install Python (Python3 is standard in Fedora)
    if command_exists pip; then
      pip3 install neovim-remote
    fi

    echo "Installing ghostty"
    if enable_copr "scottames/ghostty"; then
      sudo dnf install -y ghostty
    fi

    # Install Go (Official Fedora repos)
    echo "Installing Go..."
    sudo dnf install -y golang

    # Install Rust (via rustup.sh)
    echo "Installing Rust via rustup..."
    if command_exists rustup; then
        echo "Rustup is already installed."
    else
        # Use a non-interactive installation
        curl --proto '=https' --tlsv1.2 -sSf $RUSTUP_INIT_URL | sh -s -- -y
        # Add cargo/rustup to PATH for the current script session
        source "$HOME/.cargo/env"
        echo "Rust and Cargo installed."
    fi

    echo "Developer tools installation complete."
    echo "---"
}

## 4. Terminal Multiplexer (Zellij)
install_zellij() {
    echo "## 4. Installing Zellij..."
    # Zellij is often available via COPR on Fedora for latest versions
    if enable_copr "gpanders/zellij"; then
        echo "Installing Zellij..."
        sudo dnf install -y zellij
    fi
    echo "Zellij installation complete."
    echo "---"
}

## 5. Other Applications (Steam, FreeCAD)
install_applications() {
    echo "## 5. Installing Steam and FreeCAD..."
    
    # Steam
    # Ensure RPM Fusion is enabled for Steam to work well (multilib support)
    echo "Installing Steam (requires RPM Fusion, ensuring it's enabled)..."
    # This command adds RPM Fusion Free and Nonfree for Fedora 43
    sudo dnf install -y \
        https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
        https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

    sudo dnf install -y steam
    
    # FreeCAD
    # Often the Flatpak is preferred for FreeCAD for up-to-date versions, 
    # but since you preferred dnf/COPR, we'll check for a common COPR or use the standard repo.
    # Standard Fedora repos often have an older version. We'll use the default dnf package.
    echo "Installing FreeCAD..."
    sudo dnf install -y freecad
    
    echo "Application installation complete."
    echo "---"
}


# --- Main Execution ---
main() {
    echo "==================================================="
    echo "🚀 Fedora Setup Automation Script Starting..."
    echo "==================================================="

    # Ensure necessary tools for the script itself are installed
    echo "Ensuring dnf utilities (like COPR support) are available..."
    sudo dnf install -y dnf-plugins-core curl

    setup_flatpak
    install_fish
    install_dev_tools
    install_zellij
    install_applications

    echo "==================================================="
    echo "✅ Setup Complete!"
    echo "==================================================="
    echo "NOTE: Some changes (like default shell) require a NEW TERMINAL or LOGOUT/LOGIN to take effect."
}

# Execute the main function
main

