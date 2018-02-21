" Create by Jerry Zhou
" uulinux@gmail.com
" 2018:02/20

" ------------------------------------------------------------------------------
" For bufexplorer
" ------------------------------------------------------------------------------
"
function! s:configure_plugins_bufexplorer()
	" <leader>b opens the buffer list
	noremap		<leader>b			:BufExplorer<cr>
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" For NREDTree
" ------------------------------------------------------------------------------
"
function! s:configure_plugins_nredtree()
	noremap		<F6>				:NERDTreeToggle<cr>
	" Putting NERDTree window right
	let g:NERDTreeWinPos                        ='right'
	let g:nerdtree_tabs_open_on_console_startup =1
	" Ignore these files
	let g:NERDTreeIgnore                        =['\.o', '\.pyc','\~$','\.swp']
	" Show the bookmarks
	let g:NERDTreeShowBookmarks                 =1
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" For ultiSnips
" ------------------------------------------------------------------------------
"
function! s:configure_plugins_ultisnips()
	" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
	let g:UltiSnipsExpandTrigger       ="<c-tab>"
	let g:UltiSnipsJumpForwardTrigger  ="<c-Right>"
	let g:UltiSnipsJumpBackwardTrigger ="<c-Left>"

	" If you want :UltiSnipsEdit to split your window.
	let g:UltiSnipsEditSplit           ="vertical"
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" For Airline
" ------------------------------------------------------------------------------
"
function! s:configure_plugins_airline()
	" set it after fonts has been installed.
	let g:airline_powerline_fonts		=1

	if !exists('g:airline_symbols')
		let g:airline_symbols			={}
	endif
	" unicode symbols
	let g:airline_left_sep				='▶'
	let g:airline_left_alt_sep			='❯'
	let g:airline_right_sep				='◀'
	let g:airline_right_alt_sep			='❮'
	let g:airline_symbols.linenr		='¶'
	let g:airline_symbols.branch		='⎇'

	" Setting the theme
	let g:airline_theme					='badwolf'

	" Enable the list of buffers
	let g:airline#extensions#tabline#enabled		=1
	" Show just the filename
	let g:airline#extensions#tabline#fnamemod		=':t'
	"let g:airline#extensions#tabline#left_sep		=' '
	"let g:airline#extensions#tabline#left_alt_sep	='|'

	let g:airline#extensions#whitespace#enabled		=0
	autocmd FileType python  let g:airline#extensions#whitespace#enabled=1
	autocmd BufReadPre  *.c  let g:airline#extensions#whitespace#enabled=0
	autocmd BufReadPre  *.h  let g:airline#extensions#whitespace#enabled=0
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" For gitgutter
" ------------------------------------------------------------------------------
"
function! s:configure_plugins_gitgutter()
	" To disable all key mappings:
	let g:gitgutter_map_keys		=0

	" Use a custom grep command
	let g:gitgutter_grep			='grep'

	" To turn off vim-gitgutter by default
	" let g:gitgutter_enabled		=0

	" To turn off signs by default
	" let g:gitgutter_signs			=0

	" To turn on line highlighting by default
	let g:gitgutter_highlight_lines	=1

	" To turn off asynchronous updates
	let g:gitgutter_async			=0
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" For CtrlP
" ------------------------------------------------------------------------------
"
function! s:configure_plugins_ctrlp()
	let g:ctrlp_map				='<c-p>'
	let g:ctrlp_cmd				='CtrlP'
	" 1: search file by file name
	" 0: search file by full path
	let g:ctrlp_by_filename		=0
	" Set no file limit, we are building a big project
	let g:ctrlp_max_files		=0

	" If ag is available use it as filename list generator instead of 'find'
	" if executable("ag")
	"     set grepprg=ag\ --nogroup\ --nocolor
	"     let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --ignore ''.git'' --ignore ''.DS_Store'' --ignore ''node_modules'' --hidden -g ""'
	" endif
	let g:ctrlp_user_command	={
				\ 'types': {
				\ 1: ['.git', 'cd %s && git ls-files -co --exclude-standard'],
				\ 2: ['.hg', 'hg --cwd %s locate -I .'],
				\ },
				\ 'fallback': 'ag %s -l --nocolor -g ""'
				\ }
	let g:ctrlp_match_window	='bottom,order:btt,min:1,max:100,results:1000'

	" PyMatcher for CtrlP
	let g:ctrlp_match_func		={ 'match': 'pymatcher#PyMatch'}

	" Set delay to prevent extra search
	let g:ctrlp_lazy_update		=350

	" Do not clear filenames cache, to improve CtrlP startup
	" You can manualy clear it by <F5>
	let g:ctrlp_clear_cache_on_exit	=0

	" For CtrlPFunky
	nnoremap	<c-\>			:CtrlPFunky<Cr>
	" narrow the list down with a word under cursor
	nnoremap	<c-?>			:execute 'CtrlPFunky ' . expand('<cword>')<Cr>
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" For YouCompleteMe
" ------------------------------------------------------------------------------
"
function! BuildYouCompleteMe(info)
	" info is a dictionary with 3 fields
	" - name:   name of the plugin
	" - status: 'installed', 'updated', or 'unchanged'
	" - force:  set on PlugInstall! or PlugUpdate!
	if a:info.status == 'installed' || a:info.force
		!./install.py --clang-completer
		!./install.py --java-completer
	endif
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" For Tagbar
" ------------------------------------------------------------------------------
"
function! s:configure_plugins_tagbar()
	nnoremap	<silent><F8>		:TagbarToggle<CR>

	let g:tagbar_left	=1
	let g:tagbar_width	=30
	"let g:tagbar_expand	=1
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" For the vim scripts manager --- vim plug
" ------------------------------------------------------------------------------

function! s:configure_plugins_manager()
	" Plugins will be downloaded under the specified directory.
	call plug#begin('~/.vim/plugged')

	" Declare the list of plugins.
	Plug 'jlanzarotta/bufexplorer'

	Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}

	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'

	Plug 'Lokaltog/vim-powerline'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

	Plug 'airblade/vim-gitgutter'

	Plug 'ctrlpvim/ctrlp.vim'
	Plug 'FelikZ/ctrlp-py-matcher'
	Plug 'tacahiroy/ctrlp-funky'

	Plug 'Valloric/YouCompleteMe', {'for': ['c', 'h', 'cpp', 'python', 'java'], 'do': function('BuildYouCompleteMe') }

	Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}

	Plug 'andreyugolnik/manpageview', {'for': ['c', 'h', 'cpp']}

	Plug 'aperezdc/vim-template'

	Plug 'aklt/plantuml-syntax', {'for': ['pu', 'uml', 'plantuml']}

	" List ends here. Plugins become visible to Vim after this call.
	call plug#end()

	" Make a configure of some plugins.
	call s:configure_plugins_bufexplorer()
	call s:configure_plugins_nredtree()
	call s:configure_plugins_ultisnips()
	call s:configure_plugins_airline()
	call s:configure_plugins_gitgutter()
	call s:configure_plugins_ctrlp()
	call s:configure_plugins_tagbar()
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" Some global and basic settings
" ------------------------------------------------------------------------------
"
function! s:configure_base_settings()
	" It's not compatible with vi
	set nocompatible

	" Set the max number instructions recorded in last vim running.
	set viminfo='20,\"50
	set history=200

	" Make the Time is in English
	language time en_US.UTF8

	filetype plugin on
	filetype indent on

	set nobackup
	set nowb
	set noswapfile

	set showcmd

	colorscheme evening
	set laststatus=2
	set ruler

	if &t_Co > 2 || has("gui_running")
		syntax on
		set hlsearch
	endif

	if !has("gui_running")
		set mouse=i
		set cursorline
		hi cursorline    guibg=#000000
		hi CursorColumn  guibg=#333333
	endif

	set number

	let g:username="Jerry Zhou"
	let g:email="uulinux@gmail.com"
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" Some  settings related with file, such as encoding.
" ------------------------------------------------------------------------------
"
function! s:configure_file_encoding()
	set fileformats=unix

	" Try the following encodings when open a file.
	set fileencodings=utf-8,gb2312,cp936,gbk,big5,ucs-bom,latin

	if has("win32")
		set fileencoding=cp936
	else
		set fileencoding=utf-8
	endif

	set encoding=utf-8

	" correspondence with Terminal
	let &termencoding=&encoding
	" set termencoding=cp936

	" Try to use chinese user manual if it exists.
	set helplang=cn
	" Fix the Chinese character issue at end of a line
	set formatoptions+=rmM
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" Some global shortkey settings according to my own preferences
" ------------------------------------------------------------------------------
"
function! s:configure_global_shortkey()
	" make spece key as vim leader key
	let g:mapleader =" "

	" Change logic line to screen line
	noremap		<C-J>				gj
	noremap		<C-K>				gk
	noremap		<Down>				gj
	noremap		<Up>				gk
	inoremap	<Down>				<c-o>gj
	inoremap	<Up>				<c-o>gk

	" For switching windows
	noremap		<c-Up>				<c-w><up>
	noremap		<c-Left>			<c-w><left>
	noremap		<c-Right>			<c-w><right>
	noremap		<c-Down>			<c-w><down>

	inoremap	<c-Up>				<c-o><c-w><up>
	inoremap	<c-Left>			<c-o><c-w><left>
	inoremap	<c-Right>			<c-o><c-w><right>
	inoremap	<c-Down>			<c-o><c-w><down>

	" For saving file
	noremap		<c-s>				:w<cr>
	inoremap	<c-s>				<C-O>:browse confirm w<cr>

	" In Normal mode:
	" ctrl + space:		insert a space without vim mode changing
	" ctrl + CR:		insert a line without vim mode changing
	noremap		<c-Space>			i <Esc>
	noremap		<c-CR>				o<Esc>k

	" Jump to next/previous error
	noremap		<c-.>				:cn<cr>
	noremap		<c-,>				:cp<cr>

	" <leader>t:	open a new tab
	noremap		<leader>t			:tabnew<cr>

	" Ctrl+A:		select all
	noremap		<leader>a			ggVG
	" Ctrl+F:		select code block in brackets, such as: (...) {...} [...]
	noremap		<leader>f			v%

	" <leader>p		Paste the content of external GUI clipboard to here
	" <leader>y		Copy the content selected to external GUI clipboard
	" <leader>k		Cut the content selected to external GUI clipboard
	noremap		<silent><leader>p	"+gP
	vnoremap	<silent><leader>y	"+y
	vnoremap	<silent><leader>k	"+x

	" <leader>q 	Delete current buffer in normal mode
	noremap		<leader>d			:bdelete<cr>
	" <leader>o		close other windows
	noremap		<leader>o			<c-w>o
	" <leader>o		close current windows/tab
	noremap		<leader>c			:confirm close<cr>

	" g[bB] in command mode switch to the next/prev. buffer
	noremap		gb					:bnext<cr>
	noremap		gB					:bprev<cr>

	if has("unix")
		noremap	<leader>e			:e <C-R>=expand("%:h") . "/" <CR>
	else
		noremap	<leader>e			:e <C-R>=expand("%:p:h") . "\" <CR>
	endif

	" close the highlight temporarily
	nmap		<silent><F2>		:nohl<cr>

	" Disable the pasting function of middle mouse key
	noremap		<MiddleMouse>		<Nop>
	inoremap	<MiddleMouse>		<Nop>

	" Recovery the pasting function of middle mouse key
	" unmap		<MiddleMouse>
	" iunmap	<MiddleMouse>

	" Format a paragraph of text
	noremap		Q					gq
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" Some settings on C file and H file
" ------------------------------------------------------------------------------
"
" This function is setting the path global variables for "gf" command
function! s:configure_linux_kernel_path()
	if !exists('g:linux_kernel_includes')
		let g:linux_kernel_includes=["arch/arm/include/", "arch/arm/mach-imx/include/", "include", "security/selinux/include/"]
	endif

	set path=.
	for item in g:linux_kernel_includes
		execute "set path+=" . item
	endfor
endfunction

function! s:configure_ft_c_h()
	setlocal tabstop=8 softtabstop=8 shiftwidth=8 textwidth=80 noexpandtab

	setlocal cindent
	setlocal autoindent
	setlocal smartindent
	setlocal grepprg     =grep\ -nH\ $*

	setlocal completeopt =longest,menu

	" Some C formatting settings
	setlocal comments& comments-=s1:/* comments^=s0:/*
	setlocal cino=c4,C4

	call s:configure_linux_kernel_path()

	" Review a function in a preview window.
	noremap		<silent>;			:ptag <C-R>=expand("<cword>")<CR><CR>
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" Some settings on python file
" ------------------------------------------------------------------------------
"
function! s:configure_ft_py()
	setlocal tabstop=8 softtabstop=8 shiftwidth=8 textwidth=80 noexpandtab

	let g:pydoc_cmd      ='/usr/bin/pydoc2.7'
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" Some settings on all files
" ------------------------------------------------------------------------------
"
function! s:configure_ft_all()
	" Putting the cursor at the same position before last exit.
	if line("'\"") > 0 && line ("'\"") <= line("$")
		exe "normal g'\""
	endif
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" Custom GUI
" ------------------------------------------------------------------------------
"
function! s:configure_gui()
	set mouse		=a
	set guitablabel	=%t

	set guifont=Inconsolata\ 11
	"set guifont=Liberation\ Mono\ 10
	"set guifont=DejaVu\ Sans\ Mono\ 10
	"set guifont=Monospace\ 10
	"set guifont=Droid\ Sans\ Mono\ 10
	"set guifont=Bitstream\ Vera\ Sans\ Mono\ 10
	"set guifont=Courier\ New\ 11
	"set guifont=Andale\ Mono\ Normal\ 10
endfunction
" ------------------------------------------------------------------------------



" ------------------------------------------------------------------------------
" The main process of VIM initialization
" ------------------------------------------------------------------------------
"
call s:configure_plugins_manager()
call s:configure_base_settings()
call s:configure_file_encoding()
call s:configure_global_shortkey()

if has("autocmd")
	autocmd FileType		c			call s:configure_ft_c_h()
	autocmd FileType		h			call s:configure_ft_c_h()

	autocmd FileType		python		call s:configure_ft_py()

	autocmd BufReadPost		*			call s:configure_ft_all()

	autocmd FileType		qf			set nowrap
	autocmd BufRead			*.txt		set tw=80
endif

if has("gui_running")
	call s:configure_gui()
endif
" ------------------------------------------------------------------------------

" vim:set ts=4 sw=4 filetype=vim:
