set nocompatible							" be iMproved
filetype off									" required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/Vundle.vim'

" My bundles here:
"
" original repos on GitHub
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo

" The best Git wrapper of all time
Plugin 'tpope/vim-fugitive'
" Syntax checking hacks for vim
Plugin 'scrooloose/syntastic'
" Solarized Colorscheme for Vim
Plugin 'altercation/vim-colors-solarized'
" In practical terms, pathogen.vim makes it super easy to install plugins
" and runtime files in their own private directories.
"Plugin 'tpope/vim-pathogen'
" lean & mean status/tabline for vim that's light as air
Plugin 'bling/vim-airline'
" Using the jedi autocompletion library for VIM.
" Plugin 'davidhalter/jedi-vim'
" A Vim plugin that always highlights the enclosing html/xml tags
Plugin 'Valloric/MatchTagAlways'
" No-BS Python code folding for Vim
Plugin 'tmhedberg/SimpylFold'
" This indentation script for python tries to match more closely what is
" suggested in PEP 8
Plugin 'vim-scripts/indentpython.vim'
" Auto-complete
"Plugin 'Valloric/YouCompleteMe'

" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
" non-GitHub repos
"Bundle 'git://git.wincent.com/command-t.git'
" Git repos on your local machine (i.e. when working on your own plugin)
"Bundle 'file:///Users/gmarik/path/to/plugin'
" ...
call vundle#end()
filetype plugin indent on			" required!
"
" Brief help
" :BundleList					 - list configured bundles
" :BundleInstall(!)		 - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)			 - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle commands are not allowed.

" ------------------------------------------------------------------
" Solarized Colorscheme Config
" ------------------------------------------------------------------
set t_Co=256
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_degrade=1
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized
syntax enable
" ------------------------------------------------------------------

" The following items are available options, but do not need to be
" included in your .vimrc as they are currently set to their defaults.

" let g:solarized_degrade=0
" let g:solarized_bold=1
" let g:solarized_underline=1
" let g:solarized_italic=1
" let g:solarized_termcolors='256'
" let g:solarized_contrast="normal"
" let g:solarized_diffmode="normal"
" let g:solarized_menu=1

" -------------------------------------------------------------------
" Custom Options
" ------------------------------------------------------------------


" Better copy & paste
set pastetoggle=<F2>
set clipboard=unnamed

" map sort function key
vnoremap <leader>s :sort<CR>

" Specify different areas of the screen where the splits should occur
set splitbelow
set splitright

" ------------------------------------------------------------------
"  Abbreviations
" ------------------------------------------------------------------
ab sec_ln ------------------------------------------------------------------
ab bash_env #!/bin/bash
ab py_env #!/usr/bin/env python
ab py_enc # -*- coding: utf-8 -*-
" ------------------------------------------------------------------

" ------------------------------------------------------------------
" Vim area customs
" ------------------------------------------------------------------
"Column and line highlight
set tw=79
set nowrap
set fo-=t
set colorcolumn=80
highlight ColorColumn ctermbg=236
set cursorline
highlight cursorline ctermbg=236

" Line Number
set number

" Tabs and spaces settings
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" List options
set listchars=nbsp:.,eol:$,tab:>>,trail:·
nmap <leader>l :set list!<CR>

" Enable hlsearch
set hls

" Enable folding
"set foldmethod=indent
"set foldlevel=99
" Enable folding with the spacebar
"nnoremap <space> za

" Airline config
set noshowmode
set laststatus=2
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_powerline_fonts=1
" Always show 5 lines above/below the cursor, so scrolling past bottom/top of
" the screen will show more context of surrounding lines
set scrolloff=5
" ------------------------------------------------------------------


" ------------------------------------------------------------------
" Edit customs
" ------------------------------------------------------------------
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" Apagando espacos no final da linha
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>

" Apagando linhas em branco
nmap _bl :call Preserve("g/^$/d")<CR>
nmap _= :call Preserve("normal gg=G")<CR>

" Formatacao da sintaxe
nmap ,== :call Preserve("normal gg<S-V><S-G>=")<CR>

" Apaga os espacos em branco no final da linha automaticamente para os
" arquivos com final .pp, .py .rb.
autocmd BufWritePre *.pp, *.rb, *.py *.js *.html :call Preserve("%s/\\s\\+$//e")<CR>

" Indentação para arquivos com final .py
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab

" Flagging Unnecessary Whitespace
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" ------------------------------------------------------------------

" ------------------------------------------------------------------
" Teclas de atalho
" ------------------------------------------------------------------
" for linux and windows users (using the control key)
" map <C-S-]> gt
" map <C-S-[> gT
" map <C-1> 1gt
" map <C-2> 2gt
" map <C-3> 3gt
" map <C-4> 4gt
" map <C-5> 5gt
" map <C-6> 6gt
" map <C-7> 7gt
" map <C-8> 8gt
" map <C-9> 9gt
" map <C-0> :tablast<CR>

" TextMate ident command
vnoremap < <gv
vnoremap > >gv

" Map Windows change
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Unhighlight last search term.
nnoremap <C-\> :noh<Return>

" Commenting blocks of code.
autocmd FileType c,cpp,java,js      let b:comment_leader = '// '
autocmd FileType sh,yaml,python     let b:comment_leader = '# '
autocmd FileType conf,fstab         let b:comment_leader = '# '
autocmd FileType tex                let b:comment_leader = '% '
autocmd FileType mail               let b:comment_leader = '> '
autocmd FileType vim                let b:comment_leader = '" '
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>
" ------------------------------------------------------------------

" ------------------------------------------------------------------
"  Syntastic Settings
" ------------------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['pylint']
" ------------------------------------------------------------------
