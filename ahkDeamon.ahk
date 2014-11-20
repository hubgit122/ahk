#SingleInstance force
#notrayicon
#persistent
#installkeybdhook
SetTitleMatchMode, regex

_:="clips.exe,HotKeys.exe,当个学霸有多难.exe"

settimer L1, 1000

L1:
;	sleep 300
	loop,parse,_,`,
	{
;		msgbox % a_scriptdir . "\" . A_LoopField
		process exist, %A_LoopField%
		if(errorlevel=0)
			run % a_scriptdir . "\" . A_LoopField
	}
return