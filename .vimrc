if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/naofumi.fujii/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/naofumi.fujii/.cache/dein')
  call dein#begin('/Users/naofumi.fujii/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/naofumi.fujii/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here like this:
  "call dein#add('Shougo/neosnippet.vim')
  "call dein#add('Shougo/neosnippet-snippets')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

" private settings from here:

"enable color syntax
syntax on

" 全角スペースの背景を白に変更
autocmd Colorscheme * highlight FullWidthSpace ctermbg=white
autocmd VimEnter * match FullWidthSpace /　/

" color theme
colorscheme iceberg

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

" caw.vim
nmap <C-_> <Plug>(caw:hatpos:toggle)
vmap <C-_> <Plug>(caw:hatpos:toggle)

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

" no CR insert after select
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" function! s:my_cr_function()
"   return pumvisible() ? deoplete#mappings#close_popup() : "\n"
" endfunction

let g:startify_bookmarks = [ {'c': '~/.vimrc'}, '~/.zshrc' ]

"brew install fzf
set rtp+=/usr/local/opt/fzf

map <C-j> <Plug>(ale_go_to_definition_in_vsplit)

let g:ale_linters = {
      \ 'html': [],
      \ 'javascript': ['eslint'],
      \ 'typescript': ['eslint','prettier','tsserver'],
      \ 'vue': ['eslint','prettier','vls'],
      \ 'haskell': ['stack-build', 'hlint'],
      \ 'rust': ['rls'],
      \ 'php': [''],
      \ 'go': ['gopls'],
      \ }
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'scss': ['stylelint'],
      \ 'go': ['gofmt', 'goimports'],
      \ 'vue': ['eslint','prettier'],
      \ 'javascript': ['eslint', 'remove_trailing_lines', 'trim_whitespace'],
      \ 'typescript': ['eslint','prettier'],
      \ 'haskell': ['stylish-haskell'],
      \ 'rust': ['rustfmt'],
      \ 'php': ['phpcbf'],
      \ 'ruby': ['rufo','remove_trailing_lines','trim_whitespace'],
      \ }
let g:ale_fix_on_save = 1
" let g:ale_ruby_rufo_executable = 'bundle'


"swap semicolon to colon
noremap ; :
noremap : ;

map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)


" http://vim.wikia.com/wiki/Dictionary_completions
au FileType * execute 'setlocal dict+=~/src/github.com/naofumi-fujii/dicts/ruby.dict'

set inccommand=nosplit