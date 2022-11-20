" ale eslint autofix
let g:ale_fixers = { 'javascript': ['eslint'] }
let g:ale_fix_on_save = 1
let g:ale_sign_error = ''
let g:ale_sign_warning = ''

hi ALEErrorSign guibg=#2E3440 guifg=#BF616A 
hi ALEWarningSign guibg=#2E3440 guifg=#EBCB8B

map <leader>l :ALEToggle<CR>

let g:sort_motion_flags = 'ui'

" plug shortcuts
nmap <leader>pc :PackerCompile<CR>
nmap <leader>pi :PackerInstall<CR>
nmap <leader>pu :PackerUpdate<CR>
nmap <leader>pC :PackerClean<CR>

" vim-fugitive show git diff side-by-side
map <leader>gd :Gvdiff<CR>
map <leader>gb :Git blame<CR>

" easymotion greatly improves default f functionality
map f <Plug>(easymotion-bd-f)
" easymotion ignore case on search
let g:EasyMotion_smartcase = 1

map <M-l> :vertical resize +5<CR>
map <M-h> :vertical resize -5<CR>
map <M-j> :resize -5<CR>
map <M-k> :resize +5<CR>

syntax on
colorscheme nordfox

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
set colorcolumn=80 " highlight column 80
set cursorline
set noswapfile
set ruler
set listchars=tab:›\ ,eol:¬,space:⋅ " highlight whitespace
set nolist
set wildmenu
set showmatch
set lazyredraw

map <leader>o :NvimTreeToggle<CR>
map <leader>f :Telescope find_files<cr>
map <leader>gf :GF?<CR>
map <leader>/ :Telescope live_grep<cr> 
map <leader>w :w<CR>
map <leader>bd :bd<CR>
map <leader>bwd :w<CR>:bd<CR>
map <leader>X :x<CR>
map <leader>bD :bd!<CR>
map <leader>bad :%bd<CR>
map <leader>q :q<CR>
map <leader>Q :q!<CR>
map <leader>r :source ~/.config/nvim/init.lua<CR>
map vat va<
map vit vi<
map dat da<
map dit di<
map cat ca<
map cit ci<

map <leader>ev :vsplit 
map <leader>eh :split 
map <leader>v <C-w>v
map <leader>h <C-w>s
map <leader>kp <C-w>q

hi InactiveWindow guibg=#181e2a
set winhighlight=NormalNC:InactiveWindow
