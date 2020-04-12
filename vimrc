let s:dir = split(&rtp, ",")[0]
let s:file = expand(s:dir . '/autoload/plug.vim')
if empty(globpath(s:dir, '/autoload/plug.vim'))
  execute "!curl -fLo " . s:file . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet s:dir
unlet s:file


function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction


let g:ycm_server_python_interpreter = '/usr/bin/python'
let g:ycm_server_use_vim_stdout = 1
let g:ycm_server_log_level = 'debug'

let g:rtagsUseDefaultMappings = 0

call plug#begin('~/.vim/plugged')
Plug 'https://github.com/godlygeek/csapprox.git'
Plug 'https://github.com/adlawson/vim-sorcerer.git'
Plug 'https://github.com/vim-scripts/ScrollColors.git'
Plug 'vim-airline/vim-airline'
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'tmhedberg/SimpylFold'
Plug 'vim-scripts/indentpython.vim'
"Plug 'vim-syntastic/syntastic'
"Plug 'scrooloose/nerdtree'
"Plug 'jistr/vim-nerdtree-tabs'
Plug 'kien/ctrlp.vim'
Plug 'https://github.com/majutsushi/tagbar'
Plug 'https://github.com/LucHermitte/lh-vim-lib.git'
Plug 'https://github.com/LucHermitte/alternate-lite.git'
Plug 'therivenman/vim-rtags'
Plug 'ericcurtin/CurtineIncSw.vim'
call plug#end()

let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_global_ycm_extra_conf = '~/.vim/global_ycm_extra_conf.py'
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

if has("gui_running")
  if has("gui_gtk2")
    set guifont=DejaVu\ Sans\ Mono\ 10
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=DejaVu_Sans_Mono:h10:cANSI:qDRAFT
  endif
endif

"ignore files in NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$']

" Folding
set foldmethod=indent
set foldlevel=99

" Split navigations
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

" Dangling whitespace
highlight BadWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight BadWhitespace ctermbg=darkred guibg=red
autocmd BufWinEnter * match BadWhitespace /\s\+$/
autocmd InsertEnter * match BadWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match BadWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.cpp,*.h match BadWhitespace /\s\+$/

" Fold with spacebar
nnoremap <space> za

" rtags mappings
noremap <c-]> :call rtags#JumpTo(g:SAME_WINDOW)<CR>
noremap <c-t> :call rtags#JumpBack()<CR>


" C/C++ stuff
autocmd BufNewFile,BufRead *.cpp,*.hpp,*.c,*.h set
     \ tabstop=4
     \ softtabstop=4
     \ shiftwidth=4
     \ textwidth=79
     \ expandtab
     \ autoindent
     \ smartindent
     \ fileformat=unix
     \ encoding=utf-8
     \ comments=sl:/*,mb:\ *,elx:\ */
autocmd BufNewFile,BufRead *.cpp,*.hpp,*.c,*.h syntax enable

" Python stuff
autocmd BufNewFile,BufRead *.py set
     \ tabstop=4
     \ softtabstop=4
     \ shiftwidth=4
     \ textwidth=79
     \ expandtab
     \ autoindent
     \ fileformat=unix
     \ encoding=utf-8

set number
color sorcerer-approx

set exrc
set secure
set path=$PWD/**
if match($TERM, "screen.xterm-256color")!=-1
	set term=xterm-256color
endif
