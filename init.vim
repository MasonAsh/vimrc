" source localconfig.vim for nonportable configurations
let s:localConfigPath = expand('<sfile>:p:h') . '/localconfig.vim'
if filereadable(s:localConfigPath)
    execute 'source ' fnameescape(s:localConfigPath)
endif

""""""""""""""""""""""""""""""""""""""""""""""""""
"                   Plugins                      "
""""""""""""""""""""""""""""""""""""""""""""""""""

" Using vim-plug
call plug#begin('~/vimplug')

" Automatically insert matching '({[ etc.
Plug 'jiangmiao/auto-pairs'
" Fuzzy file finder 
Plug 'ctrlpvim/ctrlp.vim'
" Autocompletion engine for neovim
Plug 'Shougo/deoplete.nvim'
" Deoplete for rust (via racer)
Plug 'sebastianmarkow/deoplete-rust'
" Allows browsing buffers easily
Plug 'fholgado/minibufexpl.vim'
" File explorer
Plug 'scrooloose/nerdtree'
" nice python plugin (requires neovim with python 3 support)
Plug 'python-mode/python-mode'
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

" ctrl+j/k deletes blank line above or below cursor, alt+j/k inserts
nnoremap <silent><C-A-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-A-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" map gS to ArgWrap to split parameters onto multiple lines
nnoremap gS :ArgWrap<CR>

" ripgrep with <space>g
nnoremap <leader>g :Rg<space>

" Syntax hilighting by default
syntax on

" Hide buffers when opening a new one instead of closing
set hidden

" Relative line numbers
set number
set relativenumber

" Great theme
colorscheme molokai
" Even greater with 256 colors
let g:rehash256 = 1

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

" Bind ctrlp to <space>f
let g:ctrlp_map = '<leader>f'

" Use context sensitive supertab completion
let g:SuperTabDefaultCompletionType = 'context'

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

map <silent> <leader>t :MBEFocus<cr>

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

if exists('g:racer_path')
    let g:deoplete#sources#rust#racer_binary = g:racer_path
else
    if !empty($RACER_PATH)
        let g:deoplete#sources#rust#racer_binary = '$RACER_PATH'
    elseif executable('racer')
        let g:deoplete#sources#rust#racer_binary = systemlist('which racer')[0]
    endif
endif

" localconfig.vim can fill out g:rust_source_path
if exists('g:rust_source_path') 
    let g:deoplete#sources#rust#rust_source_path = g:rust_source_path
else
    " Otherwise try and figure it out manually
    if !empty($RUST_SRC_PATH)
        let g:deoplete#sources#rust#rust_source_path = '$RUST_SRC_PATH'
    elseif executable('rustc')
        " if src installed via rustup, we can get it by running 
        " rustc --print sysroot then appending the rest of the path
        let rustc_root = systemlist('rustc --print sysroot')[0]
        " eliminate any trailing or prefixing whitespace 
        let rustc_src_dir = rustc_root . '/lib/rustlib/src/rust/src'
        if isdirectory(rustc_src_dir)
            let g:deoplete#sources#rust#rust_source_path = rustc_src_dir
        endif
    endif
endif

let g:deoplete#sources#rust#show_duplicates = 1

