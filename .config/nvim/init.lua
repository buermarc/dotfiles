vim.cmd([[
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
set wrap
set hlsearch
set tabstop=8
set softtabstop=8
set shiftwidth=8
set noexpandtab
set ignorecase
set smartcase
]])

vim.cmd([[
:set number relativenumber
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END
]])

-- pasting without newlines
vim.cmd([[
set listchars=tab:\ \ ,trail:-,extends:>,nbsp:\ ,precedes:<
]])

-- when indenting with '>', use 4 spaces width
vim.o.shiftwidth = 4

-- highlight over 80
vim.cmd([[
highlight OverLength ctermbg=109 ctermfg=white guibg=#592929
]])

-- hightlight trailing whitespaces
vim.cmd([[
match Todo /\s\+$/
]])

-- On pressing tab, insert 4 spaces
vim.o.expandtab = true

-- SPELLING RULES:
-- ===============
-- Check spelling and rules based on file ending
vim.cmd([[
au BufEnter *.ts set tabstop=2
au BufEnter *.jad set filetype=java
au BufEnter *.txt set spell
au BufEnter *.txt set colorcolumn=61 | set tw=60
au BufEnter *.md set spell | set colorcolumn=81 | set tw=80
au BufEnter *.txt set colorcolumn=81 | set tw=80
au BufEnter *.tex*  set colorcolumn=101 | set tw=0 | set filetype=tex | set spell
au BufEnter *.rs*  set colorcolumn=101 | set tw=100
au BufEnter *.ger.* set spelllang=de
au BufEnter *.mu.* set spelllang=en,de
au BufEnter *.bib set nospell
au BufEnter *.md set filetype=plain
]])

-- Check Spelling and rules based on filetype
vim.cmd([[
autocmd FileType gitcommit setlocal spell
autocmd FileType text setlocal spell | setlocal spelllang=en,de
]])

vim.api.nvim_set_keymap(
  "n",
  "<M-m>",
  ":silent call jobstart('if [[ -f ./Makefile ]];then; make; elif [[ -f ./build.ninja ]];then; ninja; fi;') <CR>",
  { noremap = true }
 )

-- PLUGINS:
-- ========
vim.cmd([[
call plug#begin('~/.vim/plugged')

    Plug 'sainnhe/sonokai'

    Plug 'neovim/nvim-lspconfig'
    Plug 'mhinz/vim-signify'
    Plug 'jpalardy/vim-slime'
    Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': '/home/d074052/.pyenv/shims/python -m chadtree deps'}

    Plug 'airblade/vim-rooter'
    Plug 'junegunn/fzf.vim'

    Plug 'dpelle/vim-LanguageTool'
    Plug 'rhysd/vim-grammarous'
    " Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
    Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
    Plug 'mfussenegger/nvim-lint'

    Plug 'rhysd/vim-clang-format'
    Plug 'plasticboy/vim-markdown'

    Plug 'easymotion/vim-easymotion'
    Plug 'majutsushi/tagbar'
    Plug 'tpope/vim-fugitive'
    Plug 'vim-utils/vim-man'
    Plug 'yggdroot/indentline'
    Plug 'pechorin/any-jump.vim'

    Plug 'vim-latex/vim-latex'

    Plug 'evanleck/vim-svelte'

    "GUI
    Plug 'itchyny/lightline.vim'
call plug#end()
]])

-- ANY JUMP:
-- =========
-- Normal mode: Jump to definition under cursore
vim.api.nvim_set_keymap("n", "<leader>j", ":AnyJump<CR>", { noremap = True })
-- -- Visual mode: jump to selected text in visual mode
vim.api.nvim_set_keymap("x", "<leader>j", ":AnyJumpVisual<CR>", { noremap = True })
-- Normal mode: open previous opened file (after jump)
vim.api.nvim_set_keymap("n", "<leader>ab", ":AnyJumpBack<CR>", { noremap = True })
-- Normal mode: open last closed search window again
vim.api.nvim_set_keymap("n", "<leader>al", ":AnyJumpLastResults<CR>", { noremap = True })
-- Or override all default colors
vim.cmd([[
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
]])


-- RUST:
-- =====
vim.cmd([[
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
]])

-- -- COC:
-- -- ====
-- -- Use auocmd to force lightline update.
-- 
-- -- Use <c-space> to trigger completion.
-- vim.cmd([[
-- inoremap <silent><expr> <c-space> coc#refresh()
-- ]])
-- 
-- -- Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
-- -- position. Coc only does snippet and additional edit on confirm.
-- -- <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
-- vim.cmd([[
-- if exists('*complete_info')
--   inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
-- else
--   inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
-- endif
-- ]])
-- 
-- -- Use `[g` and `]g` to navigate diagnostics
-- vim.cmd([[
-- nmap <silent> [g <Plug>(coc-diagnostic-prev)
-- nmap <silent> ]g <Plug>(coc-diagnostic-next)
-- ]])
-- 
-- -- Use <TAB> for selections ranges.
-- vim.cmd([[
-- nmap <silent> <TAB> <Plug>(coc-range-select)
-- xmap <silent> <TAB> <Plug>(coc-range-select)
-- ]])
-- 
-- -- GoTo code navigation.
-- vim.cmd([[
-- nmap <silent> gd <Plug>(coc-definition)
-- nmap <silent> gy <Plug>(coc-type-definition)
-- nmap <silent> gi <Plug>(coc-implementation)
-- nmap <silent> gr <Plug>(coc-references)
-- ]])
-- 
-- -- coc-yank
-- vim.cmd([[
-- nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>
-- ]])
-- 
-- -- Use tab for trigger completion with characters ahead and navigate.
-- -- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
-- -- other plugin before putting this into your config.
-- -- vim.cmd([[
-- -- inoremap <silent><expr> <TAB>
-- --       \ pumvisible() ? "\<C-n>" :
-- --       \ <SID>check_back_space() ? "\<TAB>" :
-- --       \ coc#refresh()
-- -- inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
-- -- ]])
-- 
-- vim.cmd([[
-- function! s:check_back_space() abort
--   let col = col('.') - 1
--   return !col || getline('.')[col - 1]  =~# '\s'
-- endfunction
-- ]])
-- 
-- vim.cmd([[
-- command! -nargs=0 Format :call CocAction('format')
-- ]])

-- MAN Pages:
-- ==========
-- Use K to show documentation in preview window.
-- vim.cmd([[
-- nnoremap <silent> K :call <SID>show_documentation()<CR>
-- ]])

vim.cmd([[
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
]])

-- NERDTREE:
-- =========
vim.cmd([[
nnoremap <leader>e <cmd>CHADopen<cr>
]])

-- SPELLING:
-- =========
-- Language Tool
vim.cmd([[
let g:languagetool_cmd = '/usr/bin/languagetool'

let g:Tex_FoldedSections = 'comment, table'

nmap <M-c> <Plug>(grammarous-check)
nmap <M-n> <Plug>(grammarous-move-to-next-error)
nmap <M-p> <Plug>(grammarous-move-to-previous-error)
nmap <M-w> <Plug>(grammarous-move-to-info-window)
nmap <M-f> <Plug>(grammarous-fixit)
nmap <M-r> <Plug>(grammarous-remove-error)
]])

-- TAGBAR:
-- ========
-- tagbar
vim.cmd([[
nmap <F8> :TagbarToggle<CR>
]])

-- GUI AND COLORS:
-- ===============

-- Colors:
-- ------
vim.cmd([[
hi ColorColumn ctermbg=109
hi Pmenu guibg=#1b1b1b ctermbg=gray
colorscheme sonokai
]])

-- Cursor:
-- -------
vim.cmd([[
set cursorline
:nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

:hi CocFloating ctermbg=black
:hi CocErrorFormat ctermbg=black
]])
-- Go back to last line when opening file
vim.cmd([[
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
]])

-- LIGHTLINE:
-- ----------

vim.cmd([[
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

let g:lightline = {
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ }
      \ }

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction
let g:lightline.colorscheme = 'sonokai'
]])


-- UNDO DIR:
-- =========
-- Let's save undo info!
vim.cmd([[
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile
]])

vim.g.slime_target = "tmux"
vim.g.slime_paste_file = "/tmp/.slime_paste"
vim.g.slime_default_config = {socket_name="default", target_pane="slime:1.1"}

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<M-e>', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- local lint = require('lint')
-- lint.linters_by_ft = {
--   python = {'flake8', },
-- }
-- vim.cmd([[
-- au BufWrite <buffer> lua require('lint').try_lint()
-- ]])

vim.g.python3_host_prog="/home/d074052/.pyenv/shims/python3"
vim.g.coq_settings = { auto_start= 'shut-up' }
-- local servers = { 'pyright', 'texlab', 'rust_analyzer', }
local servers = { 'pyright', 'rust_analyzer', 'clangd', }
local coq = require("coq")
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end

vim.api.nvim_set_keymap(
  "n",
  "<M-g>",
  ":Git blame <CR>",
  { noremap = true }
 )

vim.api.nvim_set_keymap(
  "n",
  "<M-t>",
  ":Files <CR>",
  { noremap = true }
 )

vim.api.nvim_set_keymap(
  "n",
  "<M-b>",
  ":Bu <CR>",
  { noremap = true }
 )
