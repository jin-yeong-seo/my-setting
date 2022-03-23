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

"fzf tools
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

"ncm2 basic tools
Plugin 'ncm2/ncm2'
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'ncm2/ncm2-bufword'
Plugin 'ncm2/ncm2-path'
Plugin 'ncm2/ncm2-github'
Plugin 'ncm2/ncm2-tmux'
Plugin 'roxma/vim-tmux-clipboard'
Plugin 'ncm2/ncm2-neoinclude'
Plugin 'Shougo/neoinclude.vim'
Plugin 'fgrsnau/ncm2-otherbuf'

"ncm2 dictionary
Plugin 'filipekiss/ncm2-look.vim'


"ncm2 typescript support
Plugin 'Shougo/vimproc.vim'
Plugin 'Quramy/tsuquyomi'
Plugin 'ncm2/nvim-typescript'

"ncm2 java support
Plugin 'ObserverOfTime/ncm2-jc2'
Plugin 'artur-shaik/vim-javacomplete2'

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
Plugin 'myint/syntastic-extras'
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

"argment navigator"
Plugin 'AndrewRadev/sideways.vim'

call vundle#end()

" fzf settings
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

map <C-f> :Files<CR>
map <leader>b :Buffers<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>m :Marks<CR>


let g:fzf_tags_command = 'ctags -R'
" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --files --hidden"


" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)


" Get text in files with Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)



"move cusrosr in imode
imap <C-h> <left>
imap <C-j> <down>
imap <C-k> <up>
imap <C-l> <right>

"argmentative setting
nnoremap <c-h> :SidewaysJumpLeft<cr>
nnoremap <c-l> :SidewaysJumpRight<cr>
omap aa <Plug>SidewaysArgumentTextobjI
xmap aa <Plug>SidewaysArgumentTextobjI


"disable sql omni completion
let g:omni_sql_no_default_maps = 1

"disable javacomplete2 default mapping
let g:JavaComplete_EnableDefaultMappings = 0
let g:JavaComplete_InsertImports = 0


"indentLine
let g:indentLine_setConceal = 0

"vim-codefmt settings
augroup autoformat_settings
  autocmd FileType c,cpp,java,javascript,typescript AutoFormatBuffer clang-format
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType python AutoFormatBuffer yapf
  autocmd FileType rust AutoFormatBuffer rustfmt
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
augroup END

"vimtex settings
let g:tex_flavor = "latex"
let g:vimtex_version_check = 0

 au InsertEnter * call ncm2#enable_for_buffer()
    au Filetype tex call ncm2#register_source({
        \ 'name' : 'vimtex-cmds',
        \ 'priority': 8, 
        \ 'complete_length': -1,
        \ 'scope': ['tex'],
        \ 'matcher': {'name': 'prefix', 'key': 'word'},
        \ 'word_pattern': '\w+',
        \ 'complete_pattern': g:vimtex#re#ncm2#cmds,
        \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
        \ })
    au Filetype tex call ncm2#register_source({
        \ 'name' : 'vimtex-labels',
        \ 'priority': 8, 
        \ 'complete_length': -1,
        \ 'scope': ['tex'],
        \ 'matcher': {'name': 'combine',
        \             'matchers': [
        \               {'name': 'substr', 'key': 'word'},
        \               {'name': 'substr', 'key': 'menu'},
        \             ]},
        \ 'word_pattern': '\w+',
        \ 'complete_pattern': g:vimtex#re#ncm2#labels,
        \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
        \ })
    au Filetype tex call ncm2#register_source({
        \ 'name' : 'vimtex-files',
        \ 'priority': 8, 
        \ 'complete_length': -1,
        \ 'scope': ['tex'],
        \ 'matcher': {'name': 'combine',
        \             'matchers': [
        \               {'name': 'abbrfuzzy', 'key': 'word'},
        \               {'name': 'abbrfuzzy', 'key': 'abbr'},
        \             ]},
        \ 'word_pattern': '\w+',
        \ 'complete_pattern': g:vimtex#re#ncm2#files,
        \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
        \ })
    au Filetype tex call ncm2#register_source({
        \ 'name' : 'bibtex',
        \ 'priority': 8, 
        \ 'complete_length': -1,
        \ 'scope': ['tex'],
        \ 'matcher': {'name': 'combine',
        \             'matchers': [
        \               {'name': 'prefix', 'key': 'word'},
        \               {'name': 'abbrfuzzy', 'key': 'abbr'},
        \               {'name': 'abbrfuzzy', 'key': 'menu'},
        \             ]},
        \ 'word_pattern': '\w+',
        \ 'complete_pattern': g:vimtex#re#ncm2#bibtex,
        \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
        \ })


"syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers=['python', 'pyflakes']

let g:syntastic_go_checkers = ['govet']

let g:syntastic_c_checkers = ['gcc']
let g:syntastic_c_compiler='clang'
let g:syntastic_c_check_header = 1
let g:syntastic_c_compiler_options = '-std=c99'
let g:syntastic_c_config_file = '.clang_complete'

let g:syntastic_cpp_checkers = ['gcc']
let g:syntastic_cpp_quiet_messages = {'level': 'warnings'}
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler_options = '-std=c++17'
let g:syntastic_cpp_config_file = '.clang_complete'

let g:syntastic_make_checkers = ['gnumake']
let g:syntastic_json_checkers = ['json_tool']

let g:syntastic_vim_checkers = ['vimlint']
let g:syntastic_vimlint_options = { 'EVL103': 1 }

"let g:syntastic_tex_checkers = ['chktex']

let g:syntastic_tex_checkers = []

let g:syntastic_rust_checkers = ['cargo']
let g:rust_cargo_check_all_features = 1

let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi'] " You shouldn't use 'tsc' checker.




" see :h syntastic-loclist-callback
function! SyntasticCheckHook(errors)
  if !empty(a:errors)
    let g:syntastic_loc_list_height = min([len(a:errors), 5])
  endif
endfunction



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

if has('macunix')
  let g:ncm2_pyclang#library_path = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
endif

"snippet settings   
" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" c-j c-k for moving in snippet
"let g:UltiSnipsJumpForwardTrigger	= "<c-l>"
"let g:UltiSnipsJumpBackwardTrigger	= "<c-j>"
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
set conceallevel=0

nmap <C-g> :TagbarToggle<CR>
vmap <C-x> :!pbcopy<CR>
vmap <C-c> :w !pbcopy<CR><CR>

if has('nvim')
    nmap <C-\> :vsplit term://zsh<CR>
else
    nmap <C-\> :ConqueTermVSplit zsh<CR>
endif
nmap <m-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>


autocmd FileType rust setlocal ts=2 sw=2
autocmd FileType python setlocal ts=4 sw=4

autocmd BufNewFile,BufRead *.fish set filetype=fish
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
autocmd BufNewFile,BufRead *.tex setlocal filetype=tex

au FileType c let &makeprg="clang -std=c99 -g -o %< %"
au FileType cpp let &makeprg="clang++ -std=c++17 -g -o %< %"
au FileType python let &makeprg="python3 %"
au FileType go let &makeprg="go build -gcflags \"-N -l\" %"
au FileType markdown let &makeprg="pandoc % -o %<.pdf -H ~/.pandoc_opt.sty"
au FileType tex let &makeprg="pdflatex main.tex"
au FileType tex let g:ncm2_look_enabled=1
au FileType java let &makeprg="javac %"
