function install_ack() {
    echo "Installing ack-grep - alternative to grep"
    brew install ack
}

function install_ctags() {
    echo "Installing ctags - code browsing utility that works with vim"
    brew install ctags
    echo "alias ctags=\"$(brew --prefix)/bin/ctags\"" >> $bash_config
}

function install_fd() {
    echo "Installing fd - alternative to find"
    brew install fd
}

function install_fzf() {
    echo "Installing fzf - fuzzy file finder"
    brew install fzf
}

function install_cscope() {
    echo "Installing cscope - code browser"
    brew install cscope
}

function install_bat() {
    echo "Installing bat on Mac OS not supported"
}

function install_tig() {
    echo "Installing tig - git TUI"
    brew install tig
}

function install_maim() {
    echo "Installing maim on Mac OS not supported "
}
