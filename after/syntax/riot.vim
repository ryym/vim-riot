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

syntax region riotCustomTag
  \ start=+^<\z([^ /!?<>"']\+\)>+
  \ end=+^</\z1>+
  \ keepend
  \ contains=customTag,styleRegion,scriptRegion,@JS,htmlRegion,customEndTag,javaScriptExpression
  \ fold

syntax region topLevelComment
  \ start=+^<!+
  \ end=+>+
  \ keepend
  \ contains=htmlComment

syntax match customTag
  \ +^<[^ /!?<>"']\+>+
  \ contained

syntax match customEndTag
  \ +^</[^ /!?<>"']\+>+
  \ contained

" FIXME: htmlValue should not contain htmlArg and htmlString
syntax match htmlValue
  \ +=[\t ]*[^'\" \t>][^ \t>]*+hs=s+1
  \ contained
  \ contains=htmlArg,htmlString,javaScriptExpression,@htmlPreproc

" Expressions enclosed in curly braces should color as JS.
" Note the trivial end pattern; we let jsBlock take care of ending the region.
syntax region javaScriptExpression
  \ start=+{+
  \ end=++
  \ contained
  \ contains=jsBlock,javascriptBlock

syntax match htmlTagName
  \ +<\@1<=/\?[^ /!?<>"']\++
  \ contained
  \ display

" FIXME:
"  Currently, we must put a space after the '<' in JS
"  to prevent them from being recognized as XML starting.
syntax region htmlRegion
  \ start=+^\@<!<[^ =<]+
  \ end=+>+
  \ contained
  \ contains=@HTML,jsBlockInHtml
  \ keepend

syntax region styleRegion
  \ start=+\s\+<style\(\s\+scoped\)\?>+
  \ end=+</style>+
  \ keepend
  \ contained
  \ contains=@CSS,styleTag
  \ fold

syntax match styleTag
  \ +\s\+<style\(\s\+scoped\)\?>+
  \ contained
  \ contains=htmlTagName,styleTagAttr

syntax keyword styleTagAttr scoped
  \ contained

syntax region scriptRegion
  \ start=+\s\+<script\(\s\+[^>]\+\)\?>+
  \ end=+</script>+
  \ keepend
  \ contained
  \ contains=scriptTag,@JS,scriptEndTag,javaScriptExpression
  \ fold

syntax match scriptTag
  \ +\s\+<script\(\s\+[^>]\+\)\?>+
  \ contained
  \ contains=htmlValue,htmlString,htmlTagName

syntax match scriptEndTag
  \ +</script>+
  \ contained
  \ contains=htmlTagName

highlight default link customTag Type
highlight default link customEndTag Type
highlight default link scriptTag htmlTag
highlight default link scriptEndTag htmlEndTag
highlight default link styleTagAttr htmlTag

let b:current_syntax = 'riot'
