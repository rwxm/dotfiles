" Plug things
call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))

" Themes
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Surround and comment
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'vimwiki/vimwiki'

" File browse and find
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'preservim/nerdtree'

" Web Dev
Plug 'mattn/emmet-vim'
Plug 'alvan/vim-closetag'

" Syntax
Plug 'HerringtonDarkholme/yats.vim'
Plug 'yuezk/vim-js'
Plug 'ap/vim-css-color'

" Misc
Plug 'junegunn/goyo.vim'
Plug 'jreybert/vimagit'
Plug 'kovetskiy/sxhkd-vim'
call plug#end()

" Set things
set nocompatible
set encoding=utf-8

set bg=dark
set go=a
set mouse=a
" set cursorline
" set cursorcolumn
set colorcolumn=80
set t_Co=256
set number relativenumber
set nohlsearch
set incsearch
set clipboard+=unnamedplus

set smarttab
set cindent
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set noswapfile
" set nobackup
set undodir=~/.config/nvim/undodir
set undofile

set wildmode=longest,list,full " Enable autocompletion
set splitbelow splitright " Split open at the bottom and right

" Let things
let mapleader =" "
let g:airline_powerline_fonts = 1 " Enable powerline fonts
let g:airline_theme='luna'
" let g:user_emmet_leader_key='<A-c>'

" More things
syntax on
filetype plugin on
colorscheme gruvbox
highlight ColorColumn ctermbg=0 guibg=lightgrey

" Map things
inoremap jk <ESC>
nnoremap c "_c

" Replace all is aliased to S
nnoremap S :%s//g<Left><Left>

" Undo tree
nnoremap <leader>u :UndotreeToggle<CR>

" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Shortcutting split navigation, saving a keypress
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Goyo plugin makes text more readable when writing prose
map <leader>f :Goyo \| set bg=dark \| set linebreak<CR>

" Spell-check set to <leader>o, 'o' for 'orthography'
map <leader>o :setlocal spell! spelllang=en_us<CR>

" Replace ex mode with gq
map Q gq

" Check file in shellcheck
map <leader>s :!clear && shellcheck %<CR>

" Open bibliography file in split
map <leader>b :vsp<space>$BIB<CR>
map <leader>r :vsp<space>$REFER<CR>

" Compile document, be it groff/LaTeX/markdown/etc
map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
map <leader>p :!opout <c-r>%<CR><CR>

" Ensure files are read as what I want
let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
map <leader>v :VimwikiIndex
let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex

" Enable Goyo by default for mutt writting
autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo | set bg=dark
autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>

" Automatically deletes all trailing whitespace and newlines at end of file on save
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritepre * %s/\n\+\%$//e

" When shortcut files are updated, renew bash and ranger configs with new material
autocmd BufWritePost files,directories !shortcuts
" Run xrdb whenever Xdefaults or Xresources are updated
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
" Update binds when sxhkdrc is updated
autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

" Disable auto commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Fold text
" autocmd BufWinLeave *.* mkview
" autocmd BufWinEnter *.* silent loadview

" Runs a script that cleans out tex build files whenever I close out of a .tex file
autocmd VimLeave *.tex !texclear %
" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable
if &diff
    highlight! link DiffText MatchParen
endif

" Vim fzf
nnoremap <A-g> :GFiles<CR>
nnoremap <A-z> :Files<CR>
let g:fzf_preview_window = 'right:60%'

command! -bang -nargs=? -complete=dir Files
   \ call fzf#vim#files(<q-args>, {'options': ['--preview', 'preview {}']}, <bang>0)
command! -bang -nargs=? -complete=dir GFiles
   \ call fzf#vim#gitfiles(<q-args>, {'options': ['--preview', 'preview {}']}, <bang>0)

" Nerd tree
map <leader>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  if has('nvim')
    let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
  else
    let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
  endif
