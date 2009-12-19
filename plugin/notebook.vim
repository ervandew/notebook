" Author:  Eric Van Dewoestine
"
" Description: {{{
"   Plugin which allows you to organize sets of notes using vim's simple help
"   file format providing support to search those notes or jump to a specific
"   tag.
"
"   Note: Your notebook file should have the following modeline to ensure that
"   it can be recognized by this plugin as a notebook file:
"
"     vim:ft=notebook
"
"   An example of my usage: I have my notes broken up into folders of high
"   level topics and in those folders are notes which fall under those topics
"   (note, you can create further nested directories as needed as well):
"
"     database/
"       mysql.txt         (notes on mysql)
"       oracle.txt        (notes on oracle)
"       postgresql.txt    (notes on postgresql)
"       ...
"     languages/
"       c.txt
"       java.txt
"       ...
"     vcs/
"       git.txt
"       hg.txt
"       svn.txt
"     ...
"
"   Then I can lookup notes on git using:
"     :Notebook git
" }}}
"
" License: {{{
"   Copyright (c) 2008 - 2009, Eric Van Dewoestine
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
