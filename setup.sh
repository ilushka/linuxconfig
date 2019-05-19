#!/bin/bash

set -e

BIN_NAME=$(basename $0)

function show_usage() {
    case $1 in
        "pathogen")
            printf "install runtimepath manager (https://github.com/tpope/vim-pathogen)\n"
            ;;
        "nerdtree")
            printf "install filesystem explorer (https://github.com/scrooloose/nerdtree)\n"
            ;;
        "ctrlp")
            printf "install fuzzy finder (https://github.com/kien/ctrlp.vim)\n"
            ;;
        "vimack")
            printf "install ack-grep plugin (https://github.com/mileszs/ack.vim)\n"
            ;;
        "pip")
            printf "install python package manager (https://pypi.org/project/pip/)\n"
            ;;
        "virtualenv")
            printf "install python virtual environments tool (https://virtualenv.pypa.io/en/latest/)\n"
            ;;
        "ackgrep")
            printf "install grep tool optimized for programmers (https://beyondgrep.com/)\n"
            ;;
        *)
            printf "Usage: ${BIN_NAME} <"
            cat ${BIN_NAME} | awk 'BEGIN { FS = "\""; ORS = "|"; } /\"[a-z]+\"\) # first-level-arg/ { print $2; }'
            printf "\b>\n"
            ;;
    esac
}

function show_readme() {
    printf "
## copy .bashrc
$ cat .bashrc >> ~/.bashrc

## copy .vimrc
$ cat .vimrc >> ~/.vimrc

## copy .Xresource
$ cat .Xresource >> ~/.Xresource
"
}

function run_as_root() {
    if [[ $EUID -ne 0 ]]; then
        printf "run this as root\n"
        exit 1
    fi
}

function install_pathogen() {
    mkdir -p ~/.vim/autoload ~/.vim/bundle && \
        curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
    printf "don't forget to update .vimrc\n"
}

function install_nerdtree() {
    cd ~/.vim/bundle && git clone https://github.com/scrooloose/nerdtree.git
}

function install_ctrlp() {
    cd ~/.vim/bundle && git clone https://github.com/kien/ctrlp.vim.git
}

function install_vimack() {
    cd ~/.vim/bundle && git clone https://github.com/mileszs/ack.vim.git
}

function install_pip() {
    curl -O https://bootstrap.pypa.io/get-pip.py && sudo python get-pip.py
}

function install_virtualenv() {
    run_as_root
    pip install virtualenv
}

function install_ackgrep() {
    run_as_root
    apt-get install ack-grep
}

case $1 in
    "pathogen") # first-level-arg
        install_pathogen
        ;;
    "nerdtree") # first-level-arg
        install_nerdtree
        ;;
    "ctrlp") # first-level-arg
        install_ctrlp
        ;;
    "vimack") # first-level-arg
        install_vimack
        ;;
    "pip") # first-level-arg
        install_pip
        ;;
    "virtualenv") # first-level-arg
        install_virtualenv
        ;;
    "ackgrep") # first-level-arg
        install_ackgrep
        ;;
    "help") # first-level-arg;
        show_usage "${@:2}"
        ;;
    "readme") # first-level-arg;
        show_readme
        ;;
    *)
        show_usage "${@:2}"
        ;;
esac

