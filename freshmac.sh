#!/bin/bash

set -e  # Exit on error

echo "Starting system setup..."

# Install Homebrew if it's not installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew already installed."
fi

echo "Updating Homebrew..."
brew update

# Install zsh and make it the default shell
if ! command -v zsh &> /dev/null; then
    echo "Installing zsh..."
    brew install zsh
fi

# Install Git
brew install git

# Install clang-format
brew install clang-format

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install Powerlevel10k
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    echo "Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> ~/.zshrc
fi

# Directory for DMGs
mkdir -p ~/Downloads/DMGs
cd ~/Downloads/DMGs

# Download DMGs
echo "Downloading Zed..."
curl -LO https://zed.dev/api/releases/latest/download/mac

echo "Downloading UTM..."
curl -LO https://github.com/utmapp/UTM/releases/latest/download/UTM.dmg

echo "Downloading Firefox..."
curl -LO https://download.mozilla.org/?product=firefox-latest-ssl&os=osx&lang=en-US -o Firefox.dmg

echo "Downloading Discord..."
curl -LO "https://discord.com/api/download?platform=osx" -o Discord.dmg

echo "All done! ✅"
