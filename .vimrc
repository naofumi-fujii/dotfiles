if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath^=~/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/'))

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" deoplete.nvim
call dein#add('Shougo/deoplete.nvim')
if !has('nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif
let g:deoplete#enable_at_startup = 1

" Add or remove your plugins here:
call dein#add('easymotion/vim-easymotion')
call dein#add('w0rp/ale')
call dein#add('tpope/vim-surround')
call dein#add('tpope/vim-fugitive')
call dein#add('junegunn/fzf', { 'build': './install', 'rtp': '' })
call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })

call dein#add('airblade/vim-gitgutter')
call dein#add('flazz/vim-colorschemes')
call dein#add('itchyny/lightline.vim')
call dein#add('kana/vim-operator-replace')
call dein#add('kana/vim-operator-user')
call dein#add('mhinz/vim-startify')
call dein#add('osyo-manga/vim-over')
call dein#add('scrooloose/nerdcommenter')
call dein#add('thinca/vim-quickrun')
call dein#add('tpope/vim-abolish')
call dein#add('tpope/vim-endwise')
call dein#add('junegunn/vim-easy-align')
call dein#add('mattn/emmet-vim')
call dein#add('bfredl/nvim-miniyank')
call dein#add('ruanyl/vim-gh-line')

"ruby
call dein#add('vim-ruby/vim-ruby')
call dein#add('tpope/vim-rails')
call dein#add('slim-template/vim-slim')

"vue
call dein#add('posva/vim-vue')

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" private settings from here:

"enable color syntax
syntax on

" color theme
colorscheme railscasts

" highlight horizontal
set cursorline
highlight CursorLine ctermbg=DarkCyan
highlight CursorLine ctermfg=White
highlight Visual term=reverse cterm=reverse ctermfg=DarkRed ctermbg=White

" highlight vertical
set cursorcolumn
highlight CursorColumn ctermbg=Blue
highlight CursorColumn ctermfg=Green

set smartcase
set ignorecase
set number
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
set nofoldenable

" OSX clipboard sharing
set clipboard=unnamed

" vv to select to end of line
vnoremap v $h

" lightline.vim
set laststatus=2

"https://github.com/itchyny/lightline.vim/issues/87
let g:lightline = {
      \ 'component_function': {
      \   'filename': 'LightLineFilename'
      \ }
      \ }
function! LightLineFilename()
  return expand('%')
endfunction

" replace by text-obj
map R <Plug>(operator-replace)

" vim-quickrun
set splitright


fun! OpenCurrentLineByVscode()
  silent exec '!code --goto %:p' . ':' . line(".")
endfun
command! VSCode call OpenCurrentLineByVscode()

let g:NERDCustomDelimiters = {
      \  'ruby' : { 'left': '# ', 'leftAlt': '', 'rightAlt': '' },
      \  'haskell' : { 'left': '-- ', 'leftAlt': '', 'rightAlt': '' }
      \  }

"customize surround.vim
"ASCIIコード表 http://www9.plala.or.jp/sgwr-t/c_sub/ascii.html
let g:surround_35 = "#\r"
let g:surround_38 = "&:\r"
let g:surround_42 = "*\r"
let g:surround_64 = "@\r"

"show json double quotations with vim
set conceallevel=0
let g:vim_json_syntax_conceal = 0

"filetype alias
autocmd BufRead,BufNewFile *.es6 setfiletype javascript
autocmd BufRead,BufNewFile *.rb setfiletype ruby
autocmd BufRead,BufNewFile *.geojson setfiletype json
au! BufRead,BufNewFile *.tt setfiletype html

"easymotion
let g:EasyMotion_do_mapping = 0 "Disable default mappings
let g:EasyMotion_keys='hklyuiopnm,qwertzxcvbasdgjf'
"nmap s <Plug>(easymotion-s2)

set nohlsearch
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

map <Leader><Leader>w <Plug>(easymotion-bd-w)


command! -bang -nargs=* GGrep
      \ call fzf#vim#grep(
      \   'git grep --line-number '.shellescape(<q-args>), 0,
      \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)
nnoremap <silent><C-g> :GGrep<CR>
nnoremap <silent><Leader>g :Gblame<CR>
nnoremap <silent><C-p> :GitFiles<CR>
nnoremap <silent><C-f> :BLines<CR>
nnoremap <silent><C-h> :History<CR>
"open word under cursor
nnoremap <silent><C-]> :Tags <c-r>=expand("<cword>")<cr><CR>

"select deoplete completion with TAB key
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

" no insert after select
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? deoplete#mappings#close_popup() : "\n"
endfunction

let g:startify_bookmarks = [ {'c': '~/.vimrc'}, '~/.zshrc' ]

"brew install fzf
set rtp+=/usr/local/opt/fzf

let g:ale_linters = {
      \ 'html': [],
      \ 'css': ['stylelint'],
      \ 'javascript': ['eslint'],
      \ 'typescript': ['eslint','prettier'],
      \ 'vue': ['eslint','prettier','vls'],
      \ 'rust': ['rls'],
      \ }
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'go': ['gofmt', 'goimports'],
      \ 'vue': ['eslint','prettier'],
      \ 'typescript': ['eslint','prettier'],
      \ 'rust': ['rustfmt'],
      \ }
let g:ale_fix_on_save = 1


"swap semicolon to colon
noremap ; :
noremap : ;

map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)


" http://vim.wikia.com/wiki/Dictionary_completions
au FileType * execute 'setlocal dict+=~/src/github.com/pocke/dicts/ruby.dict'
