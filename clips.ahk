;剪切板增强

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
;		temp:=temp . "`n" . "【" . i . "】" . substr(clip%i%,1,10)
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
			temp:="【&" . i . "】" . substr(clip%i%,1,10)
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
	send {CTRLDOWN}x{CTRLUP}		;如果不保存此次复制, 就按shift
return

mbutton & WheelDown::send {CTRLDOWN}v{CTRLUP}

^!d::						;在很多编辑器中可以实现复制一行
	mouseclick
	mouseclick
	mouseclick
	send ^c
	send {left}		;取消高亮
return

mbutton & Wheelup::
;CTRL DOWN c CTRL UP::		;这样的组合是不支持的, 支持的只有热键, 没有动态
;OnClipboardChange:			;不能用这个, 这个影响面太大
$^c::						;如果不加$, 会自己触发自己, 退出后按键混乱了.
	send {CTRLDOWN}c{CTRLUP}			;不屏蔽系统

	if(clipboard_=clipboard)			;对文件或目录连续按两次复制, 就转为它的路径, 而只按一次, 可以在某处粘贴此文件或路径.
	{
		if(unpack=1)
		{
			clipboard:=clipboard			;把路径转成文本
		}
	}
	else								;新内容保存
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

sendClip(byref clipN)		;按块输出, 和粘贴的结果一样, 撤销只需一次ctrl z
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
