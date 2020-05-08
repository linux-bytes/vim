" File:          insert_filelist.vim
" Author:        Jerry
" Version:       0.1
" Last Modified: Feb. 15, 2020
"

function! Filelist(dir, suffix)
      return readdir(a:dir, {n -> n =~ a:suffix.'$'}) 
endfunction

function! Insert_Filelist(dir)
	let l:curr_dir = expand("%:h")

	if (exists("g:insert_fl#type_pattern"))
		let l:type_pattern=g:insert_fl#type_pattern
	else
		let l:type_pattern='\.\(c\|cpp\)'

	let l:files = Filelist(a:dir, l:type_pattern)

	if (l:files->empty())
		return 0
	endif

	let l:dir = substitute(a:dir, "^".l:curr_dir."/","","")

	call map(l:files, 'l:dir.v:val." \\"')
	let l:files[-1] = substitute(l:files[-1], " \\","","")

	let ret = append('.', l:files)
	return ret
endfunction

command! -nargs=1 -complete=dir	Gc	call Insert_Filelist("<args>")
noremap	<leader>l			:Gc <C-R>=expand("%:h") . "/" <CR>
