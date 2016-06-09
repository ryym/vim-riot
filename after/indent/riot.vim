" Vim ftdetect file
" Language: Riot.js (JavaScript)
" Maintainer: ryym

if exists('*GetRiotIndent')
  finish
endif

" --- dependencies ---

unlet! b:did_indent
runtime! indent/xml.vim

unlet! b:did_indent
runtime! indent/css.vim

unlet! b:did_indent
for path in split(&runtimepath, ',')
  if filereadable(path . 'indent/javascript.vim')
    execute 'source ' . path . 'indent/javascript.vim'
  endif
endfor

" --- dependencies ---

setlocal indentexpr=GetRiotIndent()

" JS indentkeys
setlocal indentkeys=0{,0},0),0],0\,,!^F,o,O,e
" XML indentkeys
setlocal indentkeys+=*<Return>,<>>,<<>

" Multiline end tag regex (line beginning with '>' or '/>')
let s:endtag = '^\s*\/\?>\s*'

function! s:GetSynNamesAtSOL(lnum)
  return map(synstack(a:lnum, 1), 'synIDattr(v:val, "name")')
endfunction

function! s:GetSynNamesAtEOL(lnum)
  let lnum = prevnonblank(a:lnum)
  let col = strlen(getline(lnum))
  return map(synstack(lnum, col), 'synIDattr(v:val, "name")')
endfunction

" Check if a syntax attribute is XMLish.
function! SynAttrXMLish(synattr)
  return a:synattr =~ "^xml" || a:synattr == "jsBlockInHtml"
endfunction

" Check if a synstack is XMLish (i.e., has an XMLish last attribute).
function! SynXMLish(syns)
  return SynAttrXMLish(get(a:syns, -1))
endfunction

function! s:SeemsXmlSyntax(synattr)
  return a:synattr =~ "^xml" || a:synattr == "jsBlockInHtml"
endfunction

function! s:SeemsCssSyntax(synattr)
  return a:synattr =~ '^css'
endfunction

" Get indents inferred from the current context.
function! GetRiotIndent()
  let prevSyntaxes = <SID>GetSynNamesAtEOL(v:lnum - 1)
  let lastPrevSyn = get(prevSyntaxes, -1)

  " if getline(v:lnum - 1) =~? '>$'
  "   return indent(v:lnum) + &sw
  " endif

  if <SID>SeemsXmlSyntax(lastPrevSyn)
    let ind = XmlIndentGet(v:lnum, 0)

    if getline(v:lnum) =~? s:endtag
      " Align '/>' and '>' with '<' for multiline tags.
      let ind = ind - &sw
    elseif getline(v:lnum - 1) =~? s:endtag
      " Correct the indentation of any tags following '/>' or '>'.
      let ind = ind + &sw
    endif

    return ind
  endif

  if <SID>SeemsCssSyntax(lastPrevSyn)
    return GetCSSIndent()
  endif

  return GetJavascriptIndent()
endfunction
