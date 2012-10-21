.. Copyright (c) 2012, Eric Van Dewoestine
   All rights reserved.

   Redistribution and use of this software in source and binary forms, with
   or without modification, are permitted provided that the following
   conditions are met:

   * Redistributions of source code must retain the above
     copyright notice, this list of conditions and the
     following disclaimer.

   * Redistributions in binary form must reproduce the above
     copyright notice, this list of conditions and the
     following disclaimer in the documentation and/or other
     materials provided with the distribution.

   * Neither the name of Eric Van Dewoestine nor the names of its
     contributors may be used to endorse or promote products derived from
     this software without specific prior written permission of
     Eric Van Dewoestine.

   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
   IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
   THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
   PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
   EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
   PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
   PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
   SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

.. _overview:

========
Overview
========

Notebook is a vim plugin allowing you to store notes, etc in vim help file
format for easy access.

=====
Usage
=====

Notebook is intended to be used just like vim's help system, but instead of
using ``:help <tag>`` you would execute ``:Notebook <tag>``. The format of
notebook files is the same as that of vim help files, so tags/anchors are
written in the form of ``*tagname*`` and linking to tags/anchors is written as
``|tagname|``.  See ``:help help-writing`` for more details on vim help files.

In addition to looking up a topic by tag, you can search the notebook files
using ``:NotebookGrep <pattern>`` as well.

Notebook files are expected to end in a '.txt' extension and the corresponding
tags file will be updated when writing the notebook file. If you need to force
the generation of notebook tags, you can do so by executing
``:NotebookUpdateAll``.

=============
Configuration
=============

By default notebook files will be stored at ``~/.notebook``, but you can change
this location by setting the following variable:

::

  let g:NotebookDir = '~/notes'
