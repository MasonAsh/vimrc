# vimrc
My personal vimrc (meant for use with neovim)

Been building up this vimrc for a while now. Figured I might as well add it to github.

# Features

## Plugins
Uses vim-plug:

* ['jiangmiao/auto-pairs']('jiangmiao/auto-pairs')
* ['ctrlpvim/ctrlp.vim']('ctrlpvim/ctrlp.vim')
* ['Shougo/deoplete.nvim']('Shougo/deoplete.nvim')
* ['sebastianmarkow/deoplete-rust']('sebastianmarkow/deoplete-rust')
* ['fholgado/minibufexpl.vim']('fholgado/minibufexpl.vim')
* ['scrooloose/nerdtree']('scrooloose/nerdtree')
* ['python-mode/python-mode']('python-mode/python-mode')
* ['rust-lang/rust.vim']('rust-lang/rust.vim')
* ['ervandew/supertab']('ervandew/supertab')
* ['FooSoft/vim-argwrap']('FooSoft/vim-argwrap')
* ['Vimjas/vim-python-pep8-indent']('Vimjas/vim-python-pep8-indent')
* ['jremmen/vim-ripgrep']('jremmen/vim-ripgrep')
* ['tpope/vim-surround']('tpope/vim-surround')
* ['tpope/vim-fugitive']('tpope/vim-fugitive')
* ['easymotion/vim-easymotion']('easymotion/vim-easymotion')

## Local configuration
You can put your own custom configurations in a file called `localconfig.vim` next to your 
init.vim file. 

## :EVimRC
Quickly edit the vim config file using `:EVimRC`

## MiniBufExpl
Provides a window at the top for easily switching between buffers.

MiniBufExpl window is enabled by default. Use `<leader>t` to jump to it.

Additionally if you press `<esc>` within the window it will take you back to 
the previous window (this functionality is not built into MiniBufExpl)

## Deoplete with rust configuration
Rust autocompletion will work out of the box assuming you've installed the rust sources using rustup and racer is in your PATH.

To install the rust sources with rustup:

```
rustup component add rust-src
```

To install racer:

```
cargo install racer
```

If you've installed rust's sources differently or racer isn't in your path then you can set the following variables
in localconfig.vim:

```
let g:rust_source_path = '/path/to/rust/src'
let g:racer_path = '/path/to/racer'
```

## Keymaps

`<leader>` is mapped to `<space>`

### General bindings
SHIFT+enter for to exit insert mode (only works for gui versions of vim)

```
inoremap <S-CR> <ESC>
```

Alternatively: 

```
inoremap jk <ESC>
inoremap kj <ESC>
```

Save a file with:
```
<leader>s
```

Save a file and quit with:
```
<leader>q
```

Insert/remove lines above or below the cursor with ALT+j/k or CTRL+ALT+j/k

```
nnoremap <silent><C-A-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-A-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>
```

### ArgWrap
Split an argument list onto multiple lines using `gS`

### RipGrep
Use rip-grep to search code using:
`<leader>q`

NOTE: rip-grep must be installed and in your PATH for this to work.

### Window Navigation
You can use CTRL+h,j,k,l or alternatively use ALT+arrow keys

### NERDTree

Toggle with `<leader>l`

### CtrlP
Remapped to `<leader>f`

### MiniBufExpl
Focus MBE with `<leader>t`

