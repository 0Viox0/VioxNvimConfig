# Viox config

#### There is a script called installEverythingForUbuntu.sh which can help you install all of the dependencies

* Get the script 
```wget https://github.com/0Viox0/VioxNvimConfig/blob/master/installEverythingForUbuntu.sh```
* Chmod it
```chmod u+x installEverythingForUbuntu.sh```
* And run it
```./installEverythingForUbuntu.sh```

### How to install everything needed for nvim:

- make sure g++, gcc or any other cpp compiler is installed
- install [fzf](https://github.com/junegunn/fzf?tab=readme-ov-file#installation)
- install [ripgrep](https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation)
- install node, npm
- install .NET SDK
- (optional) install base devel package

### Alacritty:

- install alacritty ```sudo snap install alacritty --classic```
- put alacritty.toml in ~/.config/alacritty/
- make it default terminal emulator
- install JetBrains Nerd font

### Zsh:

- install [oh-my-zsh](https://ohmyz.sh/#install)
- put .zshrc in ~/

### Tmux:

- install tmux: ```sudo apt install tmux```
- put .tmux.conf in ~/
- ```sh 
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm/
    ```
- then enter tmux in the terminal: ```tmux``` and press <kbd>Ctrl</kbd>+<kbd>A</kbd>+<kbd>I</kbd> to install plugins

### Additional info:

if you would like to install java, then you would want to look at ftplugin/java.lua to know where to install all java stuff
