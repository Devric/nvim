" ==================================================
" Default
" ==================================================
if &compatible
    set nocompatible               " Be iMproved
    set hidden
endif

filetype plugin indent on
syntax enable

set autoread " Set auto read when a file is changed outside
set history=128
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
set encoding=UTF-8
" than 50 lines of registers'

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

" UI
" ====================================
Plug 'morhetz/gruvbox'      " theme
Plug 'sheerun/vim-polyglot' " syntax highlight
Plug 'othree/javascript-libraries-syntax.vim', {'for':['javascript','vue','ng','jsx','html']}
Plug 'HerringtonDarkholme/yats.vim'
Plug 'kevinoid/vim-jsonc' "allow json with comment

Plug 'jparise/vim-graphql' " graphql
Plug 'pangloss/vim-javascript' " JavaScript syntax
Plug 'leafgarland/typescript-vim' " type script
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'peitalin/vim-jsx-typescript'

" js syntax {
    let g:used_javascript_libs = 'underscore,angularjs,angularui,angularuirouter,react,flux,jasmine,chai,vue,d3'
" }
"
Plug 'ryanoasis/vim-devicons'

Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown'] }
Plug 'Yggdroot/indentLine', {'on':[]}  " indent line
Plug 'myusuf3/numbers.vim', {'on':[]}  " relative line number
Plug 'gregsexton/MatchTag', {'on':[]}  " match tag

" Formating
" ====================================
Plug 'junegunn/vim-easy-align'
Plug  'godlygeek/tabular', { 'on':  'Tabularize' }
" tabularize {
vnoremap <silent> <Space> :Tabularize /
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
function! s:align()
    let p = '^\s*|\s.*\s|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
endfunction
"}

" Navigation & searching
" ====================================
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" IDE
" ====================================
Plug 'vim-scripts/zoomwintab.vim'   " zoom
Plug 'simeji/winresizer', {'on':[]} " window resizing easier CTRL+E or :WinResizerStartResize ( enter=accept, q=cancel )

" Plug 'ludovicchabant/vim-gutentags' " ctags generaton
Plug 'liuchengxu/vista.vim'
" vista tag bar {
    nnoremap <F3> :Vista!!<CR>
    " <leader>t not working
    nnoremap <silent><nowait> ;t  :<C-u>Vista finder<cr>
    let g:vista#renderer#enable_icon = 1
    let g:vista#renderer#  = 1
    let g:vista_default_executive = 'coc'
    let g:vista_fzf_preview = ['right:50%']
    let g:vista_stay_on_open = 0
    let g:vista_ctags_cmd = {
      \ 'typescript': 'tstags -f-',
    \ }

    let g:vista#renderer#icons = {
    \   "class": "\ue79b",
    \   "method": "\uf09a",
    \   "variable": "\uf260",
    \  }

    function! NearestMethodOrFunction() abort
        return get(b:, 'vista_nearest_method_or_function', '')
    endfunction

    set statusline+=%{NearestMethodOrFunction()}

    " By default vista.vim never run if you don't call it explicitly.
    "
    " If you want to show the nearest function in your statusline automatically,
    " you can add the following line to your vimrc
    autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
" }


" source ~/.config/nvim/plug-config/ctags.vim

Plug 'mileszs/ack.vim', {'on':'Ack'}
" Ack {
    let g:ackprg = 'ag --nogroup --nocolor --column'
    nmap ;f :Ack <C-R>=expand("<cword>")<CR><CR>
" }

Plug 'itchyny/lightline.vim' 		" cool status line
" lightline {
    let g:lightline = {
    \   'active': {
    \     'left':[ [ 'mode', 'paste' ],
    \              [ 'gitbranch', 'readonly', 'filename', 'modified' ]
    \     ]
    \   },
    \   'component': {
    \     'lineinfo': '%3l:%-2v',
    \   },
    \   'component_function': {
    \     'gitbranch': 'fugitive#head',
    \   }
    \ }
" }

" replace mini buffer
Plug 'mengelbrecht/lightline-bufferline'
" lightline > tabline {
    let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
    let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
    let g:lightline.component_type   = {'buffers': 'tabsel'}

    let g:lightline#bufferline#show_number  = 1
    let g:lightline#bufferline#shorten_path = 0
    let g:lightline#bufferline#unnamed      = '[No Name]'
    let g:lightline#bufferline#enable_devicons = 1
    let g:lightline#bufferline#min_buffer_count = 2
    let g:lightline#bufferline#clickable = 1
    map <expr><silent><nowait> <C-b> &showtabline ? ":set showtabline=0\<cr>" : ":set showtabline=2\<cr>"
" }

Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround' 		" quickly change surounded tags quotes brackts
" surround {
    " remap shift-s to just s
    vmap s S
    nnoremap <C-Space> :CtrlSpace<CR>
" }
Plug 'tmhedberg/matchit'              " matching tags
Plug 'christoomey/vim-tmux-navigator' " provide movment integration with tmux, required for tmux script
Plug 'vim-scripts/sudo.vim'           " edit permission files :e sudo:/etc/passwd
Plug 'matze/vim-move'                 " moving lines <A-k>
" vim-move {
    let g:move_map_keys = 0
    vmap <S-k> <Plug>MoveBlockUp
    vmap <S-j> <Plug>MoveBlockDown
" }


Plug '29decibel/vim-stringify'        " fast stringfy, <leader>G // set within this vim script
" stringify {
    map <leader>g :call Stringify()<CR>
" }

Plug 'moll/vim-node'

Plug 'vim-scripts/compview'           " fast serach buffer <leader> v
" compview {
    nnoremap <leader>v :CompView<cr>
" }

Plug 'chrisbra/NrrwRgn'      " select specific text trunk to edit
" NrrwRgn {
vnoremap <Enter> :NR<cr>
" }

Plug 'AndrewRadev/splitjoin.vim'

" Completions
Plug 'mattn/emmet-vim'
" emmet {
    let g:use_emmet_complete_tag = 1
" }
Plug 'scrooloose/nerdcommenter' 	" easy commenting
Plug 'vim-scripts/HTML-AutoCloseTag'  " fast close html tags
Plug 'jiangmiao/auto-pairs'

"Plug 'rust-lang/rust.vim'

"Plug 'zoeesilcock/vim-caniuse' " can i use :Caniuse border-radius

Plug 'editorconfig/editorconfig-vim'


" COC
" ==================================

" replace deoplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" https://www.tabnine.com/
" AI code complete
Plug 'neoclide/coc-tabnine', {'do': 'npm install --from-lockfile'}

" replace tern
Plug 'neoclide/coc-tsserver', {'do': 'npm install --from-lockfile'}

" replace nerd tree
Plug 'weirongxu/coc-explorer', {'do': 'npm install --from-lockfile'}

" replaces ultra snippet
Plug 'neoclide/coc-snippets', {'do': 'npm install --from-lockfile'}
source ~/.config/nvim/plug-config/coc.vim
" install the plugins from https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

Plug 'pantharshit00/coc-prisma'
Plug 'pantharshit00/vim-prisma'

" bookmark
" mx  > to mark with x
" dmx > to delete mark on x
" m<Space> delete marks on current bufer
Plug 'kshenoy/vim-signature'

" Version Control
" ======================================
Plug 'tpope/vim-fugitive'     " vim git commands
Plug 'airblade/vim-gitgutter' " create a gutter for git + - when file is changed
" gitguter {
    set updatetime=250
    let g:gitgutter_max_signs = 1000 
" }
Plug 'sjl/splice.vim', {'on': ['SpliceDiff', 'SpliceCompare']}         " 3 way diff for git merge

Plug 'mbbill/undotree', {'on':'UndotreeToggle'}          " python! change tree
" undotree {
nnoremap <F2> :UndotreeToggle<CR>
if has("persistent_undo")
    set undodir=~/tmp/.undodir/
    set undofile
endif
" }

Plug 'int3/vim-extradite', {'on': 'Extradite'}     " git history of current file
" Extradite {
    nnoremap <F4> :Extradite<CR>
" }

call plug#end()

" ==================================================
" UI
" ==================================================
set so=7        " 7 lines to the cursor
set showcmd
set ru
set nu
set laststatus=2 " show status line
set mousehide
set hidden      " Always show cursor position
set wrapmargin=0
set linebreak
set background=dark

set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase " ignore case when search
set smartcase

" Plug Gruvbox
let g:gruvbox_italic=1
"let g:gruvbox_termcolors=16
"set termguicolors
colorscheme gruvbox

" Plug IndentLine
let g:indentLine_setColors = 0

" ==================================================
" Highlight
" ==================================================
set hlsearch                                    " highlight search things
hi htmlTag guifg=#00bdec guibg=#200000 gui=bold " highlight html tags block
hi Normal guibg=NONE ctermbg=NONE
set cursorline   "highlight current line
set cursorcolumn "highlight current column

set incsearch    " Highlight search as you type
set nolazyredraw " dont redraw while executing macros

if &diff
    " only interested in diff colours
    syntax off
endif

set magic     " set magic on, for reugular expressions
set showmatch " show matching bracets when text indication is over them
set mat=2     " how many tenths of a second to blink

"Make the completion menus readable
hi Pmenu ctermbg=black ctermfg=white
highlight PmenuSel ctermfg=0 ctermbg=7

"""""""""""""""""""""""""""""""""
" Error Handling
"""""""""""""""""""""""""""""""""
set noerrorbells
set novisualbell
set t_vb=
set vb t_vb=
set tm=500"

"""""""""""""""""""""""""""""""""
" Indenting
"""""""""""""""""""""""""""""""""
set noautoindent smartindent
set softtabstop=4
set expandtab
set shiftwidth=4
set shiftround
set nojoinspaces

"""""""""""""""""""""""""""""""""
" Default Key Bindings
"""""""""""""""""""""""""""""""""
let mapleader= ";"
nmap <space> :
imap jk <esc>
imap <C-c> <esc>

imap <Leader>date   <C-R>=strftime("%d/%m/%y")<CR>
imap <Leader>time   <C-R>=strftime("%T")<CR>

" \n to turn off search highlighting
nmap <silent> <leader>h :silent :nohlsearch<CR> 
" \l to toggle visible whitespace
nmap <silent> <leader>l :set list!<CR>          
" Shift-tab to insert a hard tab
imap <silent> <S-tab> <C-v><tab>                

inoremap <expr> <Tab> SkipClosingParentheses()
function! SkipClosingParentheses()
    let line = getline('.')
    let current_char = line[col('.')-1]

    "Ignore EOL
    if col('.') == col('$')
        return "\t"
    end

    return stridx(']})', current_char)==-1 ? "\t" : "\<Right>"
endfunction

" change background faster
nnoremap <leader>bg :exe 'set bg=' . (&bg == 'dark' ? 'light' : 'dark')<CR>

" allow deleting selection without updating the clipboard (yank buffer)
vnoremap x "_x

" faster back space
inoremap <C-b> <bs>

inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-l> <C-o>l

map <leader>bd :bd<cr>

" tab configurations
map <leader>tn :tabnew<cr>
map <leader>tc :tabclose<cr>

" split
map <leader>s :vsp<cr>

" Arrows to switch buffer
map <right> :bn<cr>
map <left> :bp<cr>

" Shift Arrows to switch tabs
map <s-right> :tabnext<cr>
map <s-left> :tabprevious<cr>

" quit all
map <leader>q :qa<cr>

" quick indenting
vnoremap <C-h> <ESC>v<<ESC>
vnoremap <C-l> <ESC>v><ESC>

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Tmux
if exists('$TMUX')
    function! TmuxOrSplitSwitch(wincmd, tmuxdir)
        let previous_winnr = winnr()
        silent! execute "wincmd " . a:wincmd
        if previous_winnr == winnr()
            call system("tmux select-pane -" . a:tmuxdir)
            redraw!
        endif
    endfunction

    let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
    let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
    let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

    nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
    nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
    nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
    nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l
endif

" =====================================
" Ternminal mode
" =====================================
nnoremap <leader>z :copen<CR>:terminal<CR>i source ~/.profile<CR>clear<CR>
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l

set pastetoggle=<F9>
" disable paste mode after leave insert
au InsertLeave * set nopaste

" save file in normal mode
nnoremap s :w<cr>

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Q to repeat last macro @@
map Q @@

" Change Working Directory to that of the current file
cmap cd. lcd %:p:h<cr>"


" Remove trailing white space before save
autocmd! BufWritePost :%s/\s\+$//e"

"Ignore these files when completing names and in Explorer
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif"

" vim cant detect json by default
au BufRead,BufNewFile *.json setf json


" force saving file that requires root permission
cmap w!! %!sudo tee > /dev/null %

" scroll history
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>

" jump to begin / end
cnoremap <C-a> <Home>
cnoremap <C-e> <End>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => backup files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noswapfile
function! InitBackupDir()
    let separator = "."
    let parent = $HOME .'/' . separator . 'vim/'
    let backup = parent . 'backup/'
    let tmp    = parent . 'tmp/'
    if exists("*mkdir")
        if !isdirectory(parent)
            call mkdir(parent)
        endif
        if !isdirectory(backup)
            call mkdir(backup)
        endif
        if !isdirectory(tmp)
            call mkdir(tmp)
        endif
    endif
    let missing_dir = 0
    if isdirectory(tmp)
        execute 'set backupdir=' . escape(backup, " ") . "/,."
    else
        let missing_dir = 1
    endif
    if isdirectory(backup)
        execute 'set directory=' . escape(tmp, " ") . "/,."
    else
        let missing_dir = 1
    endif
    if missing_dir
        echo "Warning: Unable to create backup directories: " 
        . backup ." and " . tmp
        echo "Try: mkdir -p " . backup
        echo "and: mkdir -p " . tmp
        set backupdir=.                 
        set directory=.
    endif
endfunction          
call InitBackupDir()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => allow you yank to mac clipboard
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if version >= 730 && has("macunix")
    set clipboard=unnamed
end


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => persist undo on reopening file
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This is only present in 7.3+
" :help undo-persistence
if exists("+undofile")
    if isdirectory($HOME . '/.vim/undo') == 0
        :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
    endif
    set undodir=./.vim-undo//
    set undodir+=~/.vim/undo//
    set undofile
endif

if has("autocmd")
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line ("'\"") <= line("$") |
                \   exe "normal g'\"" |
                \ endif

    " Resize splits when the window is resized
    au VimResized * exe "normal! \<c-w>="
endif


" splitjoin {
    nmap <Leader>sj :SplitjoinJoin<cr>
    nmap <Leader>ss :SplitjoinSplit<cr>
" }



" syntastic {
    let g:syntastic_javascript_checkers=['jshint']
    let g:syntastic_javascript_jshint_conf = $HOME . '/.jshintrc'

    " ignore angular
    let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

    let g:syntastic_aggregate_errors=1
    let g:synstatic_check_on_open=0

    let g:syntastic_enable_signs=1
    let g:syntastic_error_symbol='✗'         " Error Symbol
    let g:syntastic_warning_symbol='⚠'       " Warning Symbol
    let g:syntastic_style_error_symbol='⚡'   " Style Error Symbol
    let g:syntastic_style_warning_symbol='⚡' " Style Warning Symbol
    let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
" }

" fzf {
    nnoremap <leader>x :FZF<CR>
" }

" python for neovim mac {
let g:python2_host_prog = 'user/local/bin/python'
let g:python3_host_prog = '/usr/local/Cellar/python3/3.7.7/bin/python3'
" }


