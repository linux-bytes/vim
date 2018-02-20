" Create by Jerry Zhou
" uulinux@gmail.com
" 2018:02/20

" ------------------------------------------------------------------------------
" For the vim scripts manager --- vim plug
" ------------------------------------------------------------------------------

function! s:configure_plugins_manager()
	" Plugins will be downloaded under the specified directory.
	call plug#begin('~/.vim/plugged')

	" Declare the list of plugins.

	" List ends here. Plugins become visible to Vim after this call.
	call plug#end()

	" Make a configure of some plugins.
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
