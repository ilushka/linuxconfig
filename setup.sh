#!/bin/bash

PATHOGEN_PATH=~/.vim/autoload/pathogen.vim
NERDTREE_PATH=~/.vim/bundle/nerdtree
CTRLP_PATH=~/.vim/bundle/ctrlp.vim
ACKVIM_PATH=~/.vim/bundle/ack.vim
TAGBAR_PATH=~/.vim/bundle/tagbar
GITGUTTER_PATH=~/.vim/bundle/vim-gitgutter
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

### shell

function install_bashrc() {
    bash_config=$1
    cat <<'EOF' >> $bash_config
set -o vi
alias ll="ls -laG"
alias vv="vi $(fzf)"
alias open="nohup xdg-open"

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
    #bits=">${bits}"
    bits="🍄${bits}"
  fi  
  if [ "${ahead}" == "0" ]; then
    #bits="*${bits}"
    bits="🔥${bits}"
  fi  
  if [ "${newfile}" == "0" ]; then
    #bits="+${bits}"
    bits="✨${bits}"
  fi  
  if [ "${untracked}" == "0" ]; then
    #bits="?${bits}"
    bits="🦴${bits}"
  fi  
  if [ "${deleted}" == "0" ]; then
    #bits="x${bits}"
    bits="💀${bits}"
  fi  
  if [ "${dirty}" == "0" ]; then
    #bits="!${bits}"
    bits="💩${bits}"
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

### vim

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

" Update refresh time to 100ms for gitgutter
set updatetime=100
" Increase max number of changes to display
let g:gitgutter_max_signs=1000

set laststatus=2
set statusline=
set statusline+=%#Pmenu#
set statusline+=%f\ \   
set statusline+=%l:%c\ \   
set statusline+=%{tagbar#currenttag('%s',\ '',\ 'f',\ 'scoped-stl')}

" show horizontal line under cursor
" set cursorline

" show tab, space, and newline charaters
" set list
" set listchars=tab:▸-,space:·,trail:¬

" show 80-character line limit
" set textwidth=80
" set colorcolumn=+1
EOF
}

function install_nerdtree() {
    cd ~/.vim/bundle && git clone https://github.com/scrooloose/nerdtree.git
    echo 'let g:NERDTreeWinSize = 22' >> ~/.vimrc
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

function install_gitgutter() {
    cd ~/.vim/bundle && git clone https://github.com/airblade/vim-gitgutter.git
}

### Python

function install_pip() {
    curl -O https://bootstrap.pypa.io/get-pip.py && sudo python get-pip.py
}

function install_virtualenv() {
    pip install virtualenv
}

function main() {
    case "$OSTYPE" in
        "darwin"*)
            echo "Platform: Mac OS"
            source macos.sh
            ;;
        "linux"*)
            echo "Platform: Linux"
            source linux.sh
            ;;
        *)
            echo "Platform: Unknown"
            ;;
    esac

    [ -f $PATHOGEN_PATH ] && echo "Pathogen might be already installed."
    [ "$(ask 'Install pathogen?')" = "yes" ] && install_pathogen

    [ -f $VIMRC_PATH ] \
        && [ ! "$(cat $VIMRC_PATH | grep 'set tabstop=2')_" = "_" ] \
        && echo "vimrc might be already installed"
    [ "$(ask 'Install vimrc?')" = "yes" ] && install_vimrc

    [ -d $NERDTREE_PATH ] && echo "NERDtree might be already installed."
    [ "$(ask 'Install NERDtree?')" = "yes" ] && install_nerdtree

    [ -d $CTRLP_PATH ] && echo "ctrlp.vim might be already installed."
    [ "$(ask 'Install ctrlp.vim?')" = "yes" ] && install_ctrlp

    [ -d $ACKVIM_PATH ] && echo "ack.vim might be already installed."
    [ "$(ask 'Install ack.vim?')" = "yes" ] && install_ackvim

    [ -d $TAGBAR_PATH ] && echo "Tagbar might be already installed."
    [ "$(ask 'Install Tagbar?')" = "yes" ] && install_tagbar

    [ -d $GITGUTTER_PATH ] && echo "GitGutter might be already installed."
    [ "$(ask 'Install GitGutter?')" = "yes" ] && install_gitgutter

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

    [ ! "$(command -v ctags)_" = "_" ] \
        && echo "ctags might be already installed"
    [ "$(ask 'Install ctags?')" = "yes" ] && install_ctags $bash_conf

    [ ! "$(command -v fd)_" = "_" ] && echo "fd might be already installed"
    [ "$(ask 'Install fd?')" = "yes" ] && install_fd

    [ ! "$(command -v fzf)_" = "_" ] && echo "fzf might be already installed"
    [ "$(ask 'Install fzf?')" = "yes" ] && install_fzf

    [ ! "$(command -v cscope)_" = "_" ] && echo "cscope might be already installed"
    [ "$(ask 'Install cscope?')" = "yes" ] && install_cscope

    [ ! "$(command -v bat)_" = "_" ] && echo "bat might be already installed"
    [ "$(ask 'Install bat?')" = "yes" ] && install_bat
}

main
