#!/bin/bash

set -e

BIN_NAME=$(basename $0)

function show_usage() {
    case $1 in
        *)
            printf "Usage: ${BIN_NAME} <"
            cat ${BIN_NAME} | awk 'BEGIN { FS = "\""; ORS = "|"; } /\"[a-z]+\"\) # first-level-arg/ { print $2; }'
            printf "\b>\n"
            ;;
    esac
}

function show_readme() {
    printf "
## Quick Start
"
}

function install_pathogen() {
    mkdir -p ~/.vim/autoload ~/.vim/bundle && \
        curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
    printf "Don't forget to update .vimrc\n"
}

function install_nerdtree() {
    cd ~/.vim/bundle && git clone https://github.com/scrooloose/nerdtree.git
}

case $1 in
    "pathogen") # first-level-arg
        install_pathogen
        ;;
    "nerdtree") # first-level-arg
        install_nerdtree
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

