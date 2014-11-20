fileencoding utf-8
#SingleInstance force
#notrayicon
#installkeybdhook
#persistent
SetTitleMatchMode, regex

;********************************************************************
;加强时间监督机制, 防止篡改系统时间.
;
ver:=1.9
;********************************************************************

;********************************************************************
;因为需要支持休眠后在新的一天恢复系统(重新规定睡觉时间并清空前天的堕落时间, 向后更改系统时间是支持的, 向前更改回来时会给予惩罚, 也是一种限制吧.
;将锁屏逻辑和限制网页逻辑合并，防止锁屏时计时。修正关机逻辑。
;0：00-6:00 不许开电脑。
;修正执法环节,文明执法,和谐社会.
;未来要加入护眼、看网页、提前睡觉的选择打开功能。
;未来要加入各窗口停留时间统计功能
;ver:=1.8
;********************************************************************

;********************************************
workTimeLeft_sec:=workTime_sec:=43*60
restTimeLeft_sec:=restTime_sec:=2*60
idleRecTimeLeft_sec:=idleRecTime_sec:=5*60
blockInterval_sec:=3
informTime_sec:=10
maxIndulgeTimePerDay_sec:= 60*60
xpos:=ypos:=0
movedPair:=lockingPair:=0
checkInterval:=1
wait:=0
;--------------------------------------------
blockKeyBoard:=1
shutDownScreen:=1
menu,tray, icon, E:\Projects\ahk\eyeRest.ico
;menu,tray, nostandard
menu,tray, add,% "workTimeLeft_sec: ", showTime
;********************************************

_:=1000 * checkInterval

settimer L1, %_%

readInit()

L1:
	if(newDay())
	{
		gosub beginNewDay
	}
	nowTimeP:=a_now

	if wait=0
	{
		MouseGetPos, xpos_, ypos_

		if (movedPair=lockingPair) or (xpos<>xpos_) or (ypos<>ypos_)
		{
			lockingPair:=!lockingPair
			idleRecTimeLeft_sec:=idleRecTime_sec
		}
		else
		{
			if idleRecTimeLeft_sec>0 
				idleRecTimeLeft_sec--
		}

		if(idleRecTimeLeft_sec<=informTime_sec)
		{
			showTip("还在么")
		}

		if(idleRecTimeLeft_sec=0)
		{
			showTip("idle")
			SendMessage, 0x112, 0xF170, 2,, Program Manager  ; 0x112 为 WM_SYSCOMMAND, 0xF170 为 SC_MONITORPOWER.
			workTimeLeft_sec:=workTime_sec
		}
		else
		{
			workTimeLeft_sec--
		}

		if(workTimeLeft_sec<=informTime_sec)
		{
			showTip("locking!")
		}

		if(workTimeLeft_sec=0)
		{
			wait := 1
			restTimeLeft_sec:=restTime_sec

			loop
			{
				Progress %  Ceil((restTime_sec-restTimeLeft_sec)*1.0/restTime_sec*100), % "time remain: " . restTimeLeft_sec . " seconds", , 请等待

				if(mod(restTime_sec-restTimeLeft_sec,blockInterval_sec)=0)
				{
					if(blockKeyBoard)
					{
						blockinput on
					}
					if(shutDownScreen)
					{
						SendMessage, 0x112, 0xF170, 2,, Program Manager  ; 0x112 为 WM_SYSCOMMAND, 0xF170 为 SC_MONITORPOWER.
					}
				}
				Sleep, 1000
				if restTimeLeft_sec--=0
				{
					break
				}
			}
			Progress, Off
			blockinput off
			SendMessage, 0x112, 0xF170, -1,, Program Manager  ; 0x112 为 WM_SYSCOMMAND, 0xF170 为 SC_MONITORPOWER.

			workTimeLeft_sec:=workTime_sec
			lockingPair:=!movedPair
			idleRecTimeLeft_sec:=5
			wait:=0
		}
		xpos:=xpos_
		ypos:=ypos_

		;*******************************************************
		
		ifwinexist 人人网|瀚海星云|李毅|贴吧|qzone|微博|少年包青天|磨铁
		{
			if(totalTime>maxIndulgeTimePerDay_sec)
			{
				showTip("你今天放纵的时间太长了. 是你自己动手呢, 还是我来帮你? ")
				gosub 执法
			}
			else
			{
				totalTime+=1
				if(totalTime>=maxIndulgeTimePerDay_sec-600)
				{
					showTip("今天放纵时间余额不足10分钟.")
				}
			}
		}
		;******************************************************

		if(a_hour<6)
		{
			showTip("起这么早干什么?玩电脑就更不对了!")
		}
		else
		{
			_:=sleepTimeP
			_-=%a_now% ,S

			if(_<0)
			{
				showTip("已经到睡觉时间, 马上关机!")
			}
			else if(_<300)
			{
				showTip("快到睡觉时间了, 早睡早起, 方能自习啊.`n还有" . (_//60) . "分" . mod(_, 60) . "秒"),
			}
		}
		;******************************************************
		write(totalTime,nowTimeP,sleepTimeP)
	}

return

执法:
	sleep 3000
	ifwinactive 人人网|瀚海星云|李毅|贴吧|qzone|微博|少年包青天|san|磨铁
	{
		send {lwin down}d{lwin up}
	}
return

showTime:
	showTip("workTimeLeft_sec: " . workTimeLeft_sec . " seconds")
return

reqClearTime()
{
	global movedPair
	global lockingPair
	movedPair:=lockingPair
}

readInit()
{
	global maxIndulgeTimePerDay_sec
	global totalTime
	global nowTimeP
	global sleepTimeP

	ifexist 做个好学霸.ini
	{
		iniRead, nowTimeP, 做个好学霸.ini, default , nowTimeP
		IniRead, sleepTimeP, 做个好学霸.ini, default , sleepTimeP
		IniRead, totalTime, 做个好学霸.ini, default , totalTime
	}
	else
	{
		totalTime:=maxIndulgeTimePerDay_sec
		sleepTimeP:=a_yyyy . a_mm . a_dd . "220000"
		nowTimeP := a_now
		write(totalTime,sleepTimeP,nowTimeP)
	}
}

newDay()
{
	global nowTimeP
	
	if(substr(nowTimeP,1,8)<a_yyyy . a_mm . a_dd)
	{
		_:= 1
	}
	else
	{
		_:= 0
	}

	return _
}

beginNewDay:
	wait:=1
	showTip("今天是" . a_mm . "月" . a_dd "号, 上次开机是" . substr(nowTimeP,5,2) . "月" . substr(nowTimeP,7,2) . "号. 那天的总堕落时间是" . Ceil( totalTime/60) . "分, 新的一天, 新的挑战, 别让自己失望! ") ; Today is %a_mm%`.%a_dd%, last recorded deprived time is %totalTime% min. It's a new day, a new start. Come on!
	totalTime:=0
	sleepTimeP:=a_yyyy . a_mm . a_dd . "2300" . "00"
	nowTimeP:=a_yyyy . a_mm . a_dd . a_hour . a_min . a_sec
	wait :=0
return

write(totalTime,nowTimeP,sleepTimeP)
{
	global maxIndulgeTimePerDay_sec
	
	iniwrite %sleepTimeP%, 做个好学霸.ini, default , sleepTimeP
	iniwrite %nowTimeP%, 做个好学霸.ini, default ,nowTimeP
	iniwrite %totalTime%, 做个好学霸.ini, default , totalTime
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

^!#+b::			;报告bug的"快捷键"
	name:="YnVncmVwb3J0dG9zc3E="
	pass:="YnVncmVwb3J0"
	InputBox, contents , 您的支持是我不懈努力的理由`! , 请输入bug内容`, 按回车结束`.
	run telnet smtp.163.com 25
	sleep 500
	send HELO localhost{enter}
	sleep 100
	send AUTH LOGIN{enter}
	sleep 100
	send %name%{enter}
	sleep 100
	send %pass%{enter}
	sleep 100
	send mail from:<bugreporttossq@163.com>{enter}
	sleep 100
	send rcpt to:<bugreporttossq@163.com>{enter}
	sleep 100
	send data{enter}
	sleep 100
	send rcpt to:<bugreporttossq@163.com>{enter}from:<bugreporttossq@163.com>{enter}to:<bugreporttossq@163.com>{enter}subject:[bug][当个学霸有多难]{enter}{enter}版本号:%ver%{enter}%contents%{enter}.{enter}bye{enter}
return

~rwin::
~lwin::
~ctrl::
~alt::
~space::
~esc::
~enter::
~pgup::
~pgdn::
~up::
~down::
~left::
~right::
~wheeldown::
~wheelup::
~lbutton::
~rbutton::
~mbutton::
~a::
~b::
~c::
~d::
~e::
~f::
~g::
~h::
~i::
~j::
~k::
~l::
~m::
~n::
~o::
~p::
~q::
~r::
~s::
~t::
~u::
~v::
~w::
~x::
~y::
~z::reqClearTime()
