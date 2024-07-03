#!/bin/bash

# :)
sudo apt update
sudo apt upgrade

# installing all of the needed packages for development
sudo apt install build-essential

# installing git
sudo apt install git

# installing node and npm
sudo apt install nodejs npm

# installing Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# adding to the PATH
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/viox/.bashrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# installilng fzf and ripgrep
brew install fzf
brew install ripgrep

# installing JetBrains mono nerd font

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/JetBrainsMono.zip
unzip JetBrainsMono.zip -d JetBrainsMono
mkdir -p ~/.local/share/fonts
mv JetBrainsMono/*.ttf ~/.local/share/fonts/
fc-cache -fv

rm -rf JetBrainsMono
rm -rf JetBrainsMono.zip
