" 周春华  2009 08 11 设置

" ------------------------------------------------------------------------------
" vim 模式、显示方面的设置
" ------------------------------------------------------------------------------
"
" 不兼容vi的操作
set nocompatible
" 退出vim后，再进vim，读取上次搜索等历史记录
set viminfo='20,\"50
" vim操作中，记录操作的条数
set history=200

" Enable pathogen
call pathogen#infect()
call pathogen#helptags()

" Make the Time is in English
language time en_US.UTF8

" 开启文件类型判断插件
filetype plugin on
filetype indent on
" 不使用备份
set nobackup
set nowb
" 不使用交换文件
set noswapfile

" Vistual模式下显示选中的行数
set showcmd

" 设置vim 背景颜色等主题
colorscheme evening

" 永远都显示状态栏
set laststatus=2

" 状态栏上显示光标所在的位置
set ruler

" 如果颜色数大于2，或者使用GUI界面，则打开语法高亮显示和搜索高亮显示
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

if !has("gui_running")
	" 否则只有在插入模式下，鼠标管用
	set mouse=i
	" 高亮当前行
	set cursorline
	hi cursorline    guibg=#000000
	hi CursorColumn  guibg=#333333
endif

" 显示行号
set number

let g:username="Jerry Zhou"
let g:email="uulinux@gmail.com"
let mapleader = " "

" ------------------------------------------------------------------------------
" 编码方面的设置
" ------------------------------------------------------------------------------
"
set fileformats=unix

" 打开一个文件试图用下面的编码
set fileencodings=utf-8,gb2312,cp936,gbk,big5,ucs-bom,latin

" 下面设定保存文件时，文件保存格式，windows平台强制保存为GBK，其他保存为Utf-8
if has("win32")
	set fileencoding=cp936
else
	set fileencoding=utf-8
endif

set encoding=utf-8

" 跟显示相关的，跟终端环境设成一致
let &termencoding=&encoding
" set termencoding=cp936
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
"  处理中文时，特殊处理的
" ------------------------------------------------------------------------------
"
set helplang=cn
" 正确地处理中文字符的折行和拼接
set formatoptions+=rmM
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" For ARM asm syntax
" 让Vim支持ARM汇编的语法高亮
" ------------------------------------------------------------------------------
"
let asmsyntax='armasm'
let filetype_inc='armasm'
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" 设置个人喜欢的快捷键
" ------------------------------------------------------------------------------
"
function! s:auto_config_shortkey()
	" 将逻辑行改成屏幕行
	noremap		<C-J>			gj
	noremap		<C-K>			gk
	noremap		<Down>			gj
	noremap		<Up>			gk
	inoremap	<Down>			<c-o>gj
	inoremap	<Up>			<c-o>gk

	" 方便窗口跳转
	noremap		<c-Up>			<c-w><up>
	noremap		<c-Left>		<c-w><left>
	noremap		<c-Right>		<c-w><right>
	noremap		<c-Down>		<c-w><down>

	inoremap	<c-Up>			<c-o><c-w><up>
	inoremap	<c-Left>		<c-o><c-w><left>
	inoremap	<c-Right>		<c-o><c-w><right>
	inoremap	<c-Down>		<c-o><c-w><down>

	" 增加快捷键，按Ctrl+S保存
	noremap		<c-s>			:w<cr>
	" 插入模式下，Ctrl+S另存为
	inoremap	<c-s>			<C-O>:browse confirm w<cr>
	" 普通模式下排版插入空格
	"
	noremap		<c-Space>		i <Esc>
	" 普通模式下排版插入空行
	noremap		<c-CR>			o<Esc>k

	" Jump to next/previous error
	noremap		<c-.>			:cn<cr>
	noremap		<c-,>			:cp<cr>

	" <leader>t 新开一个tab
	noremap		<leader>t		:tabnew<cr>

	" 增加快捷键，按Ctrl+A全选
	noremap		<leader>a		ggVG
	" 增加快捷键，按Ctrl+F进行括号匹配选择
	noremap		<leader>f		v%

	" 在普通模式下，按下<leader>p键，粘帖外部剪切板的文本到当前的位置
	" 在可视模式下，按下<leader>y键，复制选中的文本到外部剪贴板
	" 在可视模式下，按下<leader>k键，复制选中的文本到外部剪贴板
	noremap		<silent><leader>p	"+gP
	vnoremap	<silent><leader>y	"+y
	vnoremap	<silent><leader>k	"+x

	" 关闭Tabs :    <leader><bs>
	" noremap	<leader><bs>		<Esc><C-w>q
	noremap		<leader><bs>		<Esc>:confirm close<cr>

	" <leader>q in command mode closes the current buffer
	noremap		<leader>q			:bdelete<cr>

	" g[bB] in command mode switch to the next/prev. buffer
	noremap		gb					:bnext<cr>
	noremap		gB					:bprev<cr>

	if has("unix")
		noremap	<leader>e			:e <C-R>=expand("%:h") . "/" <CR>
	else
		noremap	<leader>e			:e <C-R>=expand("%:p:h") . "\" <CR>
	endif

	" 关闭高亮显示
	nmap		<silent><F2>		:nohl<cr>

	" 禁止鼠标中键的粘帖功能
	noremap		<MiddleMouse>		<Nop>
	inoremap	<MiddleMouse>		<Nop>

	" 恢复鼠标中键的粘帖功能
	"unmap		<MiddleMouse>
	"iunmap		<MiddleMouse>

	noremap		Q					gq

endfunction
call s:auto_config_shortkey()
" ------------------------------------------------------------------------------



" ------------------------------------------------------------------------------
" 对于编辑特殊文件时，设置一些自动命令
" ------------------------------------------------------------------------------
"
function! s:auto_config_c()
	setlocal tabstop=8
	setlocal softtabstop=8
	setlocal shiftwidth=8
	setlocal noexpandtab
	setlocal textwidth=80

	set cindent
	set autoindent
	set smartindent
	set grepprg=grep\ -nH\ $*

	set completeopt=longest,menu

	" 格式化C文件的设置
	set comments& comments-=s1:/* comments^=s0:/*
	set cino=c4,C4
endfunction

function! s:auto_config_python()
	setlocal tabstop=8
	setlocal softtabstop=8
	setlocal shiftwidth=8
	setlocal noexpandtab
	setlocal textwidth=80

	let g:pydoc_cmd='/usr/bin/pydoc2.7'
	"set omnifunc=pythoncomplete#Complete
endfunction

function! s:recovery_previous_positon()
	if line("'\"") > 0 && line ("'\"") <= line("$")
		exe "normal g'\""
	endif
endfunction

if has("autocmd")
	"autocmd BufReadPost	*.c			call s:auto_config_c()
	"autocmd BufReadPost	*.h			call s:auto_config_c()
	autocmd FileType		c			call s:auto_config_c()
	autocmd FileType		h			call s:auto_config_c()

	autocmd FileType		python		call s:auto_config_python()

	autocmd BufReadPost		*			call s:recovery_previous_positon()

	autocmd FileType		qf			set nowrap
	autocmd BufRead			*.txt		set tw=80
endif
" ------------------------------------------------------------------------------



" ------------------------------------------------------------------------------
" For LaTeX
" ------------------------------------------------------------------------------
"
function! s:auto_config_tex()
	let g:tex_flavor='latex'
	let g:Tex_CompileRule_dvi = 'latex -src-specials -interaction=nonstopmode $*'
	let g:Tex_UseEditorSettingInDVIViewer = 1
	let g:Tex_ViewRule_dvi="xdvi -editor 'gvim --servername latex-suite --remote-silent'"
endfunction
" ------------------------------------------------------------------------------



" ------------------------------------------------------------------------------
" For ShowFunc
" ------------------------------------------------------------------------------
function! s:auto_config_ShowFunc()
	let g:showfuncctagsbin="/usr/bin/ctags"
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" For mediawiki
" ------------------------------------------------------------------------------
function! s:auto_config_mediawiki()
	let g:mediawiki_editor_uri_scheme="http"
	let g:mediawiki_editor_url="192.168.10.147"
	let g:mediawiki_editor_path="/mediawiki/"
	let g:mediawiki_editor_username="jerry"
	let g:mediawiki_editor_password="xxxxxxxxx"
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" For DokuWiki
" ------------------------------------------------------------------------------
" looks for DokuWiki headlines in the first 20 lines of the current buffer
function! s:isDokuWiki()
	if match(getline(1,20),'^ \=\(=\{2,6}\).\+\1 *$') >= 0
		set textwidth=0
		set wrap
		set linebreak
		set filetype=dokuwiki
	endif
endfun

function! s:auto_config_dokuwiki()
	" check for dokuwiki syntax
	autocmd BufWinEnter *.txt call IsDokuWiki()

	" user name with which you want to login at the remote wiki
	let g:DokuVimKi_USER = 'jerry'

	" password
	let g:DokuVimKi_PASS = 'xxxxxxxxx'

	" url of the remote wiki (without trailing '/')
	let g:DokuVimKi_URL  = 'http://192.168.10.147/dokuwiki'

	" width of the index window (optional, defaults to 30)
	let g:DokuVimKi_INDEX_WINWIDTH = 40

	" set a default summary for :w (optional, defaults to [xmlrpc dokuvimki edit])
	let g:DokuVimKi_DEFAULT_SUM = 'fancy default summary'
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" 定制 GUI
" ------------------------------------------------------------------------------
"
" 对于ToolBar工具栏上的一些设定
function! s:quickfixToggle(forced)
	if exists("g:qfix_win") && a:forced == 0
		cclose
		unlet g:qfix_win
	else
		copen 5
		let g:qfix_win = bufnr("$")
	endif
endfunction

function! s:auto_config_gui()
	nmenu  590.100  我的操作.去行末空白			:%s/\s\+$//g<cr>
	vmenu  590.100  我的操作.去行末空白			:s/\s\+$//g<cr>
	nmenu  590.101  我的操作.去除空白行			:g/^\s*$/d<cr>
	vmenu  590.101  我的操作.去除空白行			:g/^\s*$/d<cr>
	nmenu  590.102  我的操作.tab变空格			:%s/\t/        /g<cr>
	vmenu  590.102  我的操作.tab变空格			:s/\t/        /g<cr>
	" 注释代码用的
	vmenu  590.103  我的操作.行首添加\/\/注释	:s/^/\/\/ /g<cr>
	vmenu  590.104  我的操作.去除行首\/\/注释	:s/^\/\/ \?//g<cr>

	command -bang -nargs=? QFix call s:quickfixToggle(<bang>0)

	amenu icon=/usr/share/pixmaps/gdm.png ToolBar.quickfix <ESC>:QFix<CR>
	tmenu ToolBar.quickfix Open/Close the Quickfix window
endfunction

if has("gui_running")
	set mouse=a
	set guitablabel=%t

	set guifont=Inconsolata\ 11
	"set guifont=Liberation\ Mono\ 10
	"set guifont=DejaVu\ Sans\ Mono\ 10
	"set guifont=Monospace\ 10
	"set guifont=Droid\ Sans\ Mono\ 10
	"set guifont=Bitstream\ Vera\ Sans\ Mono\ 10
	"set guifont=Courier\ New\ 11
	"set guifont=Andale\ Mono\ Normal\ 10

	call s:auto_config_gui()
endif
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" For NERDTree
" ------------------------------------------------------------------------------
"
function! s:auto_config_nerdtree()
	noremap		<F6>				:NERDTreeToggle<cr>
	" 将 NERDTree 窗口显示在右边
	let g:NERDTreeWinPos='right'
	" 在终端启动vim时，共享NERDTree
	let g:nerdtree_tabs_open_on_console_startup=1
	" 忽略一下文件的显示
	let g:NERDTreeIgnore=['\.o', '\.pyc','\~$','\.swp']
	" 显示书签列表
	let g:NERDTreeShowBookmarks=1
endfunction
call s:auto_config_nerdtree()
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" For bufexplorer
" ------------------------------------------------------------------------------
"
function! s:auto_config_bufexplorer()
	" <leader>b opens the buffer list
	noremap		<leader>b			:BufExplorer<cr>
endfunction
call s:auto_config_bufexplorer()
" ------------------------------------------------------------------------------



" ------------------------------------------------------------------------------
" For gitgutter
" ------------------------------------------------------------------------------
"
function! s:auto_config_gitgutter()
	" To disable all key mappings:
	let g:gitgutter_map_keys = 0

	" Use a custom grep command
	let g:gitgutter_grep = 'grep'

	" To turn off vim-gitgutter by default
	" let g:gitgutter_enabled = 0

	" To turn off signs by default
	" let g:gitgutter_signs = 0

	" To turn on line highlighting by default
	let g:gitgutter_highlight_lines = 1

	" To turn off asynchronous updates
	let g:gitgutter_async = 0
endfunction
call s:auto_config_gitgutter()
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" For Airline
" ------------------------------------------------------------------------------
"
function! s:auto_config_airline()
	"安装字体后必须设置
	let g:airline_powerline_fonts = 1

	if !exists('g:airline_symbols')
		let g:airline_symbols = {}
	endif
	" unicode symbols
	let g:airline_left_sep		= '▶'
	let g:airline_left_alt_sep	= '❯'
	let g:airline_right_sep		= '◀'
	let g:airline_right_alt_sep	= '❮'
	let g:airline_symbols.linenr	= '¶'
	let g:airline_symbols.branch	= '⎇'

	" Setting the theme
	let g:airline_theme='badwolf'

	" Enable the list of buffers
	let g:airline#extensions#tabline#enabled = 1
	" Show just the filename
	let g:airline#extensions#tabline#fnamemod = ':t'
	"let g:airline#extensions#tabline#left_sep = ' '
	"let g:airline#extensions#tabline#left_alt_sep = '|'

	let g:airline#extensions#whitespace#enabled = 0
	autocmd FileType python  let g:airline#extensions#whitespace#enabled = 1
	autocmd BufReadPre  *.c  let g:airline#extensions#whitespace#enabled = 0
	autocmd BufReadPre  *.h  let g:airline#extensions#whitespace#enabled = 0
endfunction
call s:auto_config_airline()
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" For CtrlP
" ------------------------------------------------------------------------------
"
function! s:auto_config_ctrlp()
	"调用ag进行搜索提升速度，同时不使用缓存文件
	let g:ctrlp_map = '<c-p>'
	let g:ctrlp_cmd = 'CtrlP'
	" 修改该选项为1，设置默认为按文件名搜索（否则为全路径）: >
	let g:ctrlp_by_filename = 0
	let g:ctrlp_user_command = {
				\ 'types': {
				\ 1: ['.git', 'cd %s && git ls-files -co --exclude-standard'],
				\ 2: ['.hg', 'hg --cwd %s locate -I .'],
				\ },
				\ 'fallback': 'ag %s -l --nocolor -g ""'
				\ }
	let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:100,results:100'
	let g:ctrlp_lazy_update = 500

	" if executable('ag')
	" 	set grepprg=ag\ --nogroup\ --nocolor
	" endif
endfunction
call s:auto_config_ctrlp()
" ------------------------------------------------------------------------------


" vim:set ts=4 sw=4 filetype=vim:
