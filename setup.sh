#!/bin/bash

PATHOGEN_PATH=~/.vim/autoload/pathogen.vim
NERDTREE_PATH=~/.vim/bundle/nerdtree
CTRLP_PATH=~/.vim/bundle/ctrlp.vim
ACKVIM_PATH=~/.vim/bundle/ack.vim
TAGBAR_PATH=~/.vim/bundle/tagbar
BASHRC_PATH=~/.bashrc
BASH_PROFILE_PATH=~/.bash_profile
VIMRC_PATH=~/.vimrc

function ask() {
    read -s -n1 -p "$1"$' [yn]\n' _is_yes
    if [ "$_is_yes" = "y" ] || [  "$_is_yes" = "Y" ]; then
        echo "yes"
    else
        echo "no"
    fi
}

function install_pathogen() {
    mkdir -p ~/.vim/autoload ~/.vim/bundle && \
        curl -LSso $PATHOGEN_PATH https://tpo.pe/pathogen.vim
    echo 'execute pathogen#infect()' >> ~/.vimrc
}

function install_vimrc() {
    cat <<'EOF' >> $VIMRC_PATH
set number
set nocompatible
syntax on
set expandtab
set tabstop=2
set shiftwidth=2
set ruler
set scrolloff=3

" show horizontal line under cursor
" set cursorline

" show tabe, space, and newline charaters
" set list
" set listchars=tab:▸-,space:·,trail:¬

" show 80-character line limit
" set textwidth=80
" set colorcolumn=+1
EOF
}

function install_bashrc() {
    bash_config=$1
    cat <<'EOF' >> $bash_config
set -o vi
alias ll="ls -laG"

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

export PS1="\[\e[33m\]\u\[\e[m\]\[\e[35m\]\`parse_git_branch\`\[\e[m\]🐁 "
EOF
}

function install_nerdtree() {
    cd ~/.vim/bundle && git clone https://github.com/scrooloose/nerdtree.git
    echo 'let g:NERDTreeWinSize = 22' >> ~/.vimrc
}

function install_ack() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "Installing ack"
        brew install ack
    else
        sudo apt-get install ack-grep
    fi
}

function install_ctags() {
    bash_config=$1
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "Installing ctags"
        brew install ctags
        echo "alias ctags=\"$(brew --prefix)/bin/ctags\"" >> $bash_config
    else
        sudo apt-get install ctags
    fi
}

function install_pip() {
    curl -O https://bootstrap.pypa.io/get-pip.py && sudo python get-pip.py
}

function install_virtualenv() {
    pip install virtualenv
}

function install_ctrlp() {
    cd ~/.vim/bundle && git clone https://github.com/kien/ctrlp.vim.git
}

function install_ackvim() {
    cd ~/.vim/bundle && git clone https://github.com/mileszs/ack.vim.git
}

function install_tagbar() {
    cd ~/.vim/bundle && git clone https://github.com/majutsushi/tagbar.git
    cat <<'EOF' >> $VIMRC_PATH
let g:tagbar_width = 30
nmap <F8> :TagbarToggle<CR>
EOF
}

[ -f $PATHOGEN_PATH ] && echo "Pathogen might be already installed."
[ "$(ask 'Install pathogen?')" = "yes" ] && install_pathogen

[ -d $NERDTREE_PATH ] && echo "NERDtree might be already installed."
[ "$(ask 'Install NERDtree?')" = "yes" ] && install_nerdtree

[ -d $CTRLP_PATH ] && echo "ctrlp.vim might be already installed."
[ "$(ask 'Install ctrlp.vim?')" = "yes" ] && install_ctrlp

[ -d $ACKVIM_PATH ] && echo "ack.vim might be already installed."
[ "$(ask 'Install ack.vim?')" = "yes" ] && install_ackvim

[ -d $TAGBAR_PATH ] && echo "Tagbar might be already installed."
[ "$(ask 'Install Tagbar?')" = "yes" ] && install_tagbar

[ -f $VIMRC_PATH ] && [ ! "$(cat $VIMRC_PATH | grep 'set tabstop=2')_" = "_" ] \
        && echo "vimrc might be already installed"
[ "$(ask 'Install vimrc?')" = "yes" ] && install_vimrc

# figure out which bash configuration file to use
if [ -f $BASHRC_PATH ]; then
    bash_conf=$BASHRC_PATH
else
    bash_conf=$BASH_PROFILE_PATH
fi

[ ! "$(cat $bash_conf | grep 'set -o vi')_" = "_" ] \
        && echo "bashrc might be already installed"
[ "$(ask 'Install bashrc?')" = "yes" ] && install_bashrc $bash_conf

[ ! "$(command -v ack)_" = "_" ] && echo "ack is already installed"
[ "$(ask 'Install ack?')" = "yes" ] && install_ack

[ ! "$(command -v pip)_" = "_" ] && echo "pip is already installed"
[ "$(ask 'Install pip?')" = "yes" ] && install_pip

[ ! "$(command -v ctags)_" = "_" ] && echo "ctags might be already installed"
[ "$(ask 'Install ctags?')" = "yes" ] && install_ctags $bash_conf

