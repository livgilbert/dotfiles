call plug#begin(expand('~/.vim/plugged'))
Plug 'arcticicestudio/nord-vim'
Plug 'lervag/vimtex'
Plug 'sirver/ultisnips'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-surround'
Plug 'ycm-core/YouCompleteMe'

Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'
Plug 'itchyny/lightline.vim'
Plug 'farmergreg/vim-lastplace'
Plug 'LunarWatcher/auto-pairs'
Plug 'mhinz/vim-signify'
Plug 'neoclide/vim-jsx-improve'
call plug#end()

set encoding=utf-8

set nocompatible
filetype on
filetype plugin on
filetype plugin indent on
filetype indent on
syntax on
syntax enable
set number
set relativenumber
set cursorline
set incsearch
set ignorecase
set smartcase
set showmode
set showmatch
set hlsearch

set noshowmode
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \ 'right': [['lineinfo', 'charvaluehex'], ['filetype'],]
      \}, 'component': {'charvaluehex': '0x%B'}
      \}

set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

set statusline=
set statusline+=\ %F\ %M\ %Y\ %R
set statusline+=%=
set statusline+=\ %l\ %c\ 0x%B
set laststatus=2

let g:vimtex_view_method = 'zathura'
let g:text_flavor = 'latex'
let g:vimtex_quickfix_mode = 0
set conceallevel=1
let g:tex_conceal='abdmg'

let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips/'
let g:UltiSnipsSnippetDirectories = ["UltiSnips"]

let g:nord_cursor_line_number_background = 1
let g:nord_bold_vertical_split_line = 1
let g:nord_bold = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1

augroup nord-theme-overrides
  autocmd!
  " override line number colors
  autocmd ColorScheme nord highlight LineNr ctermfg=16 cterm=italic
  autocmd ColorScheme nord highlight CursorLineNr cterm=bold ctermbg=none

  " override highlight color
  autocmd ColorScheme nord highlight CursorLine ctermbg=none

  " override comment color
  autocmd ColorScheme nord highlight Comment ctermfg=16
augroup END

colorscheme nord

let g:ycm_keep_logfiles = 1
let g:ycm_log_level = 'debug'
let g:ycm_filetype_blacklist = {
      \ 'tex': 1
      \}

let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_key_list_select_completion = ["<C-n>"]
let g:ycm_key_list_previous_completion = ["<C-p>"]
let &rtp .= ',' . expand( '<sfile>:p:h' )
filetype plugin indent on

set spell spelllang=en_us
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Start NERDTree, unless a file or session is specified, eg. vim -S session_file.vim.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | NERDTree | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

let NERDTreeNaturalSort = 1

set wrap
set linebreak
set autoindent
set smartindent
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

command! -bang -range=% -complete=file -nargs=* W <line1>,<line2>write<bang> <args>
command! -bang Q quit<bang>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" vim-signify
set updatetime=100
let g:signify_sign_change = '~'

