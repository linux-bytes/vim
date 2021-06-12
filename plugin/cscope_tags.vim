" File:          cscope_tags.vim
" Author:        Jerry
" Version:       1.0
" Last Modified: June. 12, 2021
"

" ------------------------------------------------------------------------------
" Configure the Short Key for cscope
" ------------------------------------------------------------------------------
"
function! s:configure_cscope_shortkey()
	" "Symbols":  Find this C symbol
	noremap		cs			:cs f s <C-R>=expand("<cword>")<CR>
	" "Defines":  Find this definition
	noremap		cg			:cs f g <C-R>=expand("<cword>")<CR>
	" "Calls":    Find functions called by this function
	noremap		cd			:cs f d <C-R>=expand("<cword>")<CR>
	" "Globals":  Find functions calling this function
	noremap		cc			:cs f c <C-R>=expand("<cword>")<CR>
	" "Texts":    Find this text string
	noremap		ct			:cs f t <C-R>=expand("<cword>")<CR>
	" "Egrep":    Find this egrep pattern
	noremap		ce			:cs f e <C-R>=expand("<cword>")<CR>
	" "File":     Find this file
	noremap		cf			:cs f f <C-R>=expand("<cword>")<CR>
	" "Includes": Find files #including this file
	noremap		ci			:cs f i <C-R>=expand("<cword>")<CR>
endfunction
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Add cscope.db into current system
" ------------------------------------------------------------------------------
"
function! s:add_cscope_db(cscope_db, code_path)
	set nocscopeverbose " Turn off message show: Don't show error or success.
	exe "cs add " . a:cscope_db . " " . a:code_path
	set cscopeverbose   " Turn on message show
    " s: 查找本 C 符号
    " g: 查找本定义
    " d: 查找本函数调用的函数
    " c: 查找调用本函数的函数
    " t: 查找本字符串
    " e: 查找本 egrep 模式
    " f: 查找本文件
    " i: 查找包含本文件的文件
    " a: 查找此符号被赋值的位置
	" 查找 C 符号, 调用本函数的函数, egrep 结果, 不会主动弹出 Quickfix 窗口
	set cscopequickfix=s-,c-,e-
	set cscoperelative
	set csto=0			" cscope.out is first, tags is second
	set cst				" vim -t also search cscope.out

	call s:configure_cscope_shortkey()
endfunction
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Load cscope
" ------------------------------------------------------------------------------
"
function! s:load_cscope()
	if !has("cscope")
		return 0
	endif

	" Step1: find cscope.out in the current working directory and upper
	" directory.
	let cscope_db = findfile("cscope.out", ".;")
	if (!empty(cscope_db) && filereadable(cscope_db))
		let code_path = strpart(cscope_db, 0, match(cscope_db, "/cscope.out$"))

		call s:add_cscope_db(cscope_db, code_path)

		return 0
	endif

	" Step2: find cstags/cscope.out in the current working directory and
	" upper directory.
	let cscope_db = findfile("cstags/cscope.out", ".;")
	if (!empty(cscope_db) && filereadable(cscope_db))
		let code_path = strpart(cscope_db, 0, match(cscope_db, "/cstags/cscope.out$"))

		call s:add_cscope_db(cscope_db, code_path)

		return 0
	endif

	" Step3: Detect the environment variable: $CSCOPE_DB
	let cscope_db = $CSCOPE_DB
	if (!empty(cscope_db) && filereadable(cscope_db))
		let code_path = strpart(cscope_db, 0, match(cscope_db, "/cscope.out$"))

		call s:add_cscope_db(cscope_db, code_path)

		return 0
	endif

	return -1
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" Search the "tags"
" 1. 先当前路径下找 "tags", 然后依次往上级目录找
" 2. 再在当前目录的找 "cstags/tags" (就是说把 tags 放入 cstags 目录下), 依次递
"    归每一个上级目录
" ------------------------------------------------------------------------------
"
function! s:find_tags_db()
	" Step1: find TAGS in the current working directory and upper
	" directory.
	let tags_db = findfile("TAGS", ".;")
	if (!empty(tags_db) && filereadable(tags_db))
		return strpart(tags_db, 0, match(tags_db, "/TAGS$"))
	endif

	" Step2: find cstags/TAGS in the current working directory and
	" upper directory.
	let tags_db = findfile("cstags/TAGS", ".;")
	if (!empty(tags_db) && filereadable(tags_db))
		return strpart(tags_db, 0, match(tags_db, "/cstags/TAGS$"))
	endif

	" Step3: find tags in the current working directory and upper
	" directory.
	let tags_db = findfile("tags", ".;")
	if (!empty(tags_db) && filereadable(tags_db))
		return strpart(tags_db, 0, match(tags_db, "/tags$"))
	endif

	" Step4: find cstags/tags in the current working directory and
	" upper directory.
	let tags_db = findfile("cstags/tags", ".;")
	if (!empty(tags_db) && filereadable(tags_db))
		return strpart(tags_db, 0, match(tags_db, "/cstags/tags$"))
	endif


	return ""
endfunction
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Load "tags"
" ------------------------------------------------------------------------------
"
function! s:load_tags()
	set tags=TAGS;,tags;cstags/TAGS;,cstags/tags;

	let tags_path = s:find_tags_db()
	if tags_path != ""
		exe "chdir " . tags_path
	endif

	" let &path+=fnamemodify(tagfiles()[0], ':p:h')
	set tagbsearch  " 加速查找
	set notagrelative
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" The main process
" ------------------------------------------------------------------------------
"
call s:load_tags()
call s:load_cscope()
" ------------------------------------------------------------------------------

" vim:set ts=4 sw=4 filetype=vim:
