
;��ݼ����˼·: #��^��!��϶�������Ϊ��������������ĳĬ�ϼ�λ, ���Ծ�����win�����ļ����ʹ��.
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

;����, ��վ�ͽű�
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

;�ļ���, �����ļ�
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
	dir:="d:\����������������ѧϰ"
	run %dir%
	clipboard=%dir%
return
#^k::
	dir:="d:\�γ�����"
	run %dir%
	clipboard=%dir%
return
#^j::
	dir:="d:\�����ѧϰ"
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

;���
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
#!x::run d:\Tools\PDF���߰���14��1��\PDF������.exe
#!k::run D:\Program Files (x86)\Kmplayer Plus\KMPlayerPortable.exe "d:\mp3\�����Ǳ�Э����"
#!w::run D:\Program Files (x86)\Wing IDE 5.0.9\bin\wing.exe
#!+w::run D:\Program Files (x86)\Wing IDE 5.0.9\bin\wing.exe C:\Users\ssqstone\Desktop\��ʱ��������.py
#!o::run d:\Program Files (x86)\UltraISO\UltraISO.exe
#!m::run d:\Program Files\Foxmail 7.1\Foxmail.exe
#+!m::run D:\Program Files\Araxis\Araxis Merge\Merge.exe
#!u::run d:\Program Files (x86)\IDM Computer Solutions\UltraEdit\Uedit32.exe
#!+u::run d:\Program Files (x86)\IDM Computer Solutions\UltraEdit\Uedit32.exe %clipboard%
#!b::run d:\Program Files (x86)\˶��\commence.exe
#!l::run d:\Tools\��Ļ����.exe
#!t::run d:\Program Files (x86)\TC7\tc.exe
#!+t::run D:\Program Files (x86)\��������ͨ���ƽ��Ѹ��\Thunder.exe
#!+f::run d:\Program Files (x86)\FlashFXP 4.1.4.1664  �һ��ƽ��\FlashFXP.exe
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

;����win�������
~lwin up::return	;����win��, ������ϼ���win�󰴵�ʱ���ǿ���ʶ���.
!f2::send {f2}^a{end}

;��д
::/yx::shishouqian14@mails.ucas.ac.cn
::/qqyx::834165855@qq.com
::/sj::13164201313
::/xh::201418014629098
::/dz::�����л���������ׯ�й���ѧԺ��ѧ���ܺ�У��
::/sign::ʯ��ǫ �й���ѧԺ��ѧ 2014�� ֱ���� ����������ѧԺ shishouqian14@mails.ucas.ac.cn

;���㹦��
^!#+q::run d:\Program Files (x86)\Tencent\QQ\Bin\QQ.exe
^!t::showTip(a_mm . "��" . a_dd . "��" . a_hour . "ʱ" . a_min . "��")
+f7::sendC(A_YYYY . "-" . A_MM . "-" . A_DD)

;д����ר��
^+/::sendC("// TO-DO")
^!z::  ; Control+Alt+Z �ȼ�.
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
