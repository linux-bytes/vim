" File:          punctuation_en2cn.vim
" Author:        Jerry
" Version:       0.1
" Last Modified: Feb. 15, 2020

function! Punctuation_en2cn()
    execute ":%s/，/,/g"
    execute ":%s/。/./g"
    execute ":%s/：/:/g"
    execute ":%s/）/)/g"
    execute ":%s/（/(/g"
    execute ":%s/“/\"/g"
    execute ":%s/”/\"/g"
endfunction
