" Author:  Eric Van Dewoestine

" Global Variables {{{

if !exists('g:NotebookDir')
  let g:NotebookDir = expand('~/.notebook')
else
  if g:NotebookDir =~ '/$'
    let g:NotebookDir = g:NotebookDir[:-2]
  endif
endif

let g:tlist_notebook_settings = {'lang': 'help', 'tags': {'a': 'anchor'}} |

" }}}

" Command Declarations {{{

if !exists(':Notebook')
  command -nargs=1 -complete=customlist,notebook#CommandCompleteTag
    \ Notebook :call notebook#Notebook('<args>')
endif
if !exists(':NotebookUpdateAll')
  command -nargs=0 NotebookUpdateAll :call notebook#NotebookUpdateAll()
endif
if !exists(':NotebookGrep')
  command -nargs=+ NotebookGrep :call notebook#NotebookGrep(<q-args>)
endif

" }}}

" vim:ft=vim:fdm=marker
