" Skeletal's Vimrc

" Init
set nocompatible    " gets rid of vi compatibility
set modelines=0     " prevents modelines security exploits
if !isdirectory($HOME . '/.vim/bundle/vundle')
    let choice = confirm("Would you like to install plugins?", "&yes\n&no")
    if choice == 1
        let cmd = "git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle"
        silent exec '!'.cmd
        if !v:shell_error
            autocmd VimEnter * BundleInstall 
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
    Bundle 'gmarik/vundle'

    " My Bundles here:
    "
    " original repos on github
    Bundle 'scrooloose/nerdtree'
    Bundle 'Lokaltog/vim-easymotion'
    " Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}

    " vim-scripts repos
    "" Bundle 'L9'
    " Bundle 'FuzzyFinder'
    Bundle 'taglist.vim'
    Bundle 'OmniCppComplete'
    " non github repos
    Bundle 'git://git.wincent.com/command-t.git'
    " ...

    filetype plugin indent on     " required! 
endif
syntax enable
"colorscheme skeletal

if &t_Co >= 256 || has("gui_running")
    colorscheme zenburn
endif


""""GENERAL""""

" Dealing With Tabs
set expandtab       " inserts shiftwidth spaces when a tab is pressed
set shiftwidth=4    " how many spaces to a tab
set tabstop=4       " how wide a tab character is
set softtabstop=4   " no of spaces backspace deletes

set encoding=utf-8
set hidden                  " hides buffers instaed of closing them
set scrolloff=3             " starts scrolling when cursor is 3 lines from top/bottom
set autoindent              " smart indenting
set showmode                " shows current mode on cmd line
set showcmd                 " shows current cmd as you type it
set wildmenu                " wildcard completion of commands
set wildmode=list:longest   " selections the longest command to compelete
set wildignore=*.swp,*.bak,*.pyc,*.class
set visualbell              " replaces error noise with visual
set cursorline              " highlights the cursor line
set ttyfast                 " helps with copypasta
set ruler                   " relative cursor position shown bottom right
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

" Can be used to remap leader key, default is \
""let mapleader = ","         

" Searching / Moving
" insert \v before searches to bypass crazy vim regex 'handling'
nnoremap / /\v
vnoremap / /\v
set ignorecase      " searches ignore case if all lowercase
set smartcase       " but search case sensitive is there is a cap
set gdefault        " does s/foo/bar/g by default
set incsearch       " shows search matches as you type
set showmatch
set hlsearch        " these three highligh searches
" remaps ',<space>' to clear highlighting
nnoremap <leader><space> :noh<cr>
" remaps tab to match brackets
nnoremap <tab> %

" folding
set foldmethod=syntax
set foldnestmax=1


set list            " shows invisible characters
set listchars=tab:▸\ ,eol:¬

" smart line moving
nnoremap j gj
nnoremap k gk
inoremap jj <ESC>

au FocusLost * :wa  " saves the file whenever focus is lost
au BufWinLeave * mkview " saves folds when exiting
au BufWinEnter * silent loadview " loads folds on opening

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader Key Bindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <leader><F3> :NERDTreeToggle <CR>
" reloads current buffer (used for editing vimrc)
noremap <leader><F12> :so % <CR>
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

set backspace+=indent,eol,start

""""""""""""""""""""""""""""""
" => Statusline                 TODO: Get Statusline to work properly
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2
" Format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open NERDTree by default
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

let NERDTreeShowHidden=1

""""""""""""""""""""""""""""""""
" => Nerdtree autoquit function
""""""""""""""""""""""""""""""""
function! NERDTreeQuit()
    redir => buffersoutput
    silent buffers
    redir END
    "                     1BufNo  2Mods.     3File           4LineNo
    let pattern = '^\s*\(\d\+\)\(.....\) "\(.*\)"\s\+line \(\d\+\)$'
    let windowfound = 0

    for bline in split(buffersoutput, "\n")
        let m = matchlist(bline, pattern)

        if (len(m) > 0)
            if (m[2] =~ '..a..')
                let windowfound = 1
            endif
        endif
    endfor

    if (!windowfound)
        quitall
    endif
endfunction
autocmd WinEnter * call NERDTreeQuit()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TagList Shit
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists('loaded_taglist')
let Tlist_GainFocus_On_ToggleOpen=1
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_running")
    set guifont=Inconsolata:h12
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Easy Motion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists('g:EasyMotion_loaded')
let g:EasyMotion_leader_key = '<Leader>]'
hi EasyMotionShade  ctermbg=none ctermfg=blue
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OmniCompletionOptions for c++ (.cpp)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let OmniCpp_MayCompleteDot = 1 " autocomplete with .
let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
let OmniCpp_SelectFirstItem = 2 " select first item (but don't insert)
let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included files
let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype (i.e. parameters) in popup window
" -- ctags --
" map <ctrl>+F12 to generate ctags for current folder:
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>
" add current directory's generated tags file to available tags
set tags+=./tags
set tags+=~/.vim/tags/cpp

