" Author:  Eric Van Dewoestine

" Notebook(tag) {{{
function! notebook#Notebook (tag)
  let savetags = &tags
  exec 'set tags=' . g:NotebookDir . '/**/tags'
  try
    exec 'tag ' . a:tag
  finally
    let &tags = savetags
  endtry
endfunction " }}}

" NotebookUpdateAll() {{{
function! notebook#NotebookUpdateAll ()
  let paths = split(glob(g:NotebookDir . '/**/*'), '\n')
  call filter(paths, 'isdirectory(v:val)')
  for path in paths
    silent! exec 'helptags ' . path
  endfor
  echom 'notebook updated.'
endfunction " }}}

" NotebookGrep() {{{
function! notebook#NotebookGrep (args)
  exec 'vimgrep ' a:args . ' ' . g:NotebookDir . '/**/*.txt'
endfunction " }}}

" CommandComplete(argLead, cmdLine, cursorPos) {{{
function! notebook#CommandCompleteTag (argLead, cmdLine, cursorPos)
  let cmdTail = strpart(a:cmdLine, a:cursorPos)
  let argLead = substitute(a:argLead, cmdTail . '$', '', '')

  let savetags = &tags
  exec 'set tags=' . g:NotebookDir . '/**/tags'
  try
    let results = taglist(argLead . '.*')
    call map(results, "v:val['name']")
    return results
  finally
    let &tags = savetags
  endtry
endfunction " }}}

" vim:ft=vim:fdm=marker
