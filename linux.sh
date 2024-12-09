function install_ack() {
    echo "Installing ack-grep - alternative to grep"
    sudo apt install ack-grep -y
}

function install_ctags() {
    echo "Installing ctags - code browsing utility that works with vim"
    sudo apt install universal-ctags -y
}

function install_fd() {
    echo "Installing fd - alternative to find"
    sudo apt install fd-find -y
    if [ ! "$(command -v fdfind)_" = "_" ]; then
        ln -s $(which fdfind) ~/.local/bin/fd
    fi
}

function install_fzf() {
    echo "Installing fzf - fuzzy file finder"
    sudo apt install fzf -y
}

function install_cscope() {
    echo "Installing cscope - code browser"
    sudo apt install cscope -y
}

function install_bat() {
    echo "Installing bat - alternative to cat"
    sudo apt install bat -y
    mkdir -p ~/.local/bin
    ln -s /usr/bin/batcat ~/.local/bin/bat
}

function install_tig() {
    echo "Installing tig - git TUI"
    sudo apt install tig -y
}

function install_maim() {
    echo "Installing maim - screenshot tacker"
    sudo apt install maim -y
}
