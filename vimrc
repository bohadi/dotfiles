" vimrc
"
"
set foldmethod=manual      " Automatically create folds for each indent
"au BufWinLeave * mkview     " Automatically save and load folds
"au BufWinEnter * silent loadview

set noswapfile
set nobackup
set nocp                    " Enable plugins

" ---- General Setup ----
set fileencoding=utf8
set completeopt-=preview   " no scratch preview pane for omnicomp
set nocompatible           " Don't emulate vi's limitations
set list listchars=tab:->,trail:.,extends:>,nbsp:_
"set smarttab              " Tab next line based on current line
set tabstop=2              " 2 spaces for tabs
set softtabstop=2
set shiftwidth=2
set copyindent
set preserveindent
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
set number "enable line numbering
set relativenumber
"set nolist
set clipboard=unnamedplus
colorscheme darkblue
highlight Search ctermfg=white ctermbg=205
highlight Comment cterm=italic

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

hi StatusLine                   ctermbg=black
hi Pmenu      ctermfg=lightgrey ctermbg=black
hi PmenuSel   ctermfg=lightgrey ctermbg=darkmagenta

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
"if (v:version >= 700)
"   set spelllang=en_us        " US English Spelling please
   " Toggle spellchecking with F10
"   nmap <silent> <F10> :silent set spell!<CR>
"   imap <silent> <F10> <C-O>:silent set spell!<CR>
"endif

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
"if (v:version == 603 && has("patch045")) || (v:version > 603)
"   set modeline
"else
"   set nomodeline
"endif

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
map  <F8> :.w !bash<CR>
imap <F8> <Esc>:.w !bash<CR>i
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

"map <silent> tw :GhcModTypeInsert<CR>
"map <silent> ts :GhcModSplitFunCase<CR>
"map <silent> tt :GhcModType<CR>
"map <silent> te :GhcModTypeClear<CR>

"k/maude syntax
"TODO fix transparency
"au BufRead,BufNewFile *.k set filetype=kframework
"au! Syntax kframework source kframework.vim
"syn on

au BufRead,BufNewFile *.lox set filetype=lox

nmap     <C-F>f <Plug>CtrlSFCwordPath
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

let g:EasyMotion_do_mapping = 0
map <Leader> <Plug>(easymotion-overwin-f2)
let g:EasyMotion_smartcase = 1

let g:vimwiki_list = [ { 'path':'wiki' } ]

" Maps Coquille commands to <F2> (Undo), <F3> (Next), <F4> (ToCursor)
au BufRead,BufNewFile *.v set filetype=coq
au FileType coq call coquille#FNMapping()

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:minimap_highlight='Keyword'

" js tabs : 2 space
au FileType javascript setl sw=2 sts=2 et

let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{next}"}

if executable('rls')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'rls',
    \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
    \ 'whitelist': ['rust'],
    \ })
endif

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  nmap <buffer> <f1> <plug>(lsp-document-diagnostics)
  nmap <buffer> <f2> <plug>(lsp-hover)
  nmap <buffer> <f3> <plug>(lsp-references)
  nmap <buffer> <f4> <plug>(lsp-rename)
  nmap <buffer> gd <plug>(lsp-peek-definition)
  nmap <buffer> gD <plug>(lsp-definition)
  nmap <buffer> <f5> <plug>(lsp-previous-diagnostic)
  nmap <buffer> <f6> <plug>(lsp-next-diagnostic)
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
"Plug 'powerline/powerline',
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes',
"Plug 'edkolev/tmuxline.vim',
Plug 'scrooloose/nerdtree'
Plug 'dag/vim-fish',
Plug 'tpope/vim-surround',
Plug 'idris-hackers/idris-vim',
Plug 'neovimhaskell/haskell-vim',
"Plug 'eagletmt/ghc-mod',
"Plug 'eagletmt/neco-ghc',
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'wincent/terminus'
"Plug 'easymotion/vim-easymotion',
Plug 'LnL7/vim-nix',
"Plug 'vimwiki/vimwiki', { 'branch':'dev' }
Plug 'let-def/vimbufsync',
Plug 'jvoorhis/coq.vim',
Plug 'the-lambda-church/coquille',
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'vim-ruby/vim-ruby' 
Plug 'tpope/vim-rails' 
Plug 'tpope/vim-obsession' 
Plug 'severin-lemaignan/vim-minimap'
Plug 'justinmk/vim-sneak' 
Plug 'jpalardy/vim-slime' 
Plug 'wlangstroth/vim-racket'
Plug 'cespare/vim-toml'
"Plug 'christoomey/vim-tmux-navigator'
"Plug 'cy2081/vim-cyim',
Plug 'rust-lang/rust.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()

