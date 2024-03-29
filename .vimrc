"----------- vundle PLUGINS ------
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/bundle/ctrlp.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

"Plugin 'ycm-core/YouCompleteMe'
Plugin 'easymotion/vim-easymotion'
Plugin 'fatih/vim-go'
Plugin 'jiangmiao/auto-pairs'
Plugin 'alvan/vim-closetag'

Plugin 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plugin 'junegunn/fzf.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'qpkorr/vim-bufkill'
Plugin 'bagrat/vim-buffet'

Plugin 'flazz/vim-colorschemes'
Plugin 'rafi/awesome-vim-colorschemes'
Plugin 'liuchengxu/space-vim-theme'
Plugin 'sainnhe/everforest'
Plugin 'morhetz/gruvbox'

Plugin 'mattesgroeger/vim-bookmarks'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-ruby/vim-ruby'
Plugin 'ngmy/vim-rubocop'
Plugin 'neoclide/coc.nvim', { 'branch': 'master', 'do': 'yarn install --frozen-lockfile' }
Plugin 'neoclide/coc-solargraph'

Plugin 'blueyed/vim-diminactive'
Plugin 'preservim/vimux'
Plugin 'ruanyl/vim-gh-line'

"Run `:CocInstall coc-solargraph`
"Run `solargraph bundle` in root directory
call vundle#end()
"filetype plugin indent on

"------------ GENERAL -------------
let mapleader =" "

"-------- Set Fold ------------------
syntax on
set foldmethod=syntax
set nofoldenable
nnoremap <silent> <Leader>c zc<esc>
nnoremap <silent> <Leader>o zo<esc>
nnoremap <silent> <Leader>C zC<esc>
nnoremap <silent> <Leader>O zO<esc>


"COPY AND PASTE
set clipboard+=unnamed

set ignorecase
set smartcase
set smartindent
set autoindent
set wrap!

set tabstop=2
set shiftwidth=2
set expandtab

set nu

set incsearch
set hlsearch

inoremap jk <esc>

set backspace=indent,eol,start

"----------- Display white spaces -----------------
"set lcs+=space:·
set list

nnoremap <silent> <Leader>f :Rg <C-R><C-W><CR>
nnoremap <silent> <Leader>rg :Rg <CR>
command! -bang -nargs=* Rg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

nnoremap <silent> <Leader>gb :Git blame<CR>

"----------- Regex -----------------
nnoremap / /\c
vnoremap / /\c
nnoremap ? ?\c
vnoremap ? ?\c

"---------- Ctrl P -----------------
nmap <c-p> :FZF<CR>
"let g:ctrlp_working_path_mode = 'ra'
"let g:ctrlp_cache_dir=$HOME.'/.cache/ctrlp'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.cache

"------------- EASY MOTION ---------
map <Leader>w <Plug>(easymotion-w)
map <Leader>b <Plug>(easymotion-b)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>/ <Plug>(easymotion-jumptoanywhere)

let g:fzf_buffers_jump = 1
"map <C-p> :Files<CR>

"---------- Buffers -----------
nnoremap <C-b> :Buffers <CR>
nnoremap <Leader>db :BD <CR>
nnoremap <C-j> <C-o>
nnoremap <C-k> <C-i>

"--------- Colors --------
"colorscheme Tomorrow-Night-Eighties
colorscheme everforest


"--------- NERDTree --------
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTreeFind<CR>
nnoremap <leader>r :NERDTreeRefreshRoot<CR>

"--------- YCM - Ruby --------
"set omnifunc=javascriptcomplete#CompleteJS,htmlcomplete#CompleteTags
"let g:ycm_language_server = [ 
"\   { 'name': 'ruby', 
"\     'cmdline': ['/opt/homebrew/lib/ruby/gems/2.7.0/bin/solargraph', 'stdio' ],
"\     'filetypes': [ 'ruby', 'rb' ] 
"\   } 
"\ ]

"\     'cmdline': ['/opt/homebrew/lib/ruby/gems/2.7.0/bin/solargraph', 'stdio' ],
"\     'cmdline': ['/opt/rubies/ruby-2.7.5/lib/ruby/gems/2.7.0/gems/solargraph-0.44.3/bin/solargraph', 'stdio' ],

"--------GoTo code navigation
let g:coc_global_extensions = ['coc-solargraph']
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"------------ FZF ----------------
" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val  }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit'}

" - Popup window (anchored to the bottom of the current window)
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true, 'yoffset': 1.0  }  }
let g:fzf_layout = { 'down': '30%'  }

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
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

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'

"------------- Bookmarks ----------
nmap <Leader>m <Plug>BookmarkToggle
nmap <Leader>i <Plug>BookmarkAnnotate
nmap <Leader>ba <Plug>BookmarkShowAll
nmap <Leader>d <Plug>BookmarkClear
nmap <Leader>x <Plug>BookmarkClearAll

let g:bookmark_sign = '♥'

"------------ Testing ------ -
nmap <silent> <leader>t :VimuxRunCommand 'dev test '.@%<CR>
nmap <silent> <leader>a :VimuxRunCommand 'dev test .'<CR>

"------------ Open current directory --------
nmap <silent> <leader>. :VimuxRunCommand 'cd '.expand('%:h')<CR> 


"----------- Airline ----------
let g:airline#extensions#tabline#enabled = 1
let g:AirlineTheme='bubblegum'

"--------- Syntastic --------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"-------- Buffet -------
noremap <Tab> :bn<CR>
noremap <S-Tab> :bp<CR>
noremap <Leader><Tab> :Bw<CR>
noremap <Leader><S-Tab> :Bw!<CR>
noremap <C-t> :tabnew split<CR>

"-------- html auto complete
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.erb'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,phtml,erb'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filetypes = 'xhtml,jsx'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
      \ 'typescript.tsx': 'jsxRegion,tsxRegion',
      \ 'javascript.jsx': 'jsxRegion',
      \ 'typescriptreact': 'jsxRegion,tsxRegion',
      \ 'javascriptreact': 'jsxRegion',
      \ }

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
let g:closetag_close_shortcut = '<leader>>'

"----- Rubocop
let g:vimrubocop_keymap = 0
nmap <Leader>rc :RuboCop<CR>
nmap <Leader>ra :RuboCop -a<CR>

" Navigate quickfix list with ease
nnoremap <silent>[ :cprevious<CR>
nnoremap <silent>] :cnext<CR>



