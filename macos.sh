function install_ack() {
    echo "Installing ack-grep"
    brew install ack
}

function install_ctags() {
    echo "Installing ctags"
    brew install ctags
    echo "alias ctags=\"$(brew --prefix)/bin/ctags\"" >> $bash_config
}

function install_fd() {
    echo "Installing fd"
    brew install fd
}

function install_fzf() {
    echo "Installing fzf"
    brew install fzf
}

function install_cscope() {
    echo "Installing cscope"
    brew install cscope
}

function install_bat() {
    echo "Installing bat not supported"
}

function install_tig() {
    echo "Installing tig"
    brew install tig
}
