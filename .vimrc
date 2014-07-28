"-*- encoding:utf-8 -*-

set nowritebackup
set t_Co=256
syntax on
syntax enable
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
Bundle 'airblade/vim-rooter'
" Produce increasing/decreasing columns of numbers, dates, or daynames
Bundle 'YankRing.vim'
Bundle 'indent-motion'
" extended % matching for HTML, LaTeX, and many other languages
Bundle 'matchit.zip'
Bundle 'mileszs/ack.vim'
Bundle 'tpope/vim-surround'
Bundle 'Raimondi/delimitMate'

" :: Coding
Bundle 'SirVer/ultisnips'
Bundle 'Valloric/YouCompleteMe'
"Bundle 'autoload_cscope.vim'
Bundle 'scrooloose/nerdcommenter'
"Bundle 'mattn/webapi-vim'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-commentary'

" :: Decorator
Bundle 'bling/vim-airline'
Bundle 'airblade/vim-gitgutter'
Bundle 'majutsushi/tagbar'
Bundle 'chriskempson/base16-vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'chriskempson/vim-tomorrow-theme'
Bundle 'scrooloose/nerdtree'
Bundle "nathanaelkane/vim-indent-guides"

" :: Command
Bundle 'tpope/vim-fugitive'
Bundle  'sjl/gundo.vim'

" :: Language support
Bundle 'tell-k/vim-autopep8'
Bundle 'scrooloose/syntastic'
Bundle 'groovy.vim'

if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
    :qall
endif

" Setting up solarized color theme
let g:solarized_termtrans = 1
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

" --- YouCompleteMe
let g:ycm_confirm_extra_conf = 0
let g:ycm_key_list_select_completion = ['<TAB>']
let g:ycm_key_list_previous_completion=['<S-TAB>']
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'

" --- vim-gitgutter
let g:gitgutter_enabled = 1

" --- Ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"
"let g:UltiSnipsListSnippets="<c-s-tab>"
let g:UltiSnipsSnippetsDir="~/.vim/bundle/ultisnips/UltiSnips"

" --- TagBar
nmap <silent> <F6> :TagbarToggle<CR>
let g:tagbar_ctags_bin = "/usr/local/bin/ctags"

" --- syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_cpp_include_dirs = ['/usr/include/']
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libstdc++'
"set error or warning signs
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
""whether to show balloons
let g:syntastic_enable_balloons = 1

" Setting up ack
let g:ack_autoclose = 1
" Use silversearcher for better performance
let g:ackprg = "ag --nogroup --nocolor --column"
let g:ackhighlight = 1
nnoremap <silent> <Leader>g :Ack<CR>

" Setting up grep
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
elseif executable('ack-grep')
    set grepprg=ack-grep\ -H\ --nocolor\ --nogroup\ --column\ --smart-case\ --follow
elseif executable('ack')
    set grepprg=ack\ -H\ --nocolor\ --nogroup\ --column\ --smart-case\ --follow
endif

" Setting up ctrlp
let g:ctrlp_map = '<c-l>'
if executable('ag')
    " Use ag over grep
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif"
