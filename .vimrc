"" unlet! skip_defaults_vim
"" source $VIMRUNTIME/defaults.vim

let mapleader = "\<Space>"

call plug#begin()
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mkitt/tabline.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'airblade/vim-gitgutter'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'christoomey/vim-sort-motion'
Plug 'easymotion/vim-easymotion'
Plug 'w0rp/ale'
call plug#end()

" ale eslint autofix
let g:ale_fixers = { 'javascript': ['eslint'] }
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_fix_on_save = 0
map <leader>l :ALEToggle<CR>

let g:NERDTreeShowHidden=1

let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_idx_mode=1
let g:airline_powerline_fonts=1
let g:airline_detect_modified=1
let g:airline_section_b='%-0.100{getcwd()}'
let g:airline_section_c='%t'
let g:airline_theme='light'
let g:airline_left_sep=''
let g:airline_left_alt_sep=''
let g:airline_right_sep=''
let g:airline_right_alt_sep=''

if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = ' '

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.colnr=''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.maxlinenr=' |'
let g:airline_symbols.linenr = ' -'

let g:sort_motion_flags = 'ui'

" vim-fugitive show git diff side-by-side
map <leader>gd :Gvdiff<CR>

" easymotion greatly improves default f functionality
map f <Plug>(easymotion-bd-f)
" easymotion ignore case on search
let g:EasyMotion_smartcase = 1

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

map - :vertical resize -5<CR>
map = :vertical resize +5<CR>
map _ :resize -5<CR>
map + :resize +5<CR>
map J <C-w>h
map I <C-w>k
map K <C-w>j
map L <C-w>l

syntax on
colorscheme onedark

filetype indent on " turn auto indent on
set tabstop=4 " set tab size in spaces (manual indenting)
set shiftwidth=4 " number of spaces inserted for tab (auto indenting)
set expandtab " convert tabs to spaces
set number " turn on line numbers
set ignorecase " ignore case on search by default
set nowrap " turn off word wrap
set diffopt+=iwhite
set mouse=a
set clipboard+=unnamed
map <leader>o :NERDTreeToggle<CR>
map <leader>f :Files<CR>
map <leader>gf :GF?<CR>
map <leader>/ :execute 'Rg ' . input('Rg/')<CR>
map <leader>wf :w<CR>
map <leader>cf :w<CR>:bd<CR>
map <leader>Cf :bd!<CR>
map <leader>caf :%bd<CR>
map <leader>cw <C-w>c
map <leader>r :source ~/.vim/.vimrc<CR>
map vat va<
map vit vi<
map dat da<
map dit di<
map cat ca<
map cit ci<

map <leader>v :split 
map <leader>h :vsplit 
