"improved by Janis Fehr <fehr@informatik.uni-freiburg.de> 
"original from:	Patricio Toledo <patoledo@ing.puc.cl>, from matlab.sci
"------------------------------------------------------------------------------------------------------
"SETUP:
"1a) as root, copy this file to your vim syntax directory, in most cases: /usr/share/vim/vim61/syntax/
"2a) add this line to  /etc/vim/vimrc:	
"    au BufNewFile,BufReadPost *.sci,*.sce so $VIMRUNTIME/syntax/scilab.vim
"1b) as user, copy this file to someplace
"2b) add this line to your .vimrc in your home:
"    au BufNewFile,BufReadPost *.sci,*.sce so someplace/scilab.vim
"-------------------------------------------------------------------------------------------------------

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn keyword scilabStatement		return
syn keyword scilabLabel			case switch
syn keyword scilabConditional		else elseif end if otherwise
syn keyword scilabRepeat		do for while

syn keyword scilabTodo			contained  TODO

" If you do not want these operators lit, uncommment them and the "hi link" below
syn match scilabArithmeticOperator	"[-+]"
syn match scilabArithmeticOperator	"\.\=[*/\\^]"
syn match scilabRelationalOperator	"[=~]="
syn match scilabRelationalOperator	"[<>]=\="
syn match scilabLogicalOperator		"[&|~]"
syn match scilabLineContinuation	"\.\{3}"

"syn match scilabIdentifier		"\<\a\w*\>"

syn region scilabString			start=+'+ end=+'+	oneline

syn match scilabTab			"\t"
syn match scilabNumber			"\<\d\+[ij]\=\>"
syn match scilabFloat			"\<\d\+\(\.\d*\)\=\([edED][-+]\=\d\+\)\=[ij]\=\>"
syn match scilabFloat			"\.\d\+\([edED][-+]\=\d\+\)\=[ij]\=\>"
syn match scilabDelimiter		"[][]"
syn match scilabDelimiter		"[][()]"
syn match scilabTransposeOperator	"[])a-zA-Z0-9.]'"lc=1
syn match scilabSizeOperator     	"\$"
syn match scilabSemicolon		";"
syn match scilabColon		        ","
syn match scilabComment			"//.*$"	contains=scilabTodo,scilabTab
syn match scilabError			"-\=\<\d\+\.\d\+\.[^*/\\^]"
syn match scilabError			"-\=\<\d\+\.\d\+[eEdD][-+]\=\d\+\.\([^*/\\^]\)"

syn keyword scilabFunction	error eval function endfunction 
syn keyword scilabOperator	break return default margin round clear
syn keyword scilabOperator      ones zeros eye rand ceil floor size fix
syn keyword scilabOperator      find isdef isinf isnan isreal
syn keyword scilabOperator      sort triu tril conj
syn keyword scilabOperator	string 
syn keyword scilabImplicit	norm abs exp log log10 log2
syn keyword scilabImplicit      prod sum max min sign sqrt
syn keyword scilabStatistic     mean median std cov
syn keyword scilabTrigonometric cos acos sin asin tan atan        
syn keyword scilabHiperbol      cosh acosh sinh asinh tanh atanh        
syn keyword scilabVectorize     matrix repmat matrices kron  sub2ind ind2sub
syn keyword scilabSparse        sparse speye spget spones sprand spzeros nnz
syn keyword scilabPlot          champ colormap contour contourf champ plot
syn keyword scilabPlot          replot polarplot subplot xaxis xtitle
syn keyword scilabFile		fileinfo mopen mclose mgetl mputl
syn keyword scilabDate		getdate 
syn keyword scilabUnix		unix unix_w unix_c host

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_scilab_syntax_inits")
  if version < 508
    let did_scilab_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink scilabUnix			Operator
  HiLink scilabOperator			Operator
  HiLink scilabStatistic		Operator
  HiLink scilabTrigonometric 		Operator
  HiLink scilabHiperbolic		Operator
  HiLink scilabVectorize		Operator
  HiLink scilabSparse   		Operator
  HiLink scilabPlot     		Operator
  HiLink scilabTransposeOperator	Operator
  HiLink scilabDate			Operator
  HiLink scilabFile			Operator
  HiLink scilabSizeOperator      	Float
  HiLink scilabFloat			Float
  HiLink scilabFunction			Function
  HiLink scilabLineContinuation		Special
  HiLink scilabLabel			Label
  HiLink scilabConditional		Conditional
  HiLink scilabRepeat			Repeat
  HiLink scilabString			String
  HiLink scilabDelimiter		Identifier
  HiLink scilabTransposeOther		Identifier
  HiLink scilabNumber			Number
  HiLink scilabError			Error
  HiLink scilabTodo			Todo
  HiLink scilabImplicit			Statement
  HiLink scilabStatement		Statement
  HiLink scilabSemicolon		SpecialChar
  HiLink scilabColon			SpecialChar
  HiLink scilabComment			Comment
  HiLink scilabArithmeticOperator	scilabOperator
  HiLink scilabRelationalOperator	scilabOperator
  HiLink scilabLogicalOperator		scilabOperator

"optional highlighting
  "HiLink scilabIdentifier		Identifier
  "HiLink scilabTab			Error

  delcommand HiLink
endif

let b:current_syntax = "scilab"

"EOF	vim: ts=8 noet tw=100 sw=8 sts=0
