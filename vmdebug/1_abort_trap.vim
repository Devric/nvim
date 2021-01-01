set nocompatible
set runtimepath^=/path/to/coc.nvim
filetype plugin indent on
syntax on
set hidden

let g:python2_host_prog = 'user/local/bin/python'
let g:python3_host_prog = '/usr/local/Cellar/python3/3.7.7/bin/python3'

" ==================================================
" auto-install vim-plug
" ==================================================
if empty(glob('~/.config/nvim/autoload/plug.vim')) 
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif                                                                                                                                 
" ==================================================
" Install Plugins
" ==================================================
call plug#begin('~/.config/nvim/plugged')  

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver', {'do': 'npm install --from-lockfile'}
"source ~/.config/nvim/plug-config/coc.vim

inoremap <silent><expr> <c-space> coc#refresh()

call plug#end()

