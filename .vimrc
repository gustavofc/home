set nocompatible							" be iMproved
filetype off									" required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My bundles here:
"
" original repos on GitHub
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
Bundle 'altercation/vim-colors-solarized'
Bundle 'davidhalter/jedi-vim'
Bundle 'kien/ctrlp.vim'


" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
" non-GitHub repos
"Bundle 'git://git.wincent.com/command-t.git'
" Git repos on your local machine (i.e. when working on your own plugin)
"Bundle 'file:///Users/gmarik/path/to/plugin'
" ...

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
let g:solarized_termtrans=1		 "default value is 0
let g:solarized_visibility="high"		 "default value is normal
let g:solarized_hitrail=0		 "default value is 0
syntax enable
set background=dark
colorscheme solarized
" ------------------------------------------------------------------

" The following items are available options, but do not need to be
" included in your .vimrc as they are currently set to their defaults.

" let g:solarized_degrade=0
" let g:solarized_bold=1
" let g:solarized_underline=1
" let g:solarized_italic=1
let g:solarized_termcolors='256'
" let g:solarized_contrast="normal"
" let g:solarized_diffmode="normal"
" let g:solarized_menu=1

" -------------------------------------------------------------------
" Custom Options
" ------------------------------------------------------------------
"  Abbreviations
ab ln ---------------------------------------------------
ab env_bash #!/bin/bash
ab py_env #!/usr/bin/env python
ab py_enc # -*- coding: utf-8 -*-
" Line numbers
set number
" Colors settings
set t_Co=256
set bg=dark
" Tabs and spaces settings
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set listchars=eol:$,tab:>>,trail:·,nbsp:.
nmap <leader>l :set list!<CR>
" Cursor settings
set cursorline
"set cursorcolumn
set colorcolumn=80
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
" arquivos com final .pp e .rb.
autocmd BufWritePre *.pp, *.rb, *.py :call Preserve("%s/\\s\\+$//e")<CR>

" Indentação para arquivos com final .py
autocmd FileType python setlocal ts=2 sts=4 sw=4 expandtab

" for linux and windows users (using the control key)
map <C-S-]> gt
map <C-S-[> gT
map <C-1> 1gt
map <C-2> 2gt
map <C-3> 3gt
map <C-4> 4gt
map <C-5> 5gt
map <C-6> 6gt
map <C-7> 7gt
map <C-8> 8gt
map <C-9> 9gt
map <C-0> :tablast<CR>

" TextMate ident command
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

" Map Windows change
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Commenting blocks of code.
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" CrtlP config
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
