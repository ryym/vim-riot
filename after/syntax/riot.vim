" Vim ftdetect file
" Language: Riot.js (JavaScript)
" Maintainer: ryym

if exists('b:current_syntax')
  finish
endif

" --- dependencies ---

syntax include @JS syntax/javascript.vim
unlet! b:current_syntax

syntax include @HTML syntax/html.vim
unlet! b:current_syntax

syntax include @CSS syntax/css.vim
unlet! b:current_syntax

" --- dependencies ---

" XXX: htmlValue should not contain htmlArg and htmlString
syntax match htmlValue
  \ contained "=[\t ]*[^'" \t>][^ \t>]*"hs=s+1
  \ contains=htmlArg,htmlString,javaScriptExpression,@htmlPreproc

" Expressions enclosed in curly braces should color as JS.
" Note the trivial end pattern; we let jsBlock take care of ending the region.
syntax region javaScriptExpression
  \ start=+{+
  \ end=++
  \ contained
  \ contains=jsBlock,javascriptBlock

syntax region riotCustomTag
  \ keepend
  \ contains=customTag,styleRegion,scriptRegion,@JS,htmlRegion,customEndTag
  \ start=+^<\z([^ /!?<>"']\+\)>+
  \ end=+^</\z1>+
  \ fold

syntax match customTag
  \ +^<[^ /!?<>"']\+>+
  \ contained

syntax match customEndTag
  \ +^</[^ /!?<>"']\+>+
  \ contained

" XXX:
"  Currently, we must put a space after the '<' in JS
"  to prevent them from being recognized as XML starting.
syntax region htmlRegion
  \ contained
  \ contains=@HTML,jsBlockInHtml
  \ start="^\@<!<[^ =<]"
  \ end=">"
  \ keepend

syntax region styleRegion
  \ contained
  \ keepend
  \ contains=@CSS
  \ start="\s\+<style\(\s\+scoped\)\?>"
  \ end="</style>"
  \ fold

syntax region scriptRegion
  \ contained
  \ keepend
  \ contains=scriptTag,@JS,scriptEndTag
  \ start="\s\+<script\(\s\+[^>]\+\)\?>"
  \ end="</script>"
  \ fold

syntax match scriptTag
  \ "\s\+<script\(\s\+[^>]\+\)\?>"
  \ contained
  \ contains=htmlValue,htmlString,htmlTagName

syntax match scriptEndTag
  \ "</script>"
  \ contained
  \ contains=htmlTagName

syntax match htmlTagName
  \ +<\@1<=/\?[^ /!?<>"']\++
  \ contained
  \ display

highlight default link customTag Type
highlight default link customEndTag Type
highlight default link scriptTag htmlTag
highlight default link scriptEndTag htmlEndTag

let b:current_syntax = "riot"
