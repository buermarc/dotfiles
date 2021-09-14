set nocompatible
set mouse=a
filetyp off
set encoding=utf-8
set fileencoding=utf-8
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
" match OverLength /\%81v.\+/
" set colorcolumn=81
" set tw=80

" On pressing tab, insert 4 spaces
set expandtab
set belloff=all


" Check spelling and rules based on file ending
au BufEnter *.ts set tabstop=2
au BufEnter *.jad set filetype=java
au BufEnter *.txt set spell
" au BufEnter *.txt match OverLength /\%61v.\+/ | set colorcolumn=61 | set tw=60
au BufEnter *.txt set colorcolumn=61 | set tw=60
" au BufEnter *.ltxt match OverLength /\%99999v.\+/
au BufEnter *.md set spell | set colorcolumn=81 | set tw=80
au BufEnter *.txt set colorcolumn=81 | set tw=80
" au BufEnter *.tex* match OverLength /\%201v.\+/ | set colorcolumn=101 | set tw=100
au BufEnter *.tex*  set colorcolumn=101 | set tw=0 | set filetype=tex | set spell
" au BufEnter *.rs* match OverLength /\%101v.\+/ | set colorcolumn=101 | set tw=100
au BufEnter *.rs*  set colorcolumn=101 | set tw=100
au BufEnter *.ger.* set spelllang=de
au BufEnter *.mu.* set spelllang=en,de
au BufEnter *.bib set nospell
au BufEnter *.md set filetype=plain
" au BufEnter /home/mulc/dh-stuff/iot/aufgabe1/* set encoding=utf-8
"au BufReadPost *.docx :%!pandoc -f docx -t markdown
"au BufWritePost *.docx :!pandoc -f markdown -t docx % > tmp.docx
"au BufReadPost /home/mulc/repos/the-hard-way/* :CocDisable

" Check Spelling and rules based on filetype 
autocmd FileType gitcommit setlocal spell
autocmd FileType text setlocal spell | setlocal spelllang=en,de
" TODO create R vim binding to send current line to a tmux session running R
" autocmd FileType r map <C-CR> 

" Colors TODO comment them out
"hi SpellBad ctermbg=5
"hi SpellRare ctermbg=205
hi ColorColumn ctermbg=109

"
" Vim Zoom to CTRL-W + U
nnoremap <silent> <C-w>u :ZoomWin<CR>

nnoremap <M-m> :call jobstart('if [[ -f ./Makefile ]];then; make; elif [[ -f ./build.ninja ]];then; ninja; fi;') <CR>

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
        " Snippets
    "Plug 'SirVer/ultisnips'

        " Mail
    Plug 'felipec/notmuch-vim'
    Plug 'neovim/neovim-ruby'
        " Stuff
    Plug 'airblade/vim-rooter'
    Plug 'junegunn/fzf.vim'
    Plug 'scrooloose/nerdtree'
    Plug 'scrooloose/syntastic'
	" Semantic language support
    Plug 'dpelle/vim-LanguageTool'
    Plug 'rhysd/vim-grammarous'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

	" Syntactic language support
	Plug 'cespare/vim-toml'
	Plug 'stephpy/vim-yaml'
	"Plug 'rust-lang/rust.vim'
	Plug 'rhysd/vim-clang-format'
    Plug 'plasticboy/vim-markdown'
    Plug 'vim-scripts/ZoomWin'

    " Plug 'justinmk/vim-dirvish'
    Plug 'easymotion/vim-easymotion'
    Plug 'majutsushi/tagbar'
    Plug 'mhinz/vim-grepper'
    Plug 'tpope/vim-fugitive'
    Plug 'vim-scripts/a.vim'
    Plug 'vim-utils/vim-man'
    Plug 'yggdroot/indentline'
    Plug 'pechorin/any-jump.vim'
    Plug 'tpope/vim-surround'
    " Plug 'davidhalter/jedi-vim'
       " Plug 'shougo/neocomplete'
    Plug 'vim-latex/vim-latex'
    " Plug 'mfussenegger/nvim-jdtls'

    "GUI
    Plug 'itchyny/lightline.vim'
    "Plug 'vim-airline/vim-airline'

    " R Studio emulation
    Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
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

" coc-yank
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>



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

" My stuff
au BufRead,BufNewFile *.out set filetype=rust
au BufRead,BufNewFile *.err set filetype=rust
set tabpagemax=100

" nerdtree
map <C-n> :NERDTreeToggle<CR>


" syntastic recommended settings
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:loaded_syntastic_java_javac_checker = 1

"Language Tool
let g:languagetool_cmd = '/usr/bin/languagetool'
" neocomplete
" let g:neocomplete#enable_at_startup = 1

let g:Tex_FoldedSections = 'comment, table'

"nmap <F3> :SyntasticToggleMode<CR>

" tagbar
nmap <F8> :TagbarToggle<CR>

nmap <M-c> <Plug>(grammarous-check)
nmap <M-n> <Plug>(grammarous-move-to-next-error)
nmap <M-p> <Plug>(grammarous-move-to-previous-error)
nmap <M-w> <Plug>(grammarous-move-to-info-window)
nmap <M-f> <Plug>(grammarous-fixit)
nmap <M-r> <Plug>(grammarous-remove-error)

set cursorline
":hi CursorLine   cterm=NONE ctermbg=black ctermfg=white guibg=black guifg=white
":hi CursorColumn cterm=NONE ctermbg=darkblue ctermfg=white guibg=darkblue guifg=white
:hi CocFloating ctermbg=black
:hi CocErrorFormat ctermbg=black
command! -nargs=0 Format :call CocAction('format')
:nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
" Go back to last line when opening file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif


 " Let's save undo info!
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile
