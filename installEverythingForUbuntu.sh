#!/bin/bash

# :)
apt update
apt upgrade

# installing all of the needed packages for development
apt install build-essential

# installing git
apt install git

# installing node and npm
apt install nodejs npm

# installing Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# installilng fzf and ripgrep
brew install fzf
brew install ripgrep

# installing JetBrains mono nerd font

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/JetBrainsMono.zip
unzip JetBrainsMono.zip -d JetBrainsMono
mkdir -p ~/.local/share/fonts
mv JetBrainsMono/*.ttf ~/.local/share/fonts/
fc-cache -fv
