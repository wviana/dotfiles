set nocompatible
let mapleader = " "

filetype plugin indent on         " Load plugins according to detected filetype.
syntax on                         " Enable syntax highlighting.

set autoindent                    " Indent according to previous line.
set breakindent
set expandtab                     " Use spaces instead of tabs.
set softtabstop =4                " Tab key indents by 4 spaces.
set shiftwidth  =4                " >> indents by 4 spaces.
set shiftround                    " >> indents to next multiple of 'shiftwidth'.

set backspace   =indent,eol,start " Make backspace work as you would expect.
set hidden                        " Switch between buffers without having to save first.
set laststatus  =2                " Always show statusline.
set display     =lastline         " Show as much as possible of the last line.

set showmode                      " Show current mode in command-line.
set showcmd                       " Show already typed keys when more are expected.

set incsearch                     " Highlight while searching with / or ?.
set hlsearch                      " Keep matches highlighted.

" Wesley
set ignorecase                    " Search with no case
set smartcase                     " Search with case when there is at least one upper

set ttyfast                       " Faster redrawing.
set lazyredraw                    " Only redraw when necessary.

set splitbelow                    " Open new windows below the current window.
set splitright                    " Open new windows right of the current window.

set cursorline                    " Find the current line quickly.
set nocursorcolumn                 " Find the current column quickly.
set report      =0                " Always report changed lines.
set synmaxcol   =200              " Only highlight the first 200 columns.
set history     =10000
set undofile

set clipboard=unnamed
set guifont=CascadiaCode-Regular:h14

" MacOs only configs
if has('macunix')
    set macmeta
endif



nnoremap <Leader>cn :cnext<CR>


" Goyo
let g:goyo_width=120
nnoremap <F12> :Goyo<CR>

runtime ftplugin/man.vim

nnoremap Q <Nop>

set list                   " Show non-printable characters.

if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
else
    let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif

" The fish shell is not very compatible to other shells and unexpectedly
" breaks things that use 'shell'.
if &shell =~# 'fish$'
  set shell=/bin/bash
endif

" Descriptografa palava embaixo  e joga no clipboard
fu! DecryptIntoClipboad()
    normal g?iW"+yiWU
endfu

fu! PortalAws()
    tab term ++close ssh portal-aws
    term ++close ssh portal-aws2
    term ++close ssh portal-aws3
    term ++close ssh portal-aws4
    windo call term_sendkeys("%", "cd /opt/softbox/wildfly/standalone-2/log/")
    let commando = input("$")
    windo call term_sendkeys("%",  commando . "") 
endfu
nnoremap <Leader>spip :silent call PortalAws()<CR>

fu! SshStreamConsumerHom() 
    tab term ++close ssh stream-consumer-hom 
endfu
nnoremap <Leader>ssch :silent call SshStreamConsumerHom()<CR>

fu! SshStreamConsumerProd() 
    tab term ++close ssh stream-consumer-prod 
endfu
nnoremap <Leader>sscp :silent call SshStreamConsumerProd()<CR>

fu! SshCronAws() 
    tab term ++close ssh cron-aws 
endfu
nnoremap <Leader>scta :silent call SshCronAws()<CR>

nnoremap <Leader>tt :silent tab term<CR>
nnoremap <Leader>st :silent term<CR>

" Terminal mode tmux like bindding
tnoremap <C-b>%  <C-w>:silent vertical term<CR>
tnoremap <C-b>"  <C-w>:silent term<CR>

call plug#begin()
Plug 'tweekmonster/braceless.vim', { 'for': 'python' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'morhetz/gruvbox'
Plug 'Yggdroot/indentLine'
Plug 'vim-scripts/info.vim', { 'on': 'Info' }
Plug 'davidhalter/jedi-vim'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'vim-syntastic/syntastic'
Plug 'mbbill/undotree'
Plug 'tpope/vim-commentary'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-endwise'
Plug 'nvie/vim-flake8', { 'for': 'python' }
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'ludovicchabant/vim-gutentags'
Plug 'michaeljsmith/vim-indent-object'
Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-surround'
Plug 'hashivim/vim-terraform', { 'for': 'terraform' }
Plug 'juliosueiras/vim-terraform-completion', { 'for': 'terraform' }
Plug 'wakatime/vim-wakatime'
Plug 'Shougo/vimproc'
Plug 'Shougo/vimshell.vim'
Plug 'vimwiki/vimwiki'
call plug#end()


set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/tmp/*,*.swp
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_max_depth = 200
let g:ctrlp_max_files = 100000
let g:ctrlp_extensions=['autoignore']

" JavaComplete2
autocmd FileType java setlocal omnifunc=javacomplete#Complete

" Sintastic Java
let g:syntastic_java_checkers=['javac']
let g:syntastic_java_javac_config_file_enabled = 1

" Syntastic Python
let g:syntastic_python_checkers = ["pylama"]

" Braceless " TODO: Check if you want it all
autocmd FileType python BracelessEnable +indent +highlight +fold

set number
set relativenumber
nnoremap <Leader>rn :set relativenumber!<CR>
set wildmenu


" Gutentags
let g:gutentags_ctags_executable = '/usr/local/Cellar/universal-ctags/HEAD-9630c39/bin/ctags'
let g:gutentags_define_advanced_commands = 1
let g:gutentags_file_list_command = 'rg --files'

" """""""""""""""""""""""""""""""""""""""""""
" " These are my own scripts/configurations "
" """""""""""""""""""""""""""""""""""""""""""

" Better terminal
" 
" This script intent to create a bunch of short cuts that mimic tmux
" keybinds, if you never been a tmux user, latter I will explain why I did
" wrote these binds and those two little functions.
"
" There probably will be some people that will not care about the keybinds,
" so just jump into the :vim_terminal: session
"
" Tmux like keybinds
"
" If you do already know tmux just jump into the keybinds to refresh your
" memory or/and check if I'm not adding something different than what you
" alread know. If you stayed here, I'm going to explain you what is prefix 
" keybind. So according to their own man page:
"
"
" > tmux may be controlled from an attached client by using a key combination
" > of a prefix key, `C-b' (Ctrl-b) by default, followed by a command key.
"
" So if I tell you to do a `prefix + "`  you'll hold control, press b, release
" the b and control keys, than pess the `"` key. In some keyboards, problaby
" most it will be necessary to hold shift to acheive it.
"
" Here is the keybinds:
"   Keybind     Function
"   Ctrl+b
tmap     <silent> <C-b>% ::vertical terminal<CR>
nnoremap <silent> <Leader><C-b>% :vertical terminal<CR>
tmap     <silent> <C-b>" ::terminal<CR>
nnoremap <silent> <Leader><C-b>" :silent  terminal<CR>
tmap     <silent> <C-b>c ::tab terminal<CR>
nnoremap <silent> <Leader><C-b>c :tab terminal<CR>
tmap     <silent> <C-b>n ::tabnext<CR>
tmap     <silent> <C-b>p ::tabprevious<CR>
" Improving jumping into vims command mode and normal mode.
" Makes you fell that the terminal is more integrated.
tnoremap :: <C-w>:
tnoremap <C-Esc> <C-w>N
" Resize when changing to normal mode, so no wrap
fu! ResizeTerminalForNormalMode()
    let b:terminal_mode_columns = term_getsize('%')[1]
    let l:terminal_current_line = line("$")
    let l:size_to_increase      = max([strlen(l:terminal_current_line), 3]) + 1
    let l:new_window_width      = b:terminal_mode_columns + l:size_to_increase
    execute 'vertical resize' l:new_window_width
endfu

fu! RestoreTerminalForInsertMode()
    execute 'vertical resize' b:terminal_mode_columns
endfu

augroup BetterTerminal
    autocmd!
    autocmd CursorMoved  * if &buftype == 'terminal' && mode() == 'n' | call ResizeTerminalForNormalMode()| endif
    autocmd TerminalOpen * nnoremap <buffer> <silent> i :call RestoreTerminalForInsertMode()<CR>i
augroup end

"" Temporary Color fix
au TerminalOpen * call term_setansicolors('%', ['#1d2021', '#cc241d', '#98971a', '#d79921', '#458588', '#b16286', '#689d6a', '#928374', '#928374', '#fb4934', '#b8bb26', '#fabd2f', '#83a598', '#d3869b', '#8ec07c', '#7c6f64']) 


" Colorscheme
colorscheme gruvbox
set background=dark

" NERDTree
nnoremap <Leader>nt :NERDTreeToggle<CR>
let g:NERDTreeShowBookmarks=1
let g:NERDTreeShowLineNumbers=1


" Grep and CtrlP
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading\ --color=never
    set grepformat=%f:%l:%c:%m,%f:%l:%m
    let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
    let g:ctrlp_use_caching = 0
endif

" Lightline 
let g:lightline = { 
    \'component': { 'time':  "%{strftime('%b %d %H:%M')}" },
    \'active': {
        \'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype', 'time' ] ]
    \}
\}

" EasyAlign
vmap <Leader>al <Plug>(EasyAlign)

" Spell
fu! ActivateSpellAndSetLanguage(lang)
    set spell
    let &spelllang=a:lang
    echo 'Spell is: ' &spell 
    echo 'Spell language was set to: ' &spelllang
endfu

nmap <Leader>se call ActivateSpellAndSetLanguage('en')
nmap <Leader>sp call ActivateSpellAndSetLanguage('pt')

