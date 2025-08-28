INSTALL="sudo pacman --noconfirm -S"

function install_ack() {
    echo "Installing ack-grep - alternative to grep"
    curl https://beyondgrep.com/ack-v3.9.0 > ~/.local/bin/ack
}

function install_ctags() {
    echo "Installing ctags - code browsing utility that works with vim"
    $INSTALL ctags
}

function install_fd() {
    echo "Installing fd - alternative to find"
    $INSTALL fd
}

function install_fzf() {
    echo "Installing fzf - fuzzy file finder"
    $INSTALL fzf
}

function install_cscope() {
    echo "Installing cscope - code browser"
    $INSTALL fzf
}

function install_bat() {
    echo "Installing bat - alternative to cat"
    $INSTALL bat
}

function install_tig() {
    echo "Installing tig - git TUI"
    $INSTALL tig
}

function install_maim() {
    echo "Installing maim - screenshot tacker"
    $INSTALL maim
}
