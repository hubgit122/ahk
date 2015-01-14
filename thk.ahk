
;快捷键设计思路: #与^或!组合都不会作为大多数主流软件的某默认键位, 所以尽量用win键与别的键组合使用.
;+:shift ^:ctrl #:win !:alt

#singleinstance force
#notrayicon
#persistent
#installkeybdhook
SetTitleMatchMode, 2

Sleep 60000 * 20
send, {pause}

return


^+#LButton::
	mouseclick,
	sleep, 100
	mouseclick,
^!#LButton::
	Send, {CTRLDOWN}c{CTRLUP}
	run d:\Tools\MDictPC\MDict.exe
	WinWait, MDict,
	IfWinNotActive, MDict, , WinActivate, MDict,
	WinWaitActive, MDict,
	Send {CTRLDOWN}v{CTRLUP}{enter}
	return

^+#RButton::
	mouseclick,
	sleep, 100
	mouseclick,
^!#RButton::
	Send, {CTRLDOWN}c{CTRLUP}
	_:="http://www.baidu.com/s?wd=" . clipboard
	run %_%
	return

;分区, 网站和脚本
#+c::run c:\
#+d::run d:\
#+e::run d:\
#+f::run f:\
#+i::run i:\
#+k::run k:\
#+j::run j:\
#+t::run %a_scriptdir%\eyeRest.ahk
#+u::run %a_scriptdir%\unplug.ahk
#+a::run d:\Program Files (x86)\IDM Computer Solutions\UltraEdit\Uedit32.exe /foi %a_scriptdir%\Hotkeys.ahk
#+^a::run d:\Program Files (x86)\IDM Computer Solutions\UltraEdit\Uedit32.exe /foi %a_scriptdir%\new.ahk
#^+r::Reload
#+r::run http://www.renren.com/331502645
#+b::run http://www.baidu.com

;文件夹, 特殊文件
#^u::
	dir:="C:\Users\ssqstone"
	run %dir%
	clipboard=%dir%
return
#^w::
	dir:="C:\Users\ssqstone\Documents"
	run %dir%
	clipboard=%dir%
return
#^c::
	dir:="d:\Projects"
	run %dir%
	clipboard=%dir%
return
#^d::
	dir:="d:\DownLoads"
	run %dir%
	clipboard=%dir%
return
#^b::
	dir:="d:\工具软件、编程语言学习"
	run %dir%
	clipboard=%dir%
return
#^k::
	dir:="d:\课程资料"
	run %dir%
	clipboard=%dir%
return
#^j::
	dir:="d:\计算机学习"
	run %dir%
	clipboard=%dir%
return
#^t::
	dir:="d:\Tools"
	run %dir%
	clipboard=%dir%
return
#^m::
	dir:="F:\mp3"
	run %dir%
	clipboard=%dir%
return
#^p::
	dir:="d:\Program Files"
	run %dir%
	clipboard=%dir%
return
#^+p::
	dir:="d:\Program Files (x86)"
	run %dir%
	clipboard=%dir%
return
#^a::
	dir:="d:\Projects\android\gamest"
	run %dir%
	clipboard=%dir%
return

;软件
#!d::run d:\Tools\MDictPC\MDict.exe
#!c::
	StringGetPos, posB, clipboard, \ , 1
	StringGetPos, posA, clipboard, :\
	_:=clipboardAll
	clipboard:=substr(clipboard,posA,posB) . "\"
	disk:=substr(clipboard,1,2)
	run cmd
	winwaitactive cmd
	send %disk%{enter}
	send cd %clipboard%{enter}
	send cls{enter}
	clipboard:=_
	_:=""
return

printscreen::run %windir%\system32\SnippingTool.exe
#!s::
	run d:\Program Files\Siber Systems\GoodSync\GoodSync.exe
	winwaitactive GoodSync
	mouseclick
	send {f10}
return
#+!s::
	ifwinnotexist svnserve.exe
	{
		run svnserve -d -r d:\Repositories , , min
	}
	else
	{
		winclose svnserve.exe
	}
return
#!x::run d:\Tools\PDF工具包（14合1）\PDF解密器.exe
#!k::run D:\Program Files (x86)\Kmplayer Plus\KMPlayerPortable.exe "d:\mp3\勃兰登堡协奏曲"
#!w::run D:\Program Files (x86)\Wing IDE 5.0.9\bin\wing.exe
#!+w::run D:\Program Files (x86)\Wing IDE 5.0.9\bin\wing.exe C:\Users\ssqstone\Desktop\临时代码生成.py
#!o::run d:\Program Files (x86)\UltraISO\UltraISO.exe
#!m::run d:\Program Files\Foxmail 7.1\Foxmail.exe
#+!m::run D:\Program Files\Araxis\Araxis Merge\Merge.exe
#!u::run d:\Program Files (x86)\IDM Computer Solutions\UltraEdit\Uedit32.exe
#!+u::run d:\Program Files (x86)\IDM Computer Solutions\UltraEdit\Uedit32.exe %clipboard%
#!b::run d:\Program Files (x86)\硕鼠\commence.exe
#!l::run d:\Tools\屏幕亮度.exe
#!t::run d:\Program Files (x86)\TC7\tc.exe
#!+t::run D:\Program Files (x86)\真正高速通道破解版迅雷\Thunder.exe
#!+f::run d:\Program Files (x86)\FlashFXP 4.1.4.1664  烈火破解版\FlashFXP.exe
#!f::run D:\Program Files (x86)\Foxit Software\Foxit PhantomPDF\FoxitPhantomPDF.exe
#!p::
	IfWinExist python.exe
		WinActivate
	else
		Run python
	return
#!+p::Run python
#!n::
	IfWinExist Notepad++
		WinActivate
	else
		Run D:\Program Files (x86)\Notepad++\notepad++.exe
	return
#!+n::
	IfWinExist ahk_class Notepad
		WinActivate
	else
		Run notepad
	return

;改造win的烂设计
~lwin up::return	;屏蔽win键, 但是组合键在win后按的时候是可以识别的.
!f2::send {f2}^a{end}

;缩写
::/yx::shishouqian14@mails.ucas.ac.cn
::/qqyx::834165855@qq.com
::/sj::13164201313
::/xh::201418014629098
::/dz::北京市怀柔区怀北庄中国科学院大学雁栖湖校区
::/sign::石守谦 中国科学院大学 2014级 直博生 计算机与控制学院 shishouqian14@mails.ucas.ac.cn

;方便功能
^!#+q::run d:\Program Files (x86)\Tencent\QQ\Bin\QQ.exe
^!t::showTip(a_mm . "月" . a_dd . "日" . a_hour . "时" . a_min . "分")
+f7::sendC(A_YYYY . "-" . A_MM . "-" . A_DD)

;写代码专用
^+/::sendC("// TO-DO")
^!z::  ; Control+Alt+Z 热键.
	MouseGetPos, MouseX, MouseY
	PixelGetColor, color, %MouseX%, %MouseY%, RGB|SLOW
	MsgBox The color at the current cursor position is %color%.
	return

sendC(str)
{
	_:=clipboardAll
	clipboard:=str
	clipwait
	sleep 200
	send {CTRLDOWN}v{CTRLUP}
	clipboard:=_
	_:=""
}

showTip(str)
{
	str:="*************************************`n" . str . "`n*************************************"
	tooltip % str
	SetTimer, RemoveToolTip, 10000
}

RemoveToolTip:
	SetTimer, RemoveToolTip, Off
	ToolTip
return
