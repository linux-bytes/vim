" File:          insert_filelist.vim
" Author:        Jerry
" Version:       0.1
" Last Modified: Feb. 15, 2020
"

function! Filelist(dir, suffix)
      return readdir(a:dir, {n -> n =~ a:suffix+'$'}) 
endfunction

function! CFilelist(dir)
	echo "===> " + a:dir
	let l:curr_dir = expand("%:h")
	let l:files = Filelist(a:dir, '.c')

	let l:dir = trim(a:dir, l:curr_dir)

	let l:buf = []

	for i in l:files:
		call add(l:buf, printf("%s/%s \\", l:dir, f)) 
	endfor

	let ret = append('.', l:buf)
	return ret
endfunction

command! -nargs=1 -complete=dir	Gc	call CFilelist(<args>)
noremap	<leader>l	:Gc <C-R>=expand("%:h") . "/" <CR>

" command! -nargs=1	Gcpp	call GenTikz(<line1>, <line2>)
" command! -nargs=1	Gs	call Gen_Tikz_Rel()
