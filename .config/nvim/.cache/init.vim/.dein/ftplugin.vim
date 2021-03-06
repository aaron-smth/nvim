if exists("g:did_load_ftplugin")
  finish
endif
let g:did_load_ftplugin = 1

augroup filetypeplugin
  autocmd FileType * call s:ftplugin()
augroup END

function! s:ftplugin()
  if exists("b:undo_ftplugin")
    silent! execute b:undo_ftplugin
    unlet! b:undo_ftplugin b:did_ftplugin
  endif

  let filetype = expand("<amatch>")
  if filetype !=# ""
    if &cpoptions =~# "S" && exists("b:did_ftplugin")
      unlet b:did_ftplugin
    endif
    for ft in split(filetype, '\.')
      execute "runtime! ftplugin/" . ft . ".vim"
      execute "runtime! ftplugin/" . ft . "_*.vim"
      execute "runtime! ftplugin/" . ft . "/*.vim"
    endfor
  endif
  call s:after_ftplugin()
endfunction

function! s:after_ftplugin()
endfunction
