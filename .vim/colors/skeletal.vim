" Vim color file
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2001 Jul 23

" This is the default color scheme.  It doesn't define the Normal
" highlighting, it uses whatever the colors used to be.
"
" Set 'background' back to the default.  The value can't always be estimated
" and is then guessed.

let colors_name = "default"

hi StatusLine cterm=NONE ctermbg=NONE ctermfg=White 
hi MatchParen cterm=bold ctermfg=0;
" vim: sw=2
