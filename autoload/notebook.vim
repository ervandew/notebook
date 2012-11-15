" Author:  Eric Van Dewoestine

" License: {{{
"   Copyright (c) 2008 - 2012, Eric Van Dewoestine
"   All rights reserved.
"
"   Redistribution and use of this software in source and binary forms, with
"   or without modification, are permitted provided that the following
"   conditions are met:
"
"   * Redistributions of source code must retain the above
"     copyright notice, this list of conditions and the
"     following disclaimer.
"
"   * Redistributions in binary form must reproduce the above
"     copyright notice, this list of conditions and the
"     following disclaimer in the documentation and/or other
"     materials provided with the distribution.
"
"   * Neither the name of Eric Van Dewoestine nor the names of its
"     contributors may be used to endorse or promote products derived from
"     this software without specific prior written permission of
"     Eric Van Dewoestine.
"
"   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
"   IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
"   THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
"   PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
"   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
"   EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
"   PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
"   PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
"   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
"   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
"   SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
" }}}

function! notebook#Notebook(tag) " {{{
  " check if notebook dir exists
  if !isdirectory(g:NotebookDir)
    let response = input(
      \ "Notebook directory (" . g:NotebookDir . ") doesn't exist. Create it? (y/n) ")
    redraw
    echo ' '
    if response =~# '^y$'
      call mkdir(g:NotebookDir, 'p')
    else
      return
    endif
  endif

  " check if any tags exist
  let tags = globpath(g:NotebookDir, '**/tags')
  if (tags == '')
    let response = input(
      \ "Notebook directory doesn't have any tags. Create an index file? (y/n) ")
    redraw
    echo ' '
    if response =~# '^y$'
      exec 'split ' . escape(g:NotebookDir, ' ') . '/index.txt'
      if !filereadable(g:NotebookDir . '/index.txt')
        call append(0, ['*index*', '', 'Index for my notes.'])
        $,$delete _
      endif
    endif
    return
  endif

  let tag = a:tag != '' ? a:tag : 'index'
  let savetags = &tags
  exec 'set tags=' . g:NotebookDir . '/**/tags'
  try
    if &ft != 'notebook' && (
     \ expand('%') != '' || &modified || line('$') != 1 || getline(1) != '')
      new
    endif

    exec 'tag ' . tag
  finally
    let &tags = savetags
  endtry
endfunction " }}}

function! notebook#NotebookUpdateAll() " {{{
  let paths = split(glob(g:NotebookDir . '/**/*'), '\n')
  call filter(paths, 'isdirectory(v:val)')
  for path in paths
    silent! exec 'helptags ' . path
  endfor
  echom 'notebook updated.'
endfunction " }}}

function! notebook#NotebookGrep(args) " {{{
  let window = 0
  if &ft != 'notebook' && (
   \ expand('%') != '' || &modified || line('$') != 1 || getline(1) != '')
    let window = 1
    new
  endif
  try
    exec 'vimgrep ' a:args . ' ' . g:NotebookDir . '/**/*.txt'
  catch /E480/
    if window
      close
    endif
    echohl Error | echom v:exception | echohl Normal
  endtry

endfunction " }}}

function! notebook#ParseTags(file, settings) " {{{
  return taglisttoo#util#Parse(a:file, a:settings, [
      \ ['a', '\*([^ *]+)\*', 1],
    \ ])
endfunction " }}}

function! notebook#CommandCompleteTag(argLead, cmdLine, cursorPos) " {{{
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
