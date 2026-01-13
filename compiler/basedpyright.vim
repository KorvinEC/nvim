" Vim compiler file
" Compiler:     basedpyright (Python Type Checker)
" Maintainer:   @IlyaMaksheev
" Last Change:  2026 Jan 04

if exists("current_compiler") | finish | endif
let current_compiler = "basedpyright"

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=basedpyright

" /home/korvin/projects/bot-trading/src/bot_trading/data_analyse/data_analyse.py
"   /home/korvin/projects/bot-trading/src/bot_trading/data_analyse/data_analyse.py:35:63 - error: Type parameter "C" is not included in the type parameter list for "MintToCandleManagerType" (reportGeneralTypeIssues)
"   /home/korvin/projects/bot-trading/src/bot_trading/data_analyse/data_analyse.py:114:59 - error: Attribute type cannot use type variable "C@__init__" scoped to local method (reportGeneralTypeIssues)
"   /home/korvin/projects/bot-trading/src/bot_trading/data_analyse/data_analyse.py:150:9 - warning: Type of parameter "candles_manager" is partially unknown
"     Parameter type is "CandlesManager[T@DataAnalyse, Unknown]" (reportUnknownParameterType)
"   /home/korvin/projects/bot-trading/src/bot_trading/data_analyse/data_analyse.py:150:41 - error: Too few type arguments

"  /home/user/file.py:1:2 - error: error text
set errorformat=%E\ %#%f:%l:%c\ -\ %t%.%#:\ %m
"     Parameter type is "CandlesManager[T@DataAnalyse, Unknown]" (reportUnknownParameterType)
set errorformat+=%C\ %#%m
set errorformat+=%Z\ %#%m
"/home/user/file.py
"0 errors, 0 warnings, 0 notes
set errorformat+=%-G%.%#

CompilerSet errorformat

let &cpo = s:cpo_save
unlet s:cpo_save

