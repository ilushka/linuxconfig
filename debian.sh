INSTALL="sudo apt --asume-yes"

function install_ack() {
    echo "Installing ack-grep - alternative to grep"
    $INSTALL ack-grep
}

function install_ctags() {
    echo "Installing ctags - code browsing utility that works with vim"
    $INSTALL universal-ctags
}

function install_fd() {
    echo "Installing fd - alternative to find"
    $INSTALL fd-find
    if [ ! "$(command -v fdfind)_" = "_" ]; then
        ln -s $(which fdfind) ~/.local/bin/fd
    fi
}

function install_fzf() {
    echo "Installing fzf - fuzzy file finder"
    $INSTALL fzf
}

function install_cscope() {
    echo "Installing cscope - code browser"
    $INSTALL cscope
}

function install_bat() {
    echo "Installing bat - alternative to cat"
    $INSTALL install bat
    mkdir -p ~/.local/bin
    ln -s /usr/bin/batcat ~/.local/bin/bat
}

function install_tig() {
    echo "Installing tig - git TUI"
    $INSTALL tig
}

function install_maim() {
    echo "Installing maim - screenshot tacker"
    $INSTALL maim
}
