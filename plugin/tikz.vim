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
buf = ["\\node ({0}) [struct={1},".format(name, end_line-start_line+1),
       "              rectangle split part align={center, left}," ,
       "              rectangle split part fill={gray, white}] {"]
buf.append("\\mintinline{{c}}|{0}|".format(vim.current.buffer[start_line-1]))
for i in range(start_line, end_line):
	buf.append("\\nodepart{{{0}}}\\mintinline{{c}}|{1}|".format(num[i], vim.current.buffer[i]))

buf[-1] = buf[-1] + "}"
del vim.current.buffer[start_line-1:end_line]
vim.current.buffer.append(buf, start_line-1)

EOF
endfunction

command!  -range -nargs=0	PR	<line1>,<line2>call Print_Range(<line1>, <line2>)
command!  -range -nargs=0	GT	<line1>,<line2>call GenTikz(<line1>, <line2>)
noremap	  <F11>			:GT<CR>
