set nocompatible    " gets rid of vi compatibility

if !isdirectory($HOME . '/.vim/bundle/vundle')
    let choice = confirm("Would you like to install plugins?", "&yes\n&no")
    if choice == 1
        let cmd = "git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle"
        silent exec '!'.cmd
        if !v:shell_error
            autocmd VimEnter * PluginInstall 
        endif
    else 
        let nobundle = 1
    endif
endif

if !exists("nobundle")
    filetype off

    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc() 

    " let Vundle manage Vundle
    Plugin 'gmarik/vundle'

    " original repos on github
    Plugin 'morhetz/gruvbox'
    Plugin 'easymotion/vim-easymotion'

    "Swap argument order with >,
    Plugin 'PeterRincker/vim-argumentative'     

    " Auto closes brackets etc
    Plugin 'Raimondi/delimitMate'               

    " Autocomplete
    " brew install cmake
    " cd ~/.vim/bundle/YouCompleteMe && ./install.sh
    Plugin 'Valloric/YouCompleteMe'             

    " Javascript for YouCompleteMe
    " cd ~/.vim/bundle/tern_for_vim && npm install
    Plugin 'marijnh/tern_for_vim'               

    " JSON syntax highlighter
    Plugin 'helino/vim-json'

    " Shows git diff info in the gutter
    Plugin 'airblade/vim-gitgutter'

    " For indenting and highlighting
    Plugin 'pangloss/vim-javascript'

    " Syntax checking plugin, needs a checker like JSHint
    Plugin 'scrooloose/syntastic'

    " Javascript Syntax checker
    " sudo npm install -g jshint
    Plugin 'walm/jshint.vim'

    " tpope time
    Plugin 'tpope/vim-sensible'
    Plugin 'tpope/vim-surround'




    filetype plugin indent on     " required! 
endif

set t_Co=256
set background=dark
colorscheme gruvbox

set expandtab       " inserts shiftwidth spaces when a tab is pressed
set shiftwidth=4    " how many spaces to a tab
set tabstop=4       " how wide a tab character is
set softtabstop=4   " no of spaces backspace deletes
set encoding=utf-8
set hidden                  " hides buffers instaed of closing them
set showmode                " shows current mode on cmd line
set wildmode=list:longest   " selections the longest command to compelete
set wildignore=*.swp,*.bak,*.pyc,*.class
set visualbell              " replaces error noise with visual
set cursorline              " highlights the cursor line
set ttyfast                 " helps with copypasta
set mouse=a                 " allows mouse control
set nobackup
set noswapfile
set pastetoggle=<F2>

if v:version >=703
    set relativenumber          " makes line number relative to current line
    set undofile                " undo history stored in seperate file
else
    set number
endif

"Can be used to remap leader key, default is \
""let mapleader = ","         

" Searching / Moving
" insert \v before searches to bypass crazy vim regex 'handling'
nnoremap / /\v
vnoremap / /\v
set ignorecase      " searches ignore case if all lowercase
set smartcase       " but search case sensitive is there is a cap
set showmatch
set hlsearch        " these three highligh searches
" remaps ',<space>' to clear highlighting
nnoremap <leader><space> :noh<cr>

set list            " shows invisible characters
set listchars=tab:▸\ ,eol:¬,trail:-,extends:>,precedes:<,nbsp:+


" smart line moving
nnoremap j gj
nnoremap k gk
inoremap jj <ESC>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader Key Bindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <leader><F3> :NERDTreeToggle <CR>
" reloads current buffer (used for editing vimrc)
noremap <leader><F12> :so % <CR>
noremap <leader>w :set wrap!<CR>
" tab completion
inoremap <leader><tab> <c-n>

" reselect text that was just pasted
nnoremap <leader>v V`]
" open new vertical split
nnoremap <leader>s <C-w>v<C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EasyMotion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `f{char}{label}`
nmap f <Plug>(easymotion-s)
" or
" `f{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap <Leader>f <Plug>(easymotion-s2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2
" Format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*


function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction
