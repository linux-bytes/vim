" File:          cscope_tags.vim
" Author:        Jerry
" Version:       0.1
" Last Modified: Feb. 15, 2018
"

if !exists('g:cscope_tags_db_path')
	let g:cscope_tags_db_path=["./", "./cstags/"]
endif

" ------------------------------------------------------------------------------
" Find "cscope.out" file in the path stored in g:cscope_tags_db_path
" ------------------------------------------------------------------------------
"
function! s:find_cscope_db()
	for path in g:cscope_tags_db_path
		let path = path . "cscope.out"
		if filereadable(path)
			return path
		endif
	endfor

	return ""
endfunction
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Find "tags" file in the path stored in g:cscope_tags_db_path
" ------------------------------------------------------------------------------
"
function! s:find_tags_db()
	for path in g:cscope_tags_db_path
		let path = path . "tags"
		if filereadable(path)
			return path
		endif
	endfor

	return ""
endfunction
" ------------------------------------------------------------------------------

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
" Configure cscope
" ------------------------------------------------------------------------------
"
function! s:configure_cscope()
	if !has("cscope")
		return 0
	endif

	let cscope_path = s:find_cscope_db()
	if cscope_path == ""
		return 0
	endif

	set nocsverb
	execute "cs add " . cscope_path
	if cscope_path != "./cscope.out" || cscope_path != "cscope.out"
		set cscoperelative
	endif
	set nocscoperelative
	set cscopequickfix=s-,c-,e-
	set csto=0
	set cst
	set csverb

	call s:configure_cscope_shortkey()
endfunction
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Configure "tags"
" ------------------------------------------------------------------------------
"
function! s:configure_tags()
	let tags_path = s:find_tags_db()
	if tags_path == "" ||  tags_path == "./tags" || tags_path == "tags"
		let &tags = getcwd() . "/tags"
		return
	endif
	let &tags = tags_path
	set tagrelative
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" The main process
" ------------------------------------------------------------------------------
"
call s:configure_tags()
call s:configure_cscope()
" ------------------------------------------------------------------------------

" vim:set ts=4 sw=4 filetype=vim:
