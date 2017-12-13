" vimrc
"
"
set foldmethod=manual      " Automatically create folds for each indent
"au BufWinLeave * mkview     " Automatically save and load folds
"au BufWinEnter * silent loadview


set nocp                    " Enable plugins


" ---- General Setup ----
set nocompatible           " Don't emulate vi's limitations
set tabstop=4              " 4 spaces for tabs
set smarttab               " Tab next line based on current line
set expandtab             " Spaces for indentation
"set autoindent             " Automatically indent next line
"set smartindent            " Indent next line based on current line
set noautoindent             " Automatically indent next line
set nosmartindent            " Indent next line based on current line
"set linebreak             " Display long lines wrapped at word boundaries
set incsearch              " Enable incremental searching
set hlsearch               " Highlight search matches
set ignorecase
set smartcase             " Ignore case when searching
"set infercase              " Attempt to figure out the correct case
set showfulltag            " Show full tags when doing completion
set virtualedit=block      " Only allow virtual editing in block mode
set lazyredraw             " Lazy Redraw (faster macro execution)
set wildmenu               " Menu on completion please
set wildmode=longest,full  " Match the longest substring, complete with first
set wildignore=*.o,*~      " Ignore temp files in wildmenu
set scrolloff=3            " Show 3 lines of context during scrolls
set sidescrolloff=2        " Show 2 columns of context during scrolls
set backspace=2            " Normal backspace behavior
"set textwidth=80          " Break lines at 80 characters
set hidden                 " Allow flipping of buffers without saving
set noerrorbells           " Disable error bells
set visualbell             " Turn visual bell on
set t_vb=                  " Make the visual bell emit nothing
set showcmd                " Show the current command
set softtabstop=4
set shiftwidth=4
set number "enable line numbering
set nolist
set clipboard=unnamedplus

colorscheme darkblue
highlight Search ctermfg=white ctermbg=205

if &term =~ '^xterm\\|rxvt'
  " solid underscore
let &t_SI .= "\<Esc>[4 q"
  " solid block
"let &t_EI .= "\<Esc>[2 q"
  " 1 or 0 -> blinking block
  " 3 -> blinking underscore
  " Recent versions of xterm (282 or above) also support
  " 5 -> blinking vertical bar
  " 6 -> solid vertical bar
endif

set diffopt+=iwhite

" ---- Filetypes ----
if has('syntax')
   syntax on
endif

if has('osfiletype')
   filetype on             " Detect filetype by extension
   "filetype indent on      " Enable indents based on extensions
   filetype plugin on      " Load filetype plugins
endif

" ---- Folding ----
if has('eval')
   fun! WideFold()
      if winwidth(0) > 90
         setlocal foldcolumn=1
      else
         setlocal foldcolumn=0
      endif
   endfun

   "let g:detectindent_preferred_expandtab = 0
   "let g:detectindent_preferred_indent = 4

   "fun! <SID>DetectDetectIndent()
      "try
         ":DetectIndent
      "catch
      "endtry
   "endfun
endif

if has('autocmd')
   autocmd BufEnter * :call WideFold()
   "if has('eval')
      "autocmd BufReadPost * :call s:DetectDetectIndent()
   "endif

   autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif
endif

" ---- Spelling ----
if (v:version >= 700)
   set spelllang=en_us        " US English Spelling please

   " Toggle spellchecking with F10
   nmap <silent> <F10> :silent set spell!<CR>
   imap <silent> <F10> <C-O>:silent set spell!<CR>
endif

" Display a pretty statusline if we can
if has('title')
   set title
endif
set laststatus=2
set shortmess=atI
if has('statusline')
   set statusline=Editing:\ %r%t%m\ %=Location:\ Line\ %l/%L\ \ Col:\ %c\ (%p%%)
endif

" Enable modelines only on secure vim
if (v:version == 603 && has("patch045")) || (v:version > 603)
   set modeline
else
   set nomodeline
endif

" Show trailing whitespace visually
"if (&termencoding == "utf-8") || has("gui_running")
"  if v:version >= 700
"     set list listchars=tab:»·,trail:·,extends:…,nbsp:‗
"  else
"     set list listchars=tab:»·,trail:·,extends:…
"  endif
"else
"  if v:version >= 700
"     set list listchars=tab:>-,trail:.,extends:>,nbsp:_
"  else
"     set list listchars=tab:>-,trail:.,extends:>
"  endif
"endif

if has('autocmd')
   " always refresh syntax from the start
   autocmd BufEnter * syntax sync fromstart

   " subversion commit messages need not be backed up
   autocmd BufRead svn-commit.tmp :setlocal nobackup

   " mutt does not like UTF-8
   autocmd BufRead,BufNewFile *
      \ if &ft == 'mail' | set fileencoding=iso8859-1 | endif

   " fix up procmail rule detection
   autocmd BufRead procmailrc :setfiletype procmail
endif



" tab indents selection
vmap <silent> <Tab> >gv
" shift-tab unindents
vmap <silent> <S-Tab> <gv

" Page using space
noremap <Space> <C-F>

" no shifted arrows
inoremap <S-Up> <C-O>gk
noremap  <S-Up> gk
inoremap <S-Down> <C-O>gj
noremap  <S-Down> gj

" Y should yank to EOL
map Y y$

"no vK 
vmap K k

"no :W and :Q
if has('user_commands')
   command! -nargs=0 -bang Q q<bang>
   command! -nargs=0 -bang W w<bang>
   command! -nargs=0 -bang WQ wq<bang>
   command! -nargs=0 -bang Wq wq<bang>
endif

" just continue
nmap K K<cr>

" tabs
map  <F9> :tabprevious<CR>
imap <F9> <Esc>:tabprevious<CR>i
map  <F10> :tabnext<CR>
imap <F10> <Esc>:tabnext<CR>i
"nmap <C-t> :tabnew<CR>
"imap <C-t> <Esc>:tabnew<CR>i
"nmap <> :-tabmove<CR>
"imap <> <Esc>:-tabmove<CR>i

" Disable q and Q
"map q <Nop>
"map Q <Nop>

"nmap <silent> <F12> :silent set number!<CR>
"imap <silent> <F12> <C-O>:silent set number!<CR>
"noremap <silent> <F12> :set hls!<CR>
noremap <silent> <F12> :noh<CR>

" Don't force column 0 for #
inoremap # X<BS>#

highlight Normal ctermbg=none

" Python specific stuff
if has('eval')
"   let python_highlight_all = 1
   let python_slow_sync = 1
endif

" haskell-vim config
let g:haskell_enable_quantification = 1   " highlighting `forall`
let g:haskell_enable_recursivedo = 1      " highlighting `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " highlighting `proc`
let g:haskell_enable_pattern_synonyms = 1 " highlighting `pattern`
let g:haskell_enable_typeroles = 1        " highlighting type roles
let g:haskell_enable_static_pointers = 1  " highlighting `static`
let g:haskell_backpack = 1                " highlighting backpack keywords

map <C-n> :NERDTreeToggle<CR>
"close tree if is the only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

set mouse=nvi
set ttymouse=xterm2
let html_use_css=1

" neovimhaskell config
let g:haskell_enable_quantification = 1   " hl `forall`
let g:haskell_enable_recursivedo = 1      " hl `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " hl `proc`
let g:haskell_enable_pattern_synonyms = 1 " hl `pattern`
let g:haskell_enable_typeroles = 1        " hl type roles
let g:haskell_enable_static_pointers = 1  " hl `static`
let g:haskell_backpack = 1                " hl backpack keywords
let g:haskell_indent_disable = 1

let g:airline_theme='alduin'
let g:airline#extensions#whitespace#enabled = 0
let g:airline_section_x = '%{&filetype}'
"let g:tmuxline_preset = 'full'

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline',
Plug 'vim-airline/vim-airline-themes',
"Plug 'edkolev/tmuxline.vim',
Plug 'scrooloose/nerdtree',
Plug 'dag/vim-fish',
Plug 'tpope/vim-surround',
Plug 'idris-hackers/idris-vim',
Plug 'neovimhaskell/haskell-vim',
Plug 'ctrlpvim/ctrlp.vim',
call plug#end()
