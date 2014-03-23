"-*- encoding:utf-8 -*-

set nowritebackup
set t_Co=256
syntax on
set sw=4
set ruler
set softtabstop=4
set tabstop=4
set et
set modeline
set modelines=3

set showmatch
set hls
set bk
set bdir=~/.backup
set bex=.bak
set fileencodings=utf-8,big5,gbk,sjis,euc-jp,euc-kr,utf-bom,iso8859-1
set enc=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set smarttab
colors wombat256

setl omnifunc=nullcomplete#Complete
autocmd FileType * setl omnifunc=nullcomplete#Complete
autocmd FileType javascript setl omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setl omnifunc=xmlcomplete#CompleteTags
autocmd FileType php setl omnifunc=phpcomplete#CompletePHP
autocmd FileType c setl omnifunc=ccomplete#Complete

autocmd FileType python set ai et sw=4 ts=4
autocmd FileType css set noai noci nosmarttab nosmartindent


autocmd FileType .awesomerc set syntax conf
autocmd FileType rdf set syntax=xml
autocmd FileType xul set syntax=xml

filetype on
filetype indent on
filetype plugin on
set nocp

nmap <F2> :make<CR>
nmap <F3> :make clean<CR>
nmap <F5> :NERDTreeToggle<CR>
nmap <F6> :set spell <CR>
nmap <C-t> :tabe .<CR>
nmap <C-c> :tabclose <CR>
nmap <C-n> :cnext <CR>
nmap <C-p> :cprevious <CR>
nmap <Tab> gt
nmap <S-Tab> gT
autocmd BufRead,BufNewFIle *.py nmap <F2> :%w !python<CR>
autocmd BufRead,BufNewFIle *.rb nmap <F2> :%w !ruby<CR>
autocmd BufRead,BufNewFIle *.java nmap <F2> :!ant<CR>
autocmd FileType python map <F7> :s/^/#<CR>
autocmd FileType python map <F8> :s/^#//<CR>
autocmd FileType cpp map <F7> :s@^@//<CR>
autocmd FileType cpp map <F8> :s@^//@@<CR>
autocmd FileType java map <F7> :s@^@//<CR>
autocmd FileType java map <F8> :s@^//@@<CR>
autocmd FileType tex map <F7> :s@^@%<CR>
autocmd FileType tex map <F8> :s@^%@@<CR>
autocmd FileType tex colors h80
if has("gui_running")
    if has("win32")
        set gfn=Inconsolata:h14
    elseif has("mac")
        set gfn=Monaco:h14
    endif
endif
if has("win32")
	source $VIMRUNTIME/delmenu.vim
	source $VIMRUNTIME/menu.vim
	language messages zh_TW.utf-8
endif
set autochdir
set incsearch
let python_highlight_all = 1
nmap j gj
nmap k gk
nmap gf :tabedit <cfile><CR>
set ic
nmap .. 3Go

"autocmd BufWinLeave *.* silent mkview
"autocmd BufWinEnter *.* silent loadview
let g:EasyMotion_leader_key = ','
nnoremap <Leader>ff :FufFile! <CR>
set laststatus=2

function PyHeader()
    if getfsize(@%) <= 0
        execute "norm i#!/usr/bin/env python# -*- coding: utf-8 -*-"
    endif
endfunction
function BashHeader()
    if getfsize(@%) <= 0
        execute "norm i#!/bin/bash"
    endif
endfunction


au BufRead,BufNewFile *.py call PyHeader()
au BufRead,BufNewFile *.sh call BashHeader()


"setting up vundle if not installed
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" :: Basic editing or moving
Bundle 'Lokaltog/vim-easymotion'
" :: File transfer
Bundle 'kien/ctrlp.vim'
" Produce increasing/decreasing columns of numbers, dates, or daynames
Bundle 'indent-motion'
" extended % matching for HTML, LaTeX, and many other languages
Bundle 'matchit.zip'
Bundle 'mileszs/ack.vim'
Bundle 'tpope/vim-surround'

" :: Coding
Bundle 'Valloric/YouCompleteMe'
"Bundle 'autoload_cscope.vim'
"Bundle 'mattn/webapi-vim'

" :: Decorator
Bundle 'bling/vim-airline'
Bundle 'airblade/vim-gitgutter'
"Bundle 'majutsushi/tagbar'
Bundle 'chriskempson/base16-vim'
Bundle 'chriskempson/vim-tomorrow-theme'
Bundle 'scrooloose/nerdtree'

" :: Command
Bundle 'tpope/vim-fugitive'

" :: Language support
Bundle 'tell-k/vim-autopep8'
Bundle 'scrooloose/syntastic'

if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
    :qall
endif
