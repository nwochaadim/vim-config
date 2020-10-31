function! s:echoR(line1, line2)

  echo a:line1
  echo a:line2
endfunction

let s:error = "None"
function! EchoR()
  echo a:firstline
endfunction
command! -range Errorl call s:echoR(<line1>, <line2>)

" nnoremap <Plug>HabaCall :call Haba()
" nmap hj <Plug>HabaCall
