;���а���ǿ

#SingleInstance force
#notrayicon
#persistent
#installkeybdhook
CoordMode, ToolTip, Screen
unpack:=0
Return

;showClipsInToolTip()
;{
;	temp:="temp of clips"
;	loop 10
;	{
;		i:=a_index-1
;		temp:=temp . "`n" . "��" . i . "��" . substr(clip%i%,1,10)
;	}
;	tooltip % temp, 0 , 0
;
;	SetTimer, RemoveToolTip, 2000
;	return
;}
;
;RemoveToolTip:
;SetTimer, RemoveToolTip, Off
;ToolTip
;return

showClipsInMenu()
{
	Critical
;	static shown=0
;	if(shown)
;		send {down}
;	else
;	{
;		shown=1
		menu, popClips,add
		menu, popClips,deleteAll
		loop 10
		{
			i:=a_index-1
			temp:="��&" . i . "��" . substr(clip%i%,1,10)
			menu, popClips, add, %temp% ,send%i%
		}
		menu, popClips, show
;	}
}

^!Space::showClipsInMenu()
^+c::
	send {CTRLDOWN}c{CTRLUP}
return
^!x::
	send {CTRLDOWN}x{CTRLUP}		;���������˴θ���, �Ͱ�shift
return

mbutton & WheelDown::send {CTRLDOWN}v{CTRLUP}

^!d::						;�ںܶ�༭���п���ʵ�ָ���һ��
	mouseclick
	mouseclick
	mouseclick
	send ^c
	send {left}		;ȡ������
return

mbutton & Wheelup::
;CTRL DOWN c CTRL UP::		;����������ǲ�֧�ֵ�, ֧�ֵ�ֻ���ȼ�, û�ж�̬
;OnClipboardChange:			;���������, ���Ӱ����̫��
$^c::						;�������$, ���Լ������Լ�, �˳��󰴼�������.
	send {CTRLDOWN}c{CTRLUP}			;������ϵͳ

	if(clipboard_=clipboard)			;���ļ���Ŀ¼���������θ���, ��תΪ����·��, ��ֻ��һ��, ������ĳ��ճ�����ļ���·��.
	{
		if(unpack=1)
		{
			clipboard:=clipboard			;��·��ת���ı�
		}
	}
	else								;�����ݱ���
	{
		;temp=
		loop 9
		{
			to:=10-a_index
			from:=to-1
			;temp:=temp . "`n" . clip%from% . "->" . clip%to%
			clip%to%:=clip%from%
		}
		clip%0%=%clipboard%
		;msgbox %temp%
	}
	clipboard_:=clipboard
	unpack:=1
	settimer, dontUnpack, 1000
return

dontUnpack:
	SetTimer, dontUnpack, Off
	unpack:=0
return

$^x::
	send {CTRLDOWN}x{CTRLUP}
moveclips:
	if(clipboard_<>clipboard)
	{
		loop 9
		{
			to:=10-a_index
			from:=to-1
			clip%to%:=clip%from%
		}
		clip%0%=%clipboard%
	}
	clipboard_:=clipboard
return

sendClip(byref clipN)		;�������, ��ճ���Ľ��һ��, ����ֻ��һ��ctrl z
{
	critical
	_:=clipboardall
	clipboard:=clipN
	sleep 100
	send {CTRLDOWN}v{CTRLUP}
	clipboard:=_
	_=
}

send0:
^!0::
	sendClip(clip0)
return
^!1::
send1:
	sendClip(clip1)
return
^!2::
send2:
	sendClip(clip2)
return
^!3::
send3:
	sendClip(clip3)
return
^!4::
send4:
	sendClip(clip4)
return
^!5::
send5:
	sendClip(clip5)
return
^!6::
send6:
	sendClip(clip6)
return
^!7::
send7:
	sendClip(clip7)
return
^!8::
send8:
	sendClip(clip8)
return
^!9::
send9:
	sendClip(clip9)
return
