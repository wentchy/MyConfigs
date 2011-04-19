
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2006 Aug 12
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=100		" keep 100 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

if has("gui_running")
set lines=50
set columns=150
endif

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" In an xterm the mouse should work quite well, thus enable it.
set mouse=a

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
au BufRead *.f90 let b:fortran_fixed_source=1
au BufRead *.f90 let fortran_have_tabs=1
au BufRead *.f90 let fortran_dialect="f77"
au BufRead *.FOR let b:fortran_fixed_source=1
au BufRead *.FOR let fortran_have_tabs=1
au BufRead *.FOR let fortran_dialect="f77"
au BufRead *.INC let b:fortran_fixed_source=1
au BufRead *.INC let fortran_have_tabs=1
au BufRead *.INC let fortran_dialect="f77"
au BufNewFile,BufReadPost *.sci,*.sce so ~/.vim/syntax/scilab.vim
" au BufRead *.f let b:fortran_fixed_source=1
" au BufRead *.f90 let b:fortran_free_source=1
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	 	\ | wincmd p | diffthis
set number
set shiftwidth=4
set cindent tabstop=4
set expandtab

" Added by liukai from internet 2007-12-9
" multi-encoding setting
if has("multi_byte")
  "set bomb
  set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,latin1
  " CJK environment detection and corresponding setting
  if v:lang =~ "^zh_CN"
    " Use cp936 to support GBK, euc-cn == gb2312
    set encoding=cp936
    set termencoding=cp936
    set fileencoding=cp936
  elseif v:lang =~ "^zh_TW"
    " cp950, big5 or euc-tw
    " Are they equal to each other?
    set encoding=big5
    set termencoding=big5
    set fileencoding=big5
  elseif v:lang =~ "^ko"
    " Copied from someone's dotfile, untested
    set encoding=euc-kr
    set termencoding=euc-kr
    set fileencoding=euc-kr
  elseif v:lang =~ "^ja_JP"
    " Copied from someone's dotfile, untested
    set encoding=euc-jp
    set termencoding=euc-jp
    set fileencoding=euc-jp
  endif
  " Detect UTF-8 locale, and replace CJK setting if needed
  if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
    set encoding=utf-8
    set termencoding=utf-8
    set fileencoding=utf-8
  endif
else
  echoerr "Sorry, this version of (g)vim was not compiled with multi_byte"
endif

colorscheme torte
" close the beep or visual beep
set noerrorbells
set novisualbell
"set vb t_vb=
" use F2 to acce the \be buffer 
map <F2> \be
"map <F3> :Matrix<CR>
map <F4> ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .


"imap () ()<Left>
"imap {} {}<Left>
"imap {}<CR> {}<CR><Esc>O
"imap ()<Space> (  )<Left><Left>
"imap <> <><Left>
"imap <><Space> <  ><Left><Left>
"imap "" ""<Left>

map g( bi(<Esc>ea)<Esc>
map g{ bi{<Esc>ea}<Esc>
map g[ bi[<Esc>ea]<Esc>

" use ,j to add a new line at the cursor(oppsite to J)
map ,j i<CR><ESC>
" Automatic scroll screen
map <F12> <C-E>:sleep 1000m<CR><C-E>:redraw<CR><F12>

"set foldmethod=syntax
set visualbell t_vb=
set dy=lastline,uhex

" eliminate menu
set guioptions-=m
" eliminate toolbar
"set guioptions-=T
" eliminate scroll bar
set guioptions-=r

"search visually selected text
vnoremap <silent> * y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
vnoremap <silent> # y?<C-R>=escape(@", '\\/.*$^~[]')<CR><CR> 

" code comment 
vnoremap <silent> <M-k> :!sed 's,^,//,'<CR>
vnoremap <silent> <M-u> :!sed 's,^//,,'<CR>

" use Alt-o to add a newline in normal mode
nmap <M-o> o<Esc>k
nmap <M-O> O<Esc>j
nmap  <M-k> :.!sed 's/^/C>/'<CR>
nmap  <M-u> :.!sed 's/^C>//'<CR>

" set cscope quickfix window support by liukai
set cscopequickfix=s-,c-,d-,i-,t-,e-,f-,g-

nmap <M-]>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <M-]>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <M-]>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <M-]>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <M-]>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <M-]>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <M-]>i :cs find i ^<C-R>=expand("<cfile>")<CR><CR>
nmap <M-]>d :cs find d <C-R>=expand("<cword>")<CR><CR>

nmap <M-c>s :cs add ./cscope.out .<CR>

" For mini buf expolorer set up
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplMapWindowNavVim = 1


nmap <M-g>l :run macros/gdb_mappings.vim<CR>

" For doxygen 
let g:DoxygenToolkit_licenseTag="Copyright (C) 2008-2010 SEA Group"
let g:DoxygenToolkit_blockHeader=""
let g:DoxygenToolkit_blockFooter=""
let g:DoxygenToolkit_authorName="" 

" For thinkpad T400's keyboard inconvinient : map F1 to Esc
nmap <F1> <Esc>
imap <F1> <Esc>
vmap <F1> <Esc>
cmap <F1> <C-c>

"imap <C-l> <Esc>
"vmap <C-l> <Esc>
"cmap <C-l> <C-c>

" For Emacs-like C-f and C-b in insert mode
imap <C-f> <Right>
imap <C-b> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-d> <del>
imap <C-a> <home>
imap <C-e> <end>

" For cppcomplete : configure the tags
set tags+=~/.vim/tags/cpp

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 0 " autocomplete after .
let OmniCpp_MayCompleteArrow = 0 " autocomplete after ->
let OmniCpp_MayCompleteScope = 0 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

