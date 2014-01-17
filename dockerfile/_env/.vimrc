set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" Original bundles here:
"
" original repos on GitHub
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
" non-GitHub repos
Bundle 'git://git.wincent.com/command-t.git'
" Git repos on your local machine (i.e. when working on your own plugin)
" Bundle 'file:///Users/gmarik/path/to/plugin'

" My bundles here
Bundle 'vim-scripts/twilight256.vim'
Bundle 'kchmck/vim-coffee-script'

syntax enable
filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle commands are not allowed.

colorscheme twilight256

noremap <C-P> :FufCoverageFile <CR>

" higlight search syntax
if &t_Co > 2
	syntax on
	set hlsearch
endif

" set backup dir
set backup
set backupdir=~/.vim-backup,.,~/

" temporary files
set directory=~/.vim-backup,.,/tmp

" buffers and history
set confirm
set viminfo='50,\"500
set history=200

" interactive search highligh while typing
set incsearch

" autocomplete file names and commands
set wildchar=<Tab>
set wildmenu
set wildmode=longest:full,full

" cursor position
set rulerformat=%3b\ \ %l,%c%V%=%P

" closing brackets control
set showmatch

" title
let &titlestring=expand("%:t")

" minimal number of lines before and after cursor
set scrolloff=6

" minimal number of columns before and after cursor
set sidescroll=10

" autoindent
set autoindent

" smartindent
set smartindent

" disable double spaces after chars ".", ",", "?"
set nojoinspaces

" wrap lines
set wrap

" number lines
set number

" replace highlighted text by text from register (visual mode)
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" disable bracket highlighting
:let loaded_matchparen = 1

" filetype syntax
augroup filetype
	au!
	au! BufRead,BufNewFile *.js.php    set filetype=javascript
	au! BufRead,BufNewFile *.css.php   set filetype=css
	au! BufRead,BufNewFile *.sql.php   set filetype=mysql
	au! BufRead,BufNewFile *.conf.m4   set filetype=apache
	au! BufRead,BufNewFile *.php*.tmp  set filetype=php
augroup END

" PHP run command (CTRL-M)
" :autocmd FileType php noremap <C-M> :!/usr/bin/env php %<CR>
:autocmd FileType php noremap <C-M> :!/usr/bin/clear && /usr/local/bin/php %<CR>

" PHP parser check (CTRL-L)
" :autocmd FileType php noremap <C-L> :!/usr/bin/env php -l %<CR>
:autocmd FileType php noremap <C-L> :!/usr/bin/clear && /usr/local/bin/php -l %<CR>

" No smartindent, No autoindent
nmap <C-A> :set nosmartindent noautoindent<CR>

" Use the same symbols as TextMate for tabstops and EOLs
nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" Omni completion
filetype plugin on
set omnifunc=syntaxcomplete#Complete
