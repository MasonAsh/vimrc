""""""""""""""""""""""""""""""""""""""""""""""""""
"                   Plugins                      "
""""""""""""""""""""""""""""""""""""""""""""""""""

" Using vim-plug
call plug#begin('~/vimplug')

" Fuzzy file finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Autocompletion engine for neovim
Plug 'Shougo/deoplete.nvim'
" File explorer
Plug 'scrooloose/nerdtree'
" nice python plugin (requires neovim with python 3 support)
Plug 'python-mode/python-mode', {'branch': 'develop'}
" Syntax hilighting for rust
Plug 'rust-lang/rust.vim'
" Activate code completion engine using tab
Plug 'ervandew/supertab'
" Split arguments onto multiple lines with one convenient mapping
Plug 'FooSoft/vim-argwrap'
" Python indentation
Plug 'Vimjas/vim-python-pep8-indent'
" ripgrep (code searching)
Plug 'jremmen/vim-ripgrep'
" Surround text with '({[ etc
Plug 'tpope/vim-surround'
" Git wrapper
Plug 'tpope/vim-fugitive'
" Easy motion
Plug 'easymotion/vim-easymotion'
" make/lint framework
Plug 'neomake/neomake'
" Racer support for rust completion
Plug 'racer-rust/vim-racer'
" Distraction free mode
Plug 'junegunn/goyo.vim'
" Text alignment (required for vim-markdown)
Plug 'godlygeek/tabular'
" Markdown
Plug 'plasticboy/vim-markdown'
" Commenting code
Plug 'scrooloose/nerdcommenter'
" Personal wiki for notes, etc.
Plug 'vimwiki/vimwiki'
" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Swap text around easily
Plug 'tommcdo/vim-exchange'
" Visual increment
Plug 'triglav/vim-visual-increment'
" Sneak, a very handy motion
Plug 'justinmk/vim-sneak'
" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" typescript
Plug 'mhartington/nvim-typescript'
Plug 'HerringtonDarkholme/yats.vim'
" dracula color scheme
Plug 'dracula/vim'
" Git diff information in number line
Plug 'airblade/vim-gitgutter'
" Switching between tmux and vim windows with same binding
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""
"                   General                      "
""""""""""""""""""""""""""""""""""""""""""""""""""

" Remap leader key to space
let mapleader = " "

" Use shift+enter to go to exit insert mode
" (Note: terminal versions usually can't bind shift+enter)
inoremap <S-CR> <ESC>
inoremap jk <ESC>
inoremap kj <ESC>

" Quickly write a file using <space>s
nnoremap <leader>s :w<cr>
" Quickly write a file then quit using <space>q
nnoremap <leader>q :wq<cr>

" ctrl+j/k deletes blank line above or below cursor, alt+j/k inserts
nnoremap <silent><C-A-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-A-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" map gS to ArgWrap to split parameters onto multiple lines
nnoremap gS :ArgWrap<CR>

" ripgrep with <space>g
nnoremap <leader>r :Rg<space>

" Syntax hilighting by default
syntax on

" Hide buffers when opening a new one instead of closing
set hidden

" Relative line numbers
set number
set relativenumber

" Sane tab defaults
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Needed to allow ctrl+w in insert mode to delete words
set backspace=indent,eol,start

let s:currentFile = expand('<sfile>')

" EVimRC -- handy command to edit this config file
command! EVimRC execute 'edit ' . s:currentFile

" If we have acess to fish or zsh, use the superior shell over bash
if executable('fish')
    set shell=fish
elseif executable('zsh')
    set shell=zsh
endif

" modelines are a potential security issue, so disable them
set modelines=0

" Window navigation mappings
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>

" Hide highlighted text after a search
nnoremap <silent> <leader><cr> :noh<cr>

" Quickly increase and decrease split size with +/-
" CTRL+left/right to increase/decrease vertical split size
if bufwinnr(1)
    nmap + <C-W>+
    nmap - <C-W>-
    nmap <C-right> <C-W>>
    nmap <C-left> <C-W><
endif

" Show line numbers in Goyo
let g:goyo_linenr = 1

" Binds to exit terminal mode easier
tnoremap <Esc> <C-\><C-n>
tnoremap jk    <C-\><C-n>
tnoremap kj    <C-\><C-n>

set mouse=a

inoremap ;; <END>;

inoremap {<CR> {<CR>}<ESC>ko

command! InsertDate :put! =strftime('%m/%d/%y')

set ignorecase smartcase

" Jump to previous file using space space
nmap <leader><leader> <c-^>

nnoremap <tab> :bnext!<cr>
nnoremap <tab> :bprev!<cr><Paste>

" END GENERAL

""""""""""""""""""""""""""""""""""""""""""""""""""
"               Mini Buf Explorer                "
""""""""""""""""""""""""""""""""""""""""""""""""""

let g:miniBufExplBuffersNeeded = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

function! JumpPreviousWindow()
    execute winnr('#') . 'wincmd w'
endfunction

map <silent> <leader>m :MBEFocus<cr>

" Pressing escape within the MBE window will go to the previous window, very
" convenient!
autocmd FileType minibufexpl nnoremap <silent> <buffer> <esc> :call JumpPreviousWindow()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""
"                  NERD Tree                     "
""""""""""""""""""""""""""""""""""""""""""""""""""

" Open NERDTree at startup and then switch back to source window
" autocmd VimEnter * NERDTree
" autocmd VimEnter * wincmd p

nnoremap <leader>l :NERDTreeToggle<cr>

" If NERDTree is the last remaining window then just quit
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


""""""""""""""""""""""""""""""""""""""""""""""""""
"                    Deoplete                    "
""""""""""""""""""""""""""""""""""""""""""""""""""

let g:deoplete#enable_at_startup = 1

let g:deoplete#sources#rust#show_duplicates = 1


""""""""""""""""""""""""""""""""""""""""""""""""""
"                    Neomake                     "
""""""""""""""""""""""""""""""""""""""""""""""""""

" Automatically open error list
" let g:neomake_open_list=2

" Automake when writing a buffer and normal mode changes (after 750ms)
call neomake#configure#automake('nw', 750)

""""""""""""""""""""""""""""""""""""""""""""""""""
"                    fugitive                    "
""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""
"                      FZF                       "
""""""""""""""""""""""""""""""""""""""""""""""""""

" Bind fzf to <space>f
nnoremap <silent><leader>f :Files<CR>
" Quickly search and switch buffers
nnoremap <silent><leader>b :Windows<CR>
" Browse tags
nnoremap <silent><leader>t :Tags<CR>

" Press esc in fzf to close it
autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>

" rust tags with fzf
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
autocmd BufWrite *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" <bar> redraw!


""""""""""""""""""""""""""""""""""""""""""""""""""
"                     pymode                     "
""""""""""""""""""""""""""""""""""""""""""""""""""

let g:pymode_rope_goto_definition_bind = 'gd'

" Default bind is <leader>b which conflicts with my CtrlPBuffer bind
let g:pymode_breakpoint_bind = '<leader>pb'


""""""""""""""""""""""""""""""""""""""""""""""""""
"                     racer                      "
""""""""""""""""""""""""""""""""""""""""""""""""""

au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)


""""""""""""""""""""""""""""""""""""""""""""""""""
"                   UltiSnips                    "
""""""""""""""""""""""""""""""""""""""""""""""""""

" Default <tab> binding conflicts with supertab
let g:UltiSnipsExpandTrigger = "\\t"


""""""""""""""""""""""""""""""""""""""""""""""""""
"                    Airline                     "
""""""""""""""""""""""""""""""""""""""""""""""""""

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'dracula'


""""""""""""""""""""""""""""""""""""""""""""""""""
"                     LaTeX                      "
""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd BufWritePost *.tex :!pdflatex %


""""""""""""""""""""""""""""""""""""""""""""""""""
"              Local Configuration               "
""""""""""""""""""""""""""""""""""""""""""""""""""

" source localconfig.vim for nonportable configurations
let s:localConfigPath = expand('<sfile>:p:h') . '/localconfig.vim'
if filereadable(s:localConfigPath)
    execute 'source ' fnameescape(s:localConfigPath)
endif
