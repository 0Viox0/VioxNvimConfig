# Viox config

### How to install everything needed for nvim:

- make sure g++, gcc or any other cpp compiler is installed
- install [fzf](https://github.com/junegunn/fzf?tab=readme-ov-file#installation)
- install [ripgrep](https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation)
- install node, npm
- install .NET SDK
- (optional) install base devel package

### Alacritty:

- put alacritty.toml in ~/.config/alacritty/
- make it default terminal emulator
- install JetBrains Nerd font

### Zsh:

- put .zshrc in ~/
- install oh-my-zsh

### Tmux:

- put .tmux.conf in ~/
- ```sh
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm/
    ```
- then enter tmux: ```sh tmux``` and press <kbd>Ctrl</kbd>+<kbd>A</kdb>+<kbd>I</kbd> to install plugins

### Additional info:

if you would like to install java, then you would want to look at ftplugin/java.lua to know where to install all java stuff
