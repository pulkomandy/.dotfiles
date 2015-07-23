" Modified by Jean-Christian Goussard 2000-2010
"
" Vim syntax file
" Language:	C
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	1998 Aug 13

"set et

" Remove any old syntax stuff hanging around
syn clear

" A bunch of useful C keywords
"JC: removed IF et SWITCH from cConditional
"JC: removed WHILE et FOR from cRepeat
syn keyword	cStatement	goto break return continue asm
syn keyword	cLabel		case default
syn keyword	cConditional	else
syn keyword	cRepeat		do

syn keyword	cTodo		contained TODO FIXME XXX

" String and Character constants
" Highlight special characters (those which have a backslash) differently
syn match	cSpecial	contained "\\x\x\+\|\\\o\{1,3\}\|\\.\|\\$"
syn region	cString		start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=cSpecial
syn match	cCharacter	"'[^\\]'"
syn match	cSpecialCharacter "'\\.'"
syn match	cSpecialCharacter "'\\\o\{1,3\}'"

"when wanted, highlight trailing white space
if exists("c_space_errors")
  syn match	cSpaceError	"\s*$"
  syn match	cSpaceError	" \+\t"me=e-1
endif

"catch errors caused by wrong parenthesis
syn cluster	cParenGroup	contains=cParenError,cIncluded,cSpecial,cTodo,cUserCont,cUserLabel,cBitField,cJCIfParent,cJCTypeInDecl,cJCParamType
syn region	cParen		transparent start='(' end=')' contains=ALLBUT,@cParenGroup
syn match	cParenError	")"
syn match	cInParen	contained "[{}]"

"integer number, or floating point number without a dot and with "f".
syn case ignore
" JC: ajouté \(\d-*\)\=    } NOT (removed)
syn match	cNumber		"\<\d\+\(u\=l\=\|lu\|f\)\>"
"floating point number, with dot, optional exponent
syn match	cFloat		"\<\d\+\.\d*\(e[-+]\=\d\+\)\=[fl]\=\>"
"floating point number, starting with a dot, optional exponent
syn match	cFloat		"\.\d\+\(e[-+]\=\d\+\)\=[fl]\=\>"
"floating point number, without dot, with exponent
syn match	cFloat		"\<\d\+e[-+]\=\d\+[fl]\=\>"
"hex number
syn match	cNumber		"\<0x\x\+\(u\=l\=\|lu\)\>"
"syn match cIdentifier	"\<[a-z_][a-z0-9_]*\>"
syn case match
" flag an octal number with wrong digits
syn match	cOctalError	"\<0\o*[89]"

if exists("c_comment_strings")
  " A comment can contain cString, cCharacter and cNumber.
  " But a "*/" inside a cString in a cComment DOES end the comment!  So we
  " need to use a special type of cString: cCommentString, which also ends on
  " "*/", and sees a "*" at the start of the line as comment again.
  " Unfortunately this doesn't very well work for // type of comments :-(
  syntax match	cCommentSkip	contained "^\s*\*\($\|\s\+\)"
  syntax region cCommentString	contained start=+"+ skip=+\\\\\|\\"+ end=+"+ end=+\*/+me=s-1 contains=cSpecial,cCommentSkip
  syntax region cComment2String	contained start=+"+ skip=+\\\\\|\\"+ end=+"+ end="$" contains=cSpecial
  syntax region cComment	start="/\*" end="\*/" contains=cTodo,cCommentString,cCharacter,cNumber,cFloat,cSpaceError
  syntax match  cComment	"//.*" contains=cTodo,cComment2String,cCharacter,cNumber,cSpaceError
else
  syn region	cComment	start="/\*" end="\*/" contains=cTodo,cSpaceError
  syn match	cComment	"//.*" contains=cTodo,cSpaceError
endif
syntax match	cCommentError	"\*/"

"JC: removed, sizeof remplacé par un match
"syn keyword	cOperator	sizeof
" JC: removed
"syn keyword	cType		int long short char void size_t
"syn keyword	cType		signed unsigned float double
"syn keyword	cStorageClass	static register auto volatile extern const
"syn keyword	cStructure	struct union enum

syn region	cPreCondit	start="^\s*#\s*\(if\>\|ifdef\>\|ifndef\>\|elif\>\|else\>\|endif\>\)" skip="\\$" end="$" contains=cComment,cString,cCharacter,cNumber,cCommentError,cSpaceError
syn region	cIncluded	contained start=+"+ skip=+\\\\\|\\"+ end=+"+
syn match	cIncluded	contained "<[^>]*>"
syn match	cInclude	"^\s*#\s*include\>\s*["<]" contains=cIncluded
"syn match cLineSkip	"\\$"
" JC: ajout de cParent, cParenError pour ne pas avoir cJCTypeCast. Inconvenient: on m'a plus catch wrong parenth.
syn cluster	cPreProcGroup	contains=cPreCondit,cIncluded,cInclude,cDefine,cInParen,cUserLabel,cJCParamType,cJCBlocParen,cJCIfParent,cJCTypeCast,cJCTypeInDecl,cJCType,cParen,cParenError,cJCFctCall,cMulti
syn region	cDefine		start="^\s*#\s*\(define\>\|undef\>\)" skip="\\$" end="$" contains=ALLBUT,@cPreProcGroup
syn region	cPreProc	start="^\s*#\s*\(pragma\>\|line\>\|warning\>\|warn\>\|error\>\)" skip="\\$" end="$" contains=ALLBUT,@cPreProcGroup

" Highlight User Labels
syn cluster	cMultiGroup	contains=cIncluded,cSpecial,cTodo,cUserCont,cUserLabel,cBitField,cJCTypeInDecl
" JC: modif
syn region	cMulti		matchgroup=cStatement start='?' end=':' contains=ALLBUT,@cMultiGroup
"syn region	cMulti		transparent start='?' end=':' contains=ALLBUT,@cMultiGroup
" Avoid matching foo::bar() in C++ by requiring that the next char is not ':'
syn match	cUserCont	"^\s*\I\i*\s*:$" contains=cUserLabel
syn match	cUserCont	";\s*\I\i*\s*:$" contains=cUserLabel
syn match	cUserCont	"^\s*\I\i*\s*:[^:]"me=e-1 contains=cUserLabel
syn match	cUserCont	";\s*\I\i*\s*:[^:]"me=e-1 contains=cUserLabel

" JC: modifié le match pour prendre les ':' aussi
syn match	cUserLabel	"\I\i*\s*:" contained
"syn match	cUserLabel	"\I\i*" contained

" Avoid recognizing most bitfields as labels
syn match	cBitField	"^\s*\I\i*\s*:\s*[1-9]"me=e-1
syn match	cBitField	";\s*\I\i*\s*:\s*[1-9]"me=e-1

if !exists("c_minlines")
  let c_minlines = 15
endif
exec "syn sync ccomment cComment minlines=" . c_minlines


"--------------------------------------------------------------------------
" added by JC 02/2000+
" include C++ un peu

" Type des paramètres des fonctions
syn match	cJCParamVoid	"\<void\>" contained
"syn match	cJCParamType	"\<\(const\s\+\|signed\s\+\|unsigned\s\+\)\=\I\i*\s\+\**\s*\(\I\|(\)"he=e-1 contained
"syn match	cJCParamType	"\<\(const\s\+\|signed\s\+\|unsigned\s\+\)\=\I\i*\s\+\**\s*\I"he=e-1 contained
syn match	cJCParamType	"\<\(\(const\|restrict\|volatile\|signed\|unsigned\|struct\|enum\)[ \t*]\+\)*\I\i*[ \t*]\+\I"he=e-1 contained

" Déclaration de variables et fonctions
"syn match	cJCDecl		"^\s*\(const\s\+\|static\s\+\|extern\s\+\)*\I\i*\s\+\**\s*\I\i*" contains=cJCTypeInDecl
"syn match	cJCDecl		"^\s*\(inline\s\+\)\=\I\i*\s\+\**\s*\I\i*" contains=cJCTypeInDecl
syn match	cJCDecl		"^\s*\(inline\s\+\)\=\(\I\i*[ \t*]\+\)\+\s*\I" contains=cJCTypeInDecl
"syn match	cJCTypeInDecl	"^\s*\(inline\s\+\|const\s\+\|extern\s\+\|static\s\+\|register\s\+\|auto\s\+\|volatile\s\+\|virtual\s\+\|signed\s\+\|unsigned\s\+\|struct\s\+\)*\I\i*\s*\**" contained
"syn match	cJCTypeInDecl	"^\s*\(\(inline\|const\|restrict\|extern\|GLOBAL\|static\|register\|auto\|volatile\|virtual\|signed\|unsigned\|struct\)\(\s\+\**\|\*\+\)\)*\I\i*\(\(\s\+\**\|\*\+\)*\(const\|restrict\|volatile\)\)*\s*\**" contained
syn match	cJCTypeInDecl	"^\s*\(\(inline\|const\|restrict\|extern\|GLOBAL\|static\|register\|auto\|volatile\|virtual\|signed\|unsigned\|struct\)[ \t*]\+\)*\I\i*\([ \t*]\+\(const\|restrict\|volatile\)\)*[ \t*]*" contained

" Fontions
"syn region	cJCFunc		start="^\I\i*\s\+\**\s*\I\i*\s*(" end=")\s*{\=\s*$" contains=CJCParamVoid,cJCParamType  enlevé la '{' du pettern de fin
"syn region	cJCFunc		start="^\(const\s\+\|signed\s\+\|unsigned\s\+\)*\I\i*\s\+\**\s*\I\i*\s*(" end=")" contains=CJCParamVoid,cJCParamType
syn region	cJCFunc		start="^\(\(inline\|const\|extern\|GLOBAL\|static\|register\|auto\|volatile\|virtual\|signed\|unsigned\|struct\)[ \t*]\+\)*\I\i*\s\+\**\s*\I\i*\s*(" end=")" contains=CJCParamVoid,cJCParamType,cJCTypeInDecl,cComment
syn region	cJCFunc		start="^\I\i*\s*(" end=")" contains=CJCParamVoid,cJCParamType

" typedef
"syn region	cJCType		matchgroup=cStatement start="^\s*typedef\s\+" end=";"he=e-1
"syn region	cJCType		matchgroup=cStatement start="^\s*typedef\s\+" end=""he=e-1
syn match	cJCType		"^\s*typedef\s*\(const\s\+\|extern\s\+\|static\s\+\|register\s\+\|auto\s\+\|volatile\s\+\|virtual\s\+\|signed\s\+\|unsigned\s\+\|struct\s\+\)*\I\i*"

" typecast
"syn match	cJCTypeCast	"(\s*\(signed\s\+\|unsigned\s\+\|struct\s\+\)\=\I\i*\s*\**\s*)\s*[^) \t;,{]"me=e-1
"syn match	cJCTypeCast	"(\s*\(signed\s\|unsigned\s\|struct\s\)\=\I\i*\s*\**\s*)\s*[^) \t;,{]"me=e-1
syn match	cJCTypeCast	"(\s*\(\(const\|restrict\|volatile\|signed\|unsigned\|struct\|enum\)[ \t*]\+\)*\I\i*\s*\**\s*\(restrict\)\?\s*)\s*[^) \t;,{]"me=e-1
" Avoid matching function calls as TypeCast
"syn match	cJCFctCall	"\i\s*(\s*\(signed\s\|unsigned\s\|struct\s\)\=\I\i*\s*\**\s*)"
syn match	cJCFctCall	"\i\s*(\s*\(\(const\|restrict\|volatile\|signed\|unsigned\|struct\|enum\)[ \t*]\+\)*\I\i*\s*\**\s*)"

" if, while, do while
"syn region	cJCIf		matchgroup=cConditional start="\s*\(\<else\s\+\)\=if\s\+("he=e-1,me=e-1 matchgroup=NONE end=")" contains=cJCTypeCast
"syn region	cJCParent	matchgroup=Normal start="(" end=")" contained contains=cJCTypeCast,cParen
syn region	cJCIfParent	matchgroup=cStatement start="(" end=")" contained contains=ALLBUT,@cParenGroup,cJCTypeInDecl
"syn region	cJCIf		matchgroup=cConditional start="\s*\(\<else\s\+\)\=if\s\+("rs=e-1 matchgroup=NONE end="." contains=cJCIfParent
"syn region	cJCIf		matchgroup=cConditional start="\(\s*\(\<else\s\+\)\=\<if\|\s*\<while\)\s*("rs=e-1 matchgroup=NONE end="." contains=cJCIfParent
syn region	cJCIf		matchgroup=cConditional start="\(\s*\(\<else\s\+\)\=\<if\|\s*\<while\)\s*("rs=e-1 matchgroup=NONE end="." contains=cJCIfParent
syn region	cJCSwitch	matchgroup=cConditional start="\<switch\s*(" end=")" contains=ALLBUT,@cParenGroup,cJCTypeInDecl
syn region	cJCFor		matchgroup=cConditional start="\<for\s*(" end=")" contains=ALLBUT,@cParenGroup,cJCTypeInDecl
syn region	cJCWhile	matchgroup=cConditional start="\<while\s*(" end=")" contains=ALLBUT,@cParenGroup,cJCTypeInDecl

" pb : interference avec cInParen
syn match	cJCBlocParen	 "[{}]"

syn match	cStatement	"^\s*return\>."me=e-1
syn match	cStatement	"^\s*goto\s\+\I"me=e-1
" le case
syn match	cConditional	"^\s*case\>."me=e-1
syn match	cConditional	":\s*$"

"syn match	cNoHL		"sizeof"
" important pour as que l'argument puisse être interprété comme TypeCast
"syn match	cOperator	"sizeof\s*("he=e-1
"syn region	cSizeofParen	matchgroup=cNoHL start="sizeof\s*(" end=")" contains=ALLBUT,@cParenGroup,cJCTypeInDecl

if !exists("did_c_syntax_inits")
  hi link cJCType		Type
  hi link cJCParamType		Type
  hi link cJCTypeInDecl		Type
  hi link cJCTypeCast		Type
  hi link cJCBlocParen		cStatement

  " Debug
  "hi cJCTypeCast	guibg=Grey50
  "hi cJCIf		guibg=Grey70 guifg=Black
  "hi cJCIfParent	guibg=Grey50
  "hi cJCDecl		guibg=#d08080
  "hi cJCType		guibg=Grey50
  "hi cJCTypeInDecl	guibg=Grey70
  "hi cJCFunc		guibg=Grey30
  "hi cJCParamType	guibg=Grey50
endif
"--------------------------------------------------------------------------

if !exists("did_c_syntax_inits")
  let did_c_syntax_inits = 1
  " The default methods for highlighting.  Can be overridden later
  hi link cLabel	Label
  hi link cUserLabel	Label
  hi link cConditional	Conditional
  hi link cRepeat	Repeat
  hi link cCharacter	Character
  hi link cSpecialCharacter cSpecial
  hi link cNumber	Number
  hi link cFloat	Float
  hi link cOctalError	cError
  hi link cParenError	cError
  hi link cInParen	cError
  hi link cCommentError	cError
  hi link cSpaceError	cError
  hi link cOperator	Operator
  hi link cStructure	Structure
  hi link cStorageClass	StorageClass
  hi link cInclude	Include
  hi link cPreProc	PreProc
  hi link cDefine	Macro
  hi link cIncluded	cString
  hi link cError	Error
  hi link cStatement	Statement
  hi link cPreCondit	PreCondit
  hi link cType		Type
  hi link cCommentError	cError
  hi link cCommentString cString
  hi link cComment2String cString
  hi link cCommentSkip	cComment
  hi link cString	String
  hi link cComment	Comment
  hi link cSpecial	SpecialChar
  hi link cTodo		Todo
  "hi link cIdentifier	Identifier
endif

let b:current_syntax = "c"

" vim: ts=8
