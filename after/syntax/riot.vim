" Vim ftdetect file
" Language: Riot.js (JavaScript)
" Maintainer: ryym

if exists('b:current_syntax')
  " finish
endif

" --- dependencies ---

syntax include @JS syntax/javascript.vim
unlet! b:current_syntax

syntax include @XML syntax/xml.vim
unlet! b:current_syntax

syntax include @CSS syntax/css.vim
unlet! b:current_syntax

" --- dependencies ---

" Expressions enclosed in curly braces should color as JS.
" Note the trivial end pattern; we let jsBlock take care of ending the region.
syntax region xmlString contained start=+{+ end=++ contains=jsBlock,javascriptBlock
syntax region jsBlockInHtml contained start=+{+ end=++ contains=jsBlock,javascriptBlock

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
"  because it is recognized as XML starting.
syntax region htmlRegion
  \ contained
  \ contains=@XML,jsBlockInHtml
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
  \ contains=xmlAttrib,xmlString

syntax match scriptEndTag
  \ "</script>"
  \ contained

highlight default link customTag Type
highlight default link customEndTag Type
highlight default link scriptTag xmlTag
highlight default link scriptEndTag xmlEndTag

let b:current_syntax = "riot"
