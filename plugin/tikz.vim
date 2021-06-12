" File:          tikz.vim
" Author:        Jerry
" Version:       0.1
" Last Modified: Feb. 15, 2020
"

function! TestPy() range
    let startline = line("'<")
    let endline = line("'>")
    echo "vim-start:".startline . " vim-endline:".endline
python << EOF
import vim
s = "I was set in python"
vim.command("let sInVim = '%s'"% s)
start = vim.eval("startline")
end = vim.eval("endline")
print "start, end in python:%s,%s"% (start, end)
EOF
    echo sInVim
endfunction



function! Print_range()
python << EOF
import vim

r = vim.current.range

print(r.start, r.end)
EOF
endfunction

function! RemoveTrailingWhitespace()
  echo a:firstline
  echo a:lastline
  for lineno in range(a:firstline, a:lastline)
    let line = getline(lineno)
    let cleanLine = substitute(line, '\(\s\| \)\+$', '', 'e')
    call setline(lineno, cleanLine)
  endfor
endfunction
command -range RemoveTrailingWhitespace <line1>,<line2>call RemoveTrailingWhitespace()
command -range -count=1 RT                       <line1>,<line2>call RemoveTrailingWhitespace()



function! Print_Range(start, end) range
    " echo a:start
    " echo a:end
    " let startline = line("'<")
    " let endline = line("'>")
    " echo startline
    " echo endline
    echo a:firstline
    echo a:lastline
range python << EOF
import vim
import sys

# print(vim.eval("a:start"), vim.eval("a:end"))
startline = vim.eval("line(\"'<\")")
endline = vim.eval("line(\"'>\")")
print(startline, endline)

print(type(vim.current.range))
print(len(vim.current.range))
for i in vim.current.range:
	print(i)
EOF
endfunction


"\node (TBD) [struct={1},"
"            rectangle split part align={center, left},"
"            rectangle split part fill={gray, white}] {"
"            \mintinline{c}|{0}|"
"            \nodepart{{0}}\mintinline{c}|{1}|"


function! GenTikz(start, end) range
let s:name = input("Enter a node name: ")
pyx << EOF
import vim
start_line = int(vim.eval("a:start"))
end_line = int(vim.eval("a:end"))

print(start_line, end_line)
r = vim.current.range
print(r.start, r.end)
num = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten",
       "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen",
       "eighteen", "nineteen"]

name = vim.eval("s:name")
buf = ["\\node [struct={0},".format(end_line-start_line+1),
       "       rectangle split part align={center, left},",
       "       rectangle split part fill={gray, white}]",
       "  ({0}) []".format(name),
       "{"]
buf.append("  \\mintinline{{c}}|{0}|".format(vim.current.buffer[start_line-1]))
for i in range(start_line, end_line):
	buf.append("  \\nodepart{{{0}}}\\mintinline{{c}}|{1}|".format(num[i], vim.current.buffer[i]))

buf.append("}")
del vim.current.buffer[start_line-1:end_line]
vim.current.buffer.append(buf, start_line-1)

EOF
endfunction

function! Gen_Tikz_Rel() range
	if ((a:lastline - a:firstline) < 1)
		echo "You should select two row at least!"
		return
	endif

	if ((a:lastline - a:firstline) > 20)
		echo "You should select Twenty row at most!"
		return
	endif

	let l:num_list = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]

	let l:dir = ["below", "above", "left", "right", "below left", "below right", "above left", "above right"]

	let l:node_name = input("Enter a node name: ")
	let l:relative_node = input("Enter a relative node name: ")
	let l:sel = inputlist(["Enter a relative direction: "] + l:dir)
	let l:relative_dir = l:dir[l:sel]
	let l:relative_dis = input("Enter a relative distance: ")

	let l:buf = []
	call add(l:buf, printf("\\node [struct=%d,", a:lastline - a:firstline + 1)) 
	call add(l:buf, "       rectangle split part align={center, left},")
	call add(l:buf, "       rectangle split part fill={gray, white}]")
	call add(l:buf, printf("(%s) [%s=%s of %s]", l:node_name, l:relative_dir, l:relative_dis, l:relative_node)) 
	call add(l:buf, "{")
	call add(l:buf, printf("  \\mintinline{c}|%s|", getline(a:firstline)))

	for i in range(a:firstline-1, a:lastline)
		call add(l:buf, printf("  \\nodepart{%s}\\mintinline{c}|%s|", l:num_list[i], getline(i)))
	endfor

	call add(l:buf, "}")

	call deletebufline(bufname("%"), a:firstline, a:lastline)

	let ret = append(a:firstline-1, l:buf)
	return ret
endfunction



command!  -range -nargs=0	PR	<line1>,<line2>call Print_Range(<line1>, <line2>)
command!  -range -nargs=0	GT	<line1>,<line2>call GenTikz(<line1>, <line2>)
command!  -range -nargs=0	Gtr	<line1>,<line2>call Gen_Tikz_Rel()


autocmd FileType tex noremap	  <F10>			:GT<CR>
autocmd FileType tex noremap	  <F9>			:Gtr<CR>

" vim:set ts=4 sw=4 filetype=vim:
