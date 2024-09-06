set scrolloff=8
set number relativenumber
set ignorecase	                                              " Always case-insensitive
set backspace=2                                               " allow backspace beyond insertion point
set shiftwidth=2                                              " Indenting is 4 spaces
set expandtab                                                 " Convert tabs to spaces
set autoindent                                                " carry over indenting from previous line
set smartindent                                               " indent braces automtically
set softtabstop=2                                             " make 2 spaces act like tabs
set tabstop=2                                                 " Indent using two spaces.
set hlsearch                                                  " enable search highlighting
set ignorecase                                                " Ignore case when searching
set incsearch                                                 " Incremental search that shows partial matches
set smartcase                                                 " Automatically switch search to case sensitive when search query contains uppercase letter
set linebreak                                                 " Avoid wrapping a line in the middle of a word
syntax on                                                     " Enable syntax highlighting
set wrap                                                      " Enable line wrapping
set laststatus=2                                              " Always display the status bar
set wildmenu	                                                " Display command line's tab complete options as a menu
set number	                                                  " Show line numbers on the sidebar
set mouse=a	                                                  " Enable mouse for scrolling and resizing
set title                                                     " Set the window's title to file currently being edited
set background=dark                                           " Use colors that suit a dark background
set foldmethod=indent                                         " Fold based on indentation levels
set history=1000 	                                            " Increase the undo limit
set clipboard+=unnamed                                        " put yanks/etc on the clipboard
set copyindent                                                " make autoindent use the same characters to indent
set foldlevelstart=99                                         " start with all folds open
set comments=b://,b:#,b:*                                     " by default allow JS and "unixy" comments, *-lists
set showcmd                                                   " show command-in-progress
set wildmenu                                                  " enable menu of completions
set wildmode=longest:full,full                                " complete only as much as is common, then show menu
set encoding=utf8                                             " utf-8 encoding
set termguicolors
autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 expandtab  " Set spaces to 2 when yaml file
set textwidth=80
set <M-e>=å
set hidden


" (for airline) 
let g:airline_powerline_fonts = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                  Searching
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""                  
" Replace vimgrep with ripgrep
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat=%f:%l:%c:%m

" vim-plug

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/vimplugs')
" Plug 'inkarkat/vim-ingo-library'
"Plug 'inkarkat/vim-LineJuggler'
"Plug 'arzg/vim-colors-xcode'
Plug 'terryma/vim-expand-region'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-fugitive'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'ap/vim-css-color'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
" Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary'
" Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'godlygeek/tabular'
Plug 'zivyangll/git-blame.vim'
" Plug 'arcticicestudio/nord-vim'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'mechatroner/rainbow_csv'
Plug 'dense-analysis/ale'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'rhysd/vim-lsp-ale'

Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autopairs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:AutoPairsShortcutFastWrap = '<M-e>'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                 Theme settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set t_8f=[38;2;%lu;%lu;%lum
" set t_8b=[48;2;%lu;%lu;%lum
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" set term=xterm
" colorscheme bouquet
" set t_Co=256
highlight Normal ctermbg=none ctermfg=none

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                 Theme settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let b:ale_linters = {'python':['pylint', 'mypy']}
let b:ale_fixers = {'python': ['black', 'isort', 'remove_trailing_lines', 'trim_whitespace']}

let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1
let g:ale_disable_lsp = 1
let g:ale_lint_on_enter = 0
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
"                 Remaps
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = " "


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
"                 lightline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {'colorscheme': 'catppuccin_mocha'}

"--------------------
"" AIRLINE
""--------------------
"
"" show buffers (vim airline setting)
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#buffer_nr_show = 1"
" let g:airline_theme = 'catppuccin_mocha'

"""""" File Browser
"
" open in vertical split
nnoremap <leader>pv :Vex<CR>
" open in horizonal split
nnoremap <leader>ph :Sex<CR>
" open in current window
nnoremap <leader>px :Explore<CR>
nnoremap <leader>o :CtrlP<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


" Switch between files in buffer
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" insert new line above without entering insert mode
" nmap oo o<Esc>k

" insert new line under without entering insert mode
" nmap 00 0<Esc>j

" Git blame
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>

" <leader> you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Fast saving
nmap <leader>w :w<CR>

" space space enters visual line mode
nmap <Leader><Leader> V

" v selects character, another v selects word, third v selects para
" <C-v> goes back one
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" 12<CR> to go to line 12
" Enter goes to end of file
" Backpace goes to beginning of file
" nnoremap <CR> G
" nnoremap <BS> gg

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on
"    means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
	set undodir=~/.vim_runtime/temp_dirs/undodir
	set undofile
catch
endtry

" open fzf
nnoremap <leader>o :Files<CR>

" Move visual selection
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

"--------------------
" SWITCH BUFFERS
"--------------------
nnoremap <leader>g :bn<cr>
nnoremap bp :bp<cr>
nnoremap bd :bd<cr>

" Hopefully this just adds the colorscheme?
" Vim color file - bouquet
" Generated by http://bytefluent.com/vivify 2023-08-06
set background=dark
if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

set t_Co=256
let g:colors_name = "bouquet"

"hi CTagsMember -- no settings --
"hi CTagsGlobalConstant -- no settings --
"hi Ignore -- no settings --
hi Normal guifg=#e9e0d2 guibg=#173f35 guisp=#173f35 gui=NONE ctermfg=187 ctermbg=23 cterm=NONE
"hi CTagsImport -- no settings --
"hi CTagsGlobalVariable -- no settings --
"hi EnumerationValue -- no settings --
"hi Union -- no settings --
"hi Question -- no settings --
"hi EnumerationName -- no settings --
"hi DefinedName -- no settings --
"hi LocalVariable -- no settings --
"hi CTagsClass -- no settings --
"hi clear -- no settings --
hi IncSearch guifg=#e9e0d2 guibg=#408e7b guisp=#408e7b gui=NONE ctermfg=187 ctermbg=66 cterm=NONE
hi WildMenu guifg=NONE guibg=#A1A6A8 guisp=#A1A6A8 gui=NONE ctermfg=NONE ctermbg=248 cterm=NONE
hi SignColumn guifg=#192224 guibg=#536991 guisp=#536991 gui=NONE ctermfg=235 ctermbg=60 cterm=NONE
hi SpecialComment guifg=#F2DDBC guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi Typedef guifg=#536991 guibg=NONE guisp=NONE gui=bold ctermfg=60 ctermbg=NONE cterm=bold
hi Title guifg=#f5cabf guibg=NONE guisp=NONE gui=bold ctermfg=224 ctermbg=NONE cterm=bold
hi Folded guifg=#192224 guibg=#A1A6A8 guisp=#A1A6A8 gui=italic ctermfg=235 ctermbg=248 cterm=NONE
hi PreCondit guifg=#eaa09c guibg=NONE guisp=NONE gui=NONE ctermfg=217 ctermbg=NONE cterm=NONE
hi Include guifg=#F2DDBC guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi TabLineSel guifg=#e9e0d2 guibg=#375549 guisp=#375549 gui=bold ctermfg=187 ctermbg=66 cterm=bold
hi StatusLineNC guifg=#173f35 guibg=#408e7b guisp=#408e7b gui=bold ctermfg=23 ctermbg=66 cterm=bold
hi NonText guifg=#5E6C70 guibg=NONE guisp=NONE gui=italic ctermfg=66 ctermbg=NONE cterm=NONE
hi DiffText guifg=NONE guibg=#8f2f19 guisp=#8f2f19 gui=NONE ctermfg=NONE ctermbg=88 cterm=NONE
hi ErrorMsg guifg=#e9e0d2 guibg=#8f2f19 guisp=#8f2f19 gui=NONE ctermfg=187 ctermbg=88 cterm=NONE
hi Debug guifg=#F2DDBC guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi PMenuSbar guifg=NONE guibg=#8aa99d guisp=#8aa99d gui=NONE ctermfg=NONE ctermbg=109 cterm=NONE
hi Identifier guifg=#e9e0d2 guibg=NONE guisp=NONE gui=NONE ctermfg=187 ctermbg=NONE cterm=NONE
hi SpecialChar guifg=#F2DDBC guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi Conditional guifg=#eaa09c guibg=NONE guisp=NONE gui=bold ctermfg=217 ctermbg=NONE cterm=bold
hi StorageClass guifg=#536991 guibg=NONE guisp=NONE gui=bold ctermfg=60 ctermbg=NONE cterm=bold
hi Todo guifg=#375549 guibg=#f2ddbc guisp=#f2ddbc gui=NONE ctermfg=66 ctermbg=223 cterm=NONE
hi Special guifg=#e9e0d2 guibg=NONE guisp=NONE gui=NONE ctermfg=187 ctermbg=NONE cterm=NONE
hi LineNr guifg=#408e7b guibg=NONE guisp=NONE gui=NONE ctermfg=66 ctermbg=NONE cterm=NONE
hi StatusLine guifg=#173f35 guibg=#408e7b guisp=#408e7b gui=bold ctermfg=23 ctermbg=66 cterm=bold
hi Label guifg=#F2DDBC guibg=NONE guisp=NONE gui=bold ctermfg=1 ctermbg=NONE cterm=bold
hi PMenuSel guifg=#173f35 guibg=#f5cabf guisp=#f5cabf gui=NONE ctermfg=23 ctermbg=224 cterm=NONE
hi Search guifg=#192224 guibg=#408e7b guisp=#408e7b gui=NONE ctermfg=235 ctermbg=66 cterm=NONE
hi Delimiter guifg=#F2DDBC guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi Statement guifg=#8dbaed guibg=NONE guisp=NONE gui=bold ctermfg=110 ctermbg=NONE cterm=bold
hi SpellRare guifg=#F9F9FF guibg=#192224 guisp=#192224 gui=underline ctermfg=189 ctermbg=235 cterm=underline
hi Comment guifg=#408e7b guibg=NONE guisp=NONE gui=italic ctermfg=66 ctermbg=NONE cterm=NONE
hi Character guifg=#A1A6A8 guibg=NONE guisp=NONE gui=NONE ctermfg=248 ctermbg=NONE cterm=NONE
hi Float guifg=#A1A6A8 guibg=NONE guisp=NONE gui=NONE ctermfg=248 ctermbg=NONE cterm=NONE
hi Number guifg=#a2a0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=147 ctermbg=NONE cterm=NONE
hi Boolean guifg=#A1A6A8 guibg=NONE guisp=NONE gui=NONE ctermfg=248 ctermbg=NONE cterm=NONE
hi Operator guifg=#eaa09c guibg=NONE guisp=NONE gui=bold ctermfg=217 ctermbg=NONE cterm=bold
hi CursorLine guifg=NONE guibg=#222E30 guisp=#222E30 gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi TabLineFill guifg=#192224 guibg=#408e7b guisp=#408e7b gui=bold ctermfg=235 ctermbg=66 cterm=bold
hi WarningMsg guifg=#A1A6A8 guibg=#912C00 guisp=#912C00 gui=NONE ctermfg=248 ctermbg=88 cterm=NONE
hi VisualNOS guifg=#192224 guibg=#F9F9FF guisp=#F9F9FF gui=underline ctermfg=235 ctermbg=189 cterm=underline
hi DiffDelete guifg=#e9e0d2 guibg=#8f2f19 guisp=#8f2f19 gui=NONE ctermfg=187 ctermbg=88 cterm=NONE
hi ModeMsg guifg=#F9F9F9 guibg=#192224 guisp=#192224 gui=bold ctermfg=15 ctermbg=235 cterm=bold
hi CursorColumn guifg=NONE guibg=#222E30 guisp=#222E30 gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi Define guifg=#F2DDBC guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi Function guifg=#eaa09c guibg=NONE guisp=NONE gui=bold ctermfg=217 ctermbg=NONE cterm=bold
hi FoldColumn guifg=#192224 guibg=#A1A6A8 guisp=#A1A6A8 gui=italic ctermfg=235 ctermbg=248 cterm=NONE
hi PreProc guifg=#a2a0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=147 ctermbg=NONE cterm=NONE
hi Visual guifg=#192224 guibg=#F9F9FF guisp=#F9F9FF gui=NONE ctermfg=235 ctermbg=189 cterm=NONE
hi MoreMsg guifg=#F2DDBC guibg=NONE guisp=NONE gui=bold ctermfg=1 ctermbg=NONE cterm=bold
hi SpellCap guifg=#F9F9FF guibg=#192224 guisp=#192224 gui=underline ctermfg=189 ctermbg=235 cterm=underline
hi VertSplit guifg=#59a390 guibg=#173f35 guisp=#173f35 gui=bold ctermfg=72 ctermbg=23 cterm=bold
hi Exception guifg=#eaa09c guibg=NONE guisp=NONE gui=bold ctermfg=217 ctermbg=NONE cterm=bold
hi Keyword guifg=#f5cabf guibg=NONE guisp=NONE gui=bold ctermfg=224 ctermbg=NONE cterm=bold
hi Type guifg=#f5cabf guibg=NONE guisp=NONE gui=bold ctermfg=224 ctermbg=NONE cterm=bold
hi DiffChange guifg=NONE guibg=#8f2f19 guisp=#8f2f19 gui=NONE ctermfg=NONE ctermbg=88 cterm=NONE
hi Cursor guifg=#192224 guibg=#F9F9F9 guisp=#F9F9F9 gui=NONE ctermfg=235 ctermbg=15 cterm=NONE
hi SpellLocal guifg=#F9F9FF guibg=#192224 guisp=#192224 gui=underline ctermfg=189 ctermbg=235 cterm=underline
hi Error guifg=#A1A6A8 guibg=#912C00 guisp=#912C00 gui=NONE ctermfg=248 ctermbg=88 cterm=NONE
hi PMenu guifg=#192224 guibg=#82b0a5 guisp=#82b0a5 gui=NONE ctermfg=235 ctermbg=109 cterm=NONE
hi SpecialKey guifg=#5E6C70 guibg=NONE guisp=NONE gui=italic ctermfg=66 ctermbg=NONE cterm=NONE
hi Constant guifg=#BBEDD2 guibg=NONE guisp=NONE gui=NONE ctermfg=152 ctermbg=NONE cterm=NONE
hi Tag guifg=#F2DDBC guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi String guifg=#BBEDD2 guibg=NONE guisp=NONE gui=NONE ctermfg=152 ctermbg=NONE cterm=NONE
hi PMenuThumb guifg=#59a390 guibg=#375549 guisp=#375549 gui=NONE ctermfg=72 ctermbg=66 cterm=NONE
hi MatchParen guifg=#F2DDBC guibg=NONE guisp=NONE gui=bold ctermfg=1 ctermbg=NONE cterm=bold
hi Repeat guifg=#a2a0f6 guibg=NONE guisp=NONE gui=bold ctermfg=147 ctermbg=NONE cterm=bold
hi SpellBad guifg=#F9F9FF guibg=#192224 guisp=#192224 gui=underline ctermfg=189 ctermbg=235 cterm=underline
hi Directory guifg=#536991 guibg=NONE guisp=NONE gui=bold ctermfg=60 ctermbg=NONE cterm=bold
hi Structure guifg=#536991 guibg=NONE guisp=NONE gui=bold ctermfg=60 ctermbg=NONE cterm=bold
hi Macro guifg=#F2DDBC guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi Underlined guifg=#F9F9FF guibg=#192224 guisp=#192224 gui=underline ctermfg=189 ctermbg=235 cterm=underline
hi DiffAdd guifg=NONE guibg=#408e7b guisp=#408e7b gui=NONE ctermfg=NONE ctermbg=66 cterm=NONE
hi TabLine guifg=#173f35 guibg=#408e7b guisp=#408e7b gui=bold ctermfg=23 ctermbg=66 cterm=bold
hi cursorim guifg=#192224 guibg=#536991 guisp=#536991 gui=NONE ctermfg=235 ctermbg=60 cterm=NONE
