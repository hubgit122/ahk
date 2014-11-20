#SingleInstance force
#notrayicon
SetTitleMatchMode, regex

_:="HotKeys.exe,ahkDeamon.exe,当个学霸有多难.exe"  ;AutoHotKey.exe,clips.exe,

loop 3
{
	loop,parse,_,`,
	{
		process exist,%A_LoopField%
		if(errorlevel)
			process close, %A_LoopField%
;		msgbox % a_scriptdir . "\" . A_LoopField
	}
}