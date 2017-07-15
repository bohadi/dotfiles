" vimrc
"
"
set foldmethod=manual      " Automatically create folds for each indent
"au BufWinLeave * mkview     " Automatically save and load folds
"au BufWinEnter * silent loadview


set nocp                    " Enable plugins
   " omnicomplete
"autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType c set omnifunc=ccomplete#CompleteCpp
"autocmd FileType java set omnifunc=javacomplete#Complete
"set tags+=~/.vim/qttags
" ctags
" let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
" ctags and tasklisk hotkeys
"map T :TaskList<CR>
"map P :TlistToggle<CR>


" ---- General Setup ----
set nocompatible           " Don't emulate vi's limitations
set tabstop=4              " 4 spaces for tabs
set smarttab               " Tab next line based on current line
set expandtab             " Spaces for indentation
set autoindent             " Automatically indent next line
set smartindent            " Indent next line based on current line
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
set softtabstop=2
set shiftwidth=2
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
   filetype indent on      " Enable indents based on extensions
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

   let g:detectindent_preferred_expandtab = 0
   let g:detectindent_preferred_indent = 4

   fun! <SID>DetectDetectIndent()
      try
         :DetectIndent
      catch
      endtry
   endfun
endif

if has('autocmd')
   autocmd BufEnter * :call WideFold()
   if has('eval')
      autocmd BufReadPost * :call s:DetectDetectIndent()
   endif

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

if has('mouse')
   " Dont copy the listchars when copying
   set mouse=nvi
endif

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

" ---- cscope/ctags setup ----
if has('cscope') && executable('cscope') == 1
   " Search cscope and ctags, in that order
   set cscopetag
   set cscopetagorder=0

   set nocsverb
   if filereadable('cscope.out')
      cs add cscope.out
   endif
   set csverb
endif

" ---- Key Mappings ----

" improved lookup
if has('eval')
   fun! GoDefinition()
      let pos = getpos(".")
      normal! gd
      if getpos(".") == pos
         exe "tag " . expand("<cword>")
      endif
   endfun
endif

nmap <C-]> :call GoDefinition()<CR>

if has('autocmd')
   " Shortcuts
   if has('eval')
      fun! <SID>cabbrev()
         iab #i #include
         iab #I #include

         iab #d #define
         iab #D #define

         iab #e #endif
         iab #E #endif
      endfun

      autocmd FileType c,cpp :call <SID>cabbrev()
   endif

   " make tab reindent in normal mode
   autocmd FileType c,cpp,cs,java nmap <Tab> =0<CR>
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
" map <S-Tab> :tabprevious<CR>
" imap <S-Tab> <Esc>:tabprevious<CR>i
" map <Tab> :tabnext<CR>
" imap <Tab> <Esc>:tabnext<CR>i
" nmap <C-t> :tabnew<CR>
" imap <C-t> <Esc>:tabnew<CR>i

" Disable q and Q
"map q <Nop>
"map Q <Nop>

" Toggle numbers with F12
nmap <silent> <F12> :silent set number!<CR>
imap <silent> <F12> <C-O>:silent set number!<CR>
noremap <silent> <F4> :set hls!<CR>

" Don't force column 0 for #
inoremap # X<BS>#

" Always map <C-h> to backspace
" Both interix and cons use C-? as forward delete,
" besides those two exceptions, always set it to backspace
" Also let interix use ^[[U for end and ^[[H for home
map <C-h> <BS>
map! <C-h> <BS>
if (&term =~ "interix")
   map  <C-?> <DEL>
   map! <C-?> <DEL>
   map [H <Home>
   map [U <End>
elseif (&term =~ "^sun")
   map  <C-?> <DEL>
   map! <C-?> <DEL>
elseif (&term !~ "cons")
   map  <C-?> <BS>
   map! <C-?> <BS>
endif

highlight Normal ctermbg=none

" Python specific stuff
if has('eval')
"   let python_highlight_all = 1
   let python_slow_sync = 1
endif

" pathogen
"execute pathogen#infect()   " TODO not avail as root

" haskell-vim config
let g:haskell_enable_quantification = 1   " highlighting `forall`
let g:haskell_enable_recursivedo = 1      " highlighting `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " highlighting `proc`
let g:haskell_enable_pattern_synonyms = 1 " highlighting `pattern`
let g:haskell_enable_typeroles = 1        " highlighting type roles
let g:haskell_enable_static_pointers = 1  " highlighting `static`
let g:haskell_backpack = 1                " highlighting backpack keywords
