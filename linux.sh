function install_ack() {
    echo "Installing ack-grep"
    sudo apt install ack-grep
}

function install_ctags() {
    echo "Installing ctags"
    sudo apt install exuberant-ctags
}

function install_fd() {
    echo "Installing fd"
    sudo apt install fd-find
    if [ ! "$(command -v fdfind)_" = "_" ]; then
        ln -s $(which fdfind) ~/.local/bin/fd
    fi
}

function install_fzf() {
    echo "Installing fzf"
    sudo apt install fzf
}

function install_cscope() {
    echo "Installing cscope"
    sudo apt install cscope
}

function install_bat() {
    echo "Installing bat"
    sudo apt install bat
    mkdir -p ~/.local/bin
    ln -s /usr/bin/batcat ~/.local/bin/bat
}
