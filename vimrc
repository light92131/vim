let s:dir = split(&rtp, ",")[0]
let s:file = expand(s:dir . '/autoload/plug.vim')
if empty(globpath(s:dir, '/autoload/plug.vim'))
  execute "!curl -fLo " . s:file . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet s:dir
unlet s:file
 
call plug#begin('~/.vim/plugged')
Plug 'https://github.com/adlawson/vim-sorcerer.git'
Plug 'https://github.com/vim-scripts/ScrollColors.git'
call plug#end()


if has("gui_running")
  if has("gui_gtk2")
    set guifont=DejaVu\ Sans\ Mono\ 10
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=DejaVu_Sans_Mono:h10:cANSI:qDRAFT
  endif
endif

set columns=200
set lines=68
color sorcerer
