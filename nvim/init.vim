if exists('+termguicolors')
  set termguicolors
endif
" ----------- General settings 
set nocompatible
set nu
set wrap!
set ignorecase
set smartcase
set backspace=indent,eol,start

set incsearch
set hlsearch

set autoindent
set smartindent
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab
set cursorline
set cursorcolumn

set list
"set lcs+=space:·
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.cache 

"----------- Key Mappings
let mapleader = " "

" Copy to system clipboard with yank
vnoremap y "+y

"--- Normal Shortcuts
inoremap jk <esc>
nnoremap <C-s> :w<CR>
inoremap <C-s> <esc>:w<CR>

nnoremap <2-LeftMouse> i

nnoremap qq :q<CR>
nnoremap Q :qa!<CR>
nnoremap ss :w<CR>
nnoremap S :wa!<CR>

" Navigate quickfix list with ease
nnoremap [ :cprevious<CR>
nnoremap ] :cnext<CR>

"--- Buffer -------
noremap <Tab> :bn<CR>
noremap <S-Tab> :bp<CR>

"----- Folding -----
nnoremap <leader>c za
nnoremap <leader>o zR

map ∆ <A-j>
map ˚ <A-k>
map ƒ <A-f>
map ø <A-o>

nnoremap <A-k> :m -2<CR>
nnoremap <A-j> :m +1<CR>
vnoremap <A-k> :m'<-2<CR>gv=`>my`<mzgv`yo`z
vnoremap <A-j> :m'>+<CR>gv=`<my`>mzgv`yo`z

" -------------- VIM Plug ------
call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'pseewald/vim-anyfold'
Plug 'djoshea/vim-autoread'

" ------ Auto complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-solargraph'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'github/copilot.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'alvan/vim-closetag'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }

Plug 'scrooloose/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'qpkorr/vim-bufkill'

" -- Themes
Plug 'sainnhe/everforest'
Plug 'blueyed/vim-diminactive'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" -- Ruby
Plug 'vim-ruby/vim-ruby'

" -- Javascript
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'mxw/vim-jsx'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'jparise/vim-graphql'

" ---- other util
Plug 'tpope/vim-fugitive'
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'preservim/vimux'
Plug 'mattesgroeger/vim-bookmarks'
Plug 'ruanyl/vim-gh-line'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

Plug 'wellle/context.vim'

call plug#end()

" Theme
lua require('configuration')

" ------- Themes ----------
let g:everforest_background = 'medium'
" let g:everforest_disable_terminal_colors = 1
let g:diminactive_use_syntax = 0
let g:diminactive_use_colorcolumn = 0
let g:diminactive_use_colorline = 0
set background=light
"colorscheme everforest
" colorscheme catppuccin

" Show trailing whitespace:
match ExtraWhitespace /\s\+$/

" Show trailing whitespace and spaces before a tab:
match ExtraWhitespace /\s\+$\| \+\ze\t/

" Show tabs that are not at the start of a line:
match ExtraWhitespace /[^\t]\zs\t\+/

" Show spaces used for indenting (so you use only tabs for indenting).
match ExtraWhitespace /^\t*\zs \+/

"--------- Buffers -----------
nnoremap <C-b> :Buffers <CR>
nnoremap <Leader>db :BD <CR>
nnoremap <C-j> <C-o>
nnoremap <C-k> <C-i>

"------------- EASY MOTION ---------
map <Leader>w <Plug>(easymotion-w)
map <Leader>b <Plug>(easymotion-b)
map <Leader><down> <Plug>(easymotion-j)
map <Leader><up> <Plug>(easymotion-k)
map <Leader>/ <Plug>(easymotion-jumptoanywhere)

"- NERDTree ------------------------------------------------------------
nnoremap <C-n> :NERDTreeRefreshRoot \| :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTreeRefreshRoot \|:NERDTreeFind<CR>
nnoremap <leader>r. :NERDTreeRefreshRoot<CR>

"- NERDCommenter---------------------------------------------------------
let NERDSpaceDelims=1
map <leader>ccsdfklj <Plug>NERDCommenterComment
map <leader>cc <Plug>NERDCommenterToggle

" - FZF ----------------------------------------------------------------
nnoremap <c-o> :FZF<CR>

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

nnoremap <silent> <Leader>f :Rg <C-R><C-W><CR>
nnoremap <silent> <A-f> :Rg<CR>
nnoremap <silent> <C-p> :Telescope find_files path_display={"truncate"}<CR>
nnoremap <silent> <C-f> :Telescope live_grep path_display={"truncate"}<CR>
nnoremap <silent> <S-f> :BLines<CR>
nnoremap ? :BLines<CR>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

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

" ---------- COC
let g:coc_global_extensions = [
\  'coc-json',
\  'coc-git',
\  'coc-solargraph',
\  'coc-eslint',
\  'coc-yaml',
\  'coc-graphql',
\  'coc-tsserver',
\  'coc-spell-checker']

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
"
nmap <silent>rn <Plug>(coc-rename)

inoremap <silent><expr> <C-j>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr><C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <C-[> <Plug>(coc-diagnostic-prev)
nmap <C-]> <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"nnoremap <silent><nowait> <leader>O  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <A-o> :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <leader>cl <Plug>(coc-codelens-action)
nnoremap <silent><nowait> <leader>s :<C-u>CocList -I symbols<cr>

" ------------ VIMUX ------
autocmd FileType ruby nmap <silent> <leader>T :VimuxRunCommand 'dev test '.@%<CR>
autocmd FileType ruby nmap <silent> <leader>t :VimuxRunCommand('dev test '.@%.':'.line('.'))<CR>
autocmd FileType javascript nmap <silent> <leader>t :VimuxRunCommand 'yarn test --watch '.@%<CR>
autocmd FileType typescript nmap <silent> <leader>t :VimuxRunCommand 'yarn test --watch '.@%<CR>

" Open current directory -------- -------t .
nmap <silent> <leader>. :VimuxRunCommand 'popd; pushd '.expand('%:h')<CR>

" ----------------- Github
nnoremap <silent> <Leader>gb :Git blame<CR>
nnoremap <silent> <Leader>diff :Gvdiffsplit<CR>
nnoremap <silent> <Leader>gs :Git<CR>
nnoremap <silent> <Leader>gc :Git commit<CR>

" -------- copilot
let g:copilot_no_tab_map = v:true
imap <silent><script><expr> <S-Tab> copilot#Accept("\<CR>")

" ------------- Bookmarks ----------
nmap <Leader>bm <Plug>BookmarkToggle
nmap <Leader>bma <Plug>BookmarkAnnotate
nmap <Leader>abm <Plug>BookmarkShowAll
nmap <Leader>dbm <Plug>BookmarkClear
nmap <Leader>cbm <Plug>BookmarkClearAll

let g:bookmark_sign = '♥'

" ---------- CloseTag ------------
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
let g:closetag_filetypes = 'html,xhtml,phtml'
let g:closetag_xhtml_filetypes = 'xhtml,jsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'

"------------- MarkdownPreview -------------
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 0

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" for path with space
" valid: `/path/with\ space/xxx`
" invalid: `/path/with\\ space/xxx`
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0,
    \ 'toc': {}
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or empty for random
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name

let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" set default theme (dark or light)
" By default the theme is define according to the preferences of the system
let g:mkdp_theme = 'light'

" example
nmap <leader>md <Plug>MarkdownPreviewToggle

"-- Spell checker ----
vmap <leader>j <Plug>(coc-codeaction-selected)<down>
nmap <leader>j <Plug>(coc-codeaction-selected)<down>

"------- Javascript Syntax ------
let g:vim_jsx_pretty_highlight_close_tag = 1
let g:vim_jsx_pretty_colorful_config = 1

" -------- Autopairs ----------
let g:AutoPairsMultilineClose = 0

vmap <leader>( S)
vmap <leader>{ S}
vmap <leader>[ S]
vmap <leader>' S'
vmap <leader>" S"
vmap <leader>< S>
vmap <leader>` S`

nmap <leader>) ds(
nmap <leader>} ds{
nmap <leader>] ds[
nmap <leader>d' ds'
nmap <leader>d" ds"
nmap <leader>> ds<
nmap <leader>d` ds`

nmap <leader>( ysiw)
nmap <leader>{ ysiw}
nmap <leader>[ ysiw]
nmap <leader>' ysiw'
nmap <leader>" ysiw"
nmap <leader>< ysiw>
nmap <leader>` ysiw

nmap <leader>c" cs'"
nmap <leader>c' cs"'
nmap <leader>c` cs'`


"-------- Anyfold ----------
" filetype plugin indent on
" syntax on
autocmd Filetype * AnyFoldActivate
hi Folded term=underline
let g:anyfold_fold_comments = 1
set foldlevel=99

"--------- Context -------------
let g:context_enabled = 1

colorscheme catppuccin-frappe
