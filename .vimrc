set nocompatible
filetyp off
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.fzf
set number
syntax on
set laststatus=2
filetype indent plugin on
set confirm
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}
set wrap
set hlsearch
"set tabstop=4
"Linux Kernel
set tabstop=8
set softtabstop=8
set shiftwidth=8
set noexpandtab
set ignorecase
set smartcase

:set number relativenumber
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" pasting without newlines 
set listchars=tab:\ \ ,trail:-,extends:>,nbsp:\ ,precedes:<

" when indenting with '>', use 4 spaces width
set shiftwidth=4

" highlight over 80
highlight OverLength ctermbg=109 ctermfg=white guibg=#592929

" On pressing tab, insert 4 spaces
set expandtab
set belloff=all

" Check spelling for files: Ugly, but haven't figured out a better way yet
au BufEnter *.tex set spell 
au BufEnter *.ts set tabstop=2
au BufEnter *.jad set filetype=java 
au BufEnter *.txt set spell 
au BufEnter *.txt set colorcolumn=61 | set tw=60
au BufEnter *.md set spell 
au BufEnter *.tex*  set colorcolumn=101 | set tw=100
au BufEnter *.md*  set colorcolumn=201 | set tw=200
au BufEnter *.rs*  set colorcolumn=101 | set tw=100
au BufEnter *.ger.* set spelllang=de
au BufEnter *.bib set nospell 
au BufEnter *.md set filetype=plain 

" Colors 
hi ColorColumn ctermbg=109

" anyjump stuff =========
" Normal mode: Jump to definition under cursore
nnoremap <leader>j :AnyJump<CR>
" " Visual mode: jump to selected text in visual mode
xnoremap <leader>j :AnyJumpVisual<CR>
" " Normal mode: open previous opened file (after jump)
nnoremap <leader>ab :AnyJumpBack<CR>
" " Normal mode: open last closed search window again
nnoremap <leader>al :AnyJumpLastResults<CR>
" Or override all default colors
let g:any_jump_window_width_ratio  = 0.9
let g:any_jump_colors = {
      \"plain_text":         "Comment",
      \"preview":            "Comment",
      \"preview_keyword":    "Operator",
      \"heading_text":       "Function",
      \"heading_keyword":    "Identifier",
      \"group_text":         "Comment",
      \"group_name":         "Function",
      \"more_button":        "Operator",
      \"more_explain":       "Comment",
      \"result_line_number": "Comment",
      \"result_text":        "Statement",
      \"result_path":        "String",
      \"help":               "Comment"
      \}

hi Pmenu guibg=#1b1b1b ctermbg=gray

imap <ALT+a> - {\"a}
imap <ALT+u> - {\"u}
imap <ALT+o> - {\"o}

call plug#begin('~/.vim/plugged')
        " Mail
    Plug 'felipec/notmuch-vim'
    Plug 'neovim/neovim-ruby'
        " Stuff
    Plug 'airblade/vim-rooter'
    Plug 'junegunn/fzf.vim'
    Plug 'scrooloose/nerdtree'
    Plug 'scrooloose/syntastic'
	" Semantic language support
    Plug 'rhysd/vim-grammarous' 
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

	" Syntactic language support
    Plug 'cespare/vim-toml'
    Plug 'stephpy/vim-yaml'
    Plug 'rhysd/vim-clang-format'
    Plug 'plasticboy/vim-markdown'

    Plug 'easymotion/vim-easymotion'
    Plug 'majutsushi/tagbar'
    Plug 'mhinz/vim-grepper'
    Plug 'tpope/vim-fugitive'
    Plug 'vim-scripts/a.vim'
    Plug 'vim-utils/vim-man'
    Plug 'yggdroot/indentline'
    Plug 'pechorin/any-jump.vim'
    Plug 'vim-latex/vim-latex'
    
    "GUI
    Plug 'itchyny/lightline.vim'
call plug#end()

" Bunch of stuff from rust guy

" racer + rust
" https://github.com/rust-lang/rust.vim/issues/192
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use <TAB> for selections ranges.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)



" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" My stuff, better logfile reading
au BufRead,BufNewFile *.out set filetype=rust
au BufRead,BufNewFile *.err set filetype=rust
set tabpagemax=100

" nerdtree
map <C-n> :NERDTreeToggle<CR>


" tagbar
nmap <F8> :TagbarToggle<CR>

nmap <M-c> <Plug>(grammarous-check)
nmap <M-n> <Plug>(grammarous-move-to-next-error)
nmap <M-p> <Plug>(grammarous-move-to-previous-error)
nmap <M-w> <Plug>(grammarous-move-to-info-window)
nmap <M-f> <Plug>(grammarous-fixit)
nmap <M-r> <Plug>(grammarous-remove-error)

:hi CocFloating ctermbg=black
:hi CocErrorFormat ctermbg=black
:nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
" Go back to last line when opening file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
