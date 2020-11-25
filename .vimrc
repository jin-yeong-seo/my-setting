set t_Co=256
set mouse=a
set encoding=utf-8
set backspace=indent,eol,start
set nocompatible
set splitright

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
filetype plugin indent on


" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

"ncm2 basic tools
Plugin 'ncm2/ncm2'
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'ncm2/ncm2-bufword'
Plugin 'ncm2/ncm2-path'
Plugin 'ncm2/ncm2-github'
Plugin 'ncm2/ncm2-tmux'
Plugin 'ncm2/ncm2-neoinclude'
Plugin 'Shougo/neoinclude.vim'
Plugin 'fgrsnau/ncm2-otherbuf'

"ncm2 python support
Plugin 'ncm2/ncm2-jedi'

"ncm2 clang support
Plugin 'ncm2/ncm2-pyclang'

"ncm2 vimL support
Plugin 'ncm2/ncm2-vim'
Plugin 'Shougo/neco-vim'

"ncm2 golang support
Plugin 'ncm2/ncm2-go'
Plugin 'stamblerre/gocode', {'rtp': 'nvim/'}

"ncm2 rust support
Plugin 'ncm2/ncm2-racer'
Plugin 'rust-lang/rust.vim'

"ncm2 tex support
Plugin 'lervag/vimtex'

"ncm2 snippet
Plugin 'ncm2/ncm2-ultisnips'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

"syntastic vimL plugin
Plugin 'vim-jp/vim-vimlparser'
Plugin 'syngan/vim-vimlint'

"vim basic plugins
Plugin 'scrooloose/syntastic'
Plugin 'Yggdroot/indentLine'

"Plugin 'vim-scripts/taglist.vim'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'vim-airline/vim-airline'
Plugin 't6tn4k/vim-c-posix-syntax'


"auto formatter
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'

call vundle#end()


"vim-codefmt settings
augroup autoformat_settings
  autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType python AutoFormatBuffer autopep8
  autocmd FileType rust AutoFormatBuffer rustfmt
augroup END

"vimtex settings
let g:tex_flavor = "latex"
let g:vimtex_version_check = 0

au User Ncm2Plugin call ncm2#register_source({
            \ 'name' : 'vimtex',
            \ 'priority': 1,
            \ 'subscope_enable': 1,
            \ 'complete_length': 1,
            \ 'scope': ['tex'],
            \ 'matcher': {'name': 'prefix', 'key': 'word'},
            \ 'mark': 'tex',
            \ 'word_pattern': '\w+',
            \ 'complete_pattern': g:vimtex#re#ncm,
            \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
            \ })



"syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_quiet_messages = {'level': 'warnings'}
"let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers=[ 'python', 'pyflakes' ]
let g:syntastic_go_checkers = [ 'go' ]
let g:syntastic_c_compiler='clang'
let g:syntastic_c_check_header = 1
let g:syntastic_c_compiler_options = '-std=c99'
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler_options = '-std=c++14'
let g:syntastic_vim_checkers = ['vimlint']
let g:syntastic_vimlint_options = { 'EVL103': 1 }
let g:syntastic_tex_checkers = ['lacheck']
let g:syntastic_rust_checkers = ['cargo']

let g:rust_cargo_check_all_features = 1

"for pintos
let g:syntastic_cpp_config_file = '.config'
let g:syntastic_c_config_file = '.config'
"ncm2 settings
" enable ncm2 for all buffers
"
let g:ncm2#complete_length = 2
let g:ncm2#popup_delay = 0
let g:ncm2#complete_delay = 0
let g:ncm2#auto_popup = 1
let g:ncm2#popup_limit = 10
let g:ncm2#sorter = "abbrfuzzy"
let g:ncm2#matcher = "abbrfuzzy"

"let g:neoinclude#paths = {'cpp': '/usr/include/c++/5.4.0/' }


autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function! Tab_Or_Complete() abort
  " If completor is already open the `tab` cycles through suggested completions.
  if pumvisible()
    return "\<C-N>"
  " If completor is not open and we are in the middle of typing a word then
  " `tab` opens completor menu.
  elseif col('.')>2 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-R>=ncm2#_on_complete(1)\<CR>"
  else
    " If we aren't typing a word and we press `tab` simply do the normal `tab`
    " action.
    return "\<Tab>"
  endif
endfunction

inoremap <expr> <Tab> Tab_Or_Complete()

" wrap existing omnifunc
" Note that omnifunc does not run in background and may probably block the
" editor. If you don't want to be blocked by omnifunc too often, you could
" add 180ms delay before the omni wrapper:
"  'on_complete': ['ncm2#on_complete#delay', 180,
"               \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
au User Ncm2Plugin call ncm2#register_source({
            \ 'name' : 'css',
            \ 'priority': 9,
            \ 'subscope_enable': 1,
            \ 'scope': ['css','scss'],
            \ 'mark': 'css',
            \ 'word_pattern': '[\w\-]+',
            \ 'complete_pattern': ':\s*',
            \ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
            \ })

let g:ncm2_pyclang#args_file_path = ['.clang_complete']
let g:ncm2_pyclang#library_path = '/usr/lib/llvm-3.8/lib/libclang.so'
"let g:ncm2_pyclang#library_path = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'

"snippet settings   
" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" c-j c-k for moving in snippet
let g:UltiSnipsJumpForwardTrigger	= "<c-l>"
let g:UltiSnipsJumpBackwardTrigger	= "<c-j>"
let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsRemoveSelectModeMappings = 0

"syntax highlight setting
let g:go_highlight_structs = 1 
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:python_highlight_all = 1

"Tagbar settings
let g:go_version_warning = 0
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }


"Taglist settings
"let g:Tlist_Auto_Update = 1
"let g:Tlist_WinWidth = 40

syntax on
syntax enable
colorscheme dracula
set autoindent
set cindent
set smartindent
set nu
set et
set ts=2
set shiftwidth=2
set softtabstop=2

nmap <C-g> :TagbarToggle<CR>
vmap <C-x> :!pbcopy<CR>
vmap <C-c> :w !pbcopy<CR><CR>

if has('nvim')
    nmap <C-\> :vsplit term://zsh<CR>
else
    nmap <C-\> :ConqueTermVSplit zsh<CR>
endif
nmap <m-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-l> <C-o>l

autocmd FileType rust setlocal ts=2 sw=2
autocmd FileType python setlocal ts=2 sw=2

autocmd BufNewFile,BufRead *.fish set filetype=fish
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
autocmd BufNewFile,BufRead *.tex setlocal filetype=tex
let g:tex_conceal = ""
let g:markdown_syntax_conceal = 0


au FileType c let &makeprg="clang -std=c99 -g -o %< %"
au FileType cpp let &makeprg="clang++ -std=c++14 -g -o %< %"
au FileType python let &makeprg="python3 %"
au FileType go let &makeprg="go build -gcflags \"-N -l\" %"
au FileType markdown let &makeprg="pandoc % -o %<.pdf -H ~/.pandoc_opt.sty"
aut FileType tex let &makeprg="pdflatex %"

