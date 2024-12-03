function install_ack() {
    echo "Installing ack-grep"
    sudo apt install ack-grep -y
}

function install_ctags() {
    echo "Installing ctags"
    sudo apt install universal-ctags -y
}

function install_fd() {
    echo "Installing fd"
    sudo apt install fd-find -y
    if [ ! "$(command -v fdfind)_" = "_" ]; then
        ln -s $(which fdfind) ~/.local/bin/fd
    fi
}

function install_fzf() {
    echo "Installing fzf"
    sudo apt install fzf -y
}

function install_cscope() {
    echo "Installing cscope"
    sudo apt install cscope -y
}

function install_bat() {
    echo "Installing bat"
    sudo apt install bat -y
    mkdir -p ~/.local/bin
    ln -s /usr/bin/batcat ~/.local/bin/bat
}

function install_tig() {
    echo "Installing tig"
    sudo apt install tig -y
}
