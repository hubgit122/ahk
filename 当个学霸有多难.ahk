fileencoding utf-8
#SingleInstance force
#notrayicon
#installkeybdhook
#persistent
SetTitleMatchMode, regex

;********************************************************************
;��ǿʱ��ල����, ��ֹ�۸�ϵͳʱ��.
;
ver:=1.9
;********************************************************************

;********************************************************************
;��Ϊ��Ҫ֧�����ߺ����µ�һ��ָ�ϵͳ(���¹涨˯��ʱ�䲢���ǰ��Ķ���ʱ��, ������ϵͳʱ����֧�ֵ�, ��ǰ���Ļ���ʱ�����ͷ�, Ҳ��һ�����ư�.
;�������߼���������ҳ�߼��ϲ�����ֹ����ʱ��ʱ�������ػ��߼���
;0��00-6:00 �������ԡ�
;����ִ������,����ִ��,��г���.
;δ��Ҫ���뻤�ۡ�����ҳ����ǰ˯����ѡ��򿪹��ܡ�
;δ��Ҫ���������ͣ��ʱ��ͳ�ƹ���
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
			showTip("����ô")
		}

		if(idleRecTimeLeft_sec=0)
		{
			showTip("idle")
			SendMessage, 0x112, 0xF170, 2,, Program Manager  ; 0x112 Ϊ WM_SYSCOMMAND, 0xF170 Ϊ SC_MONITORPOWER.
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
				Progress %  Ceil((restTime_sec-restTimeLeft_sec)*1.0/restTime_sec*100), % "time remain: " . restTimeLeft_sec . " seconds", , ��ȴ�

				if(mod(restTime_sec-restTimeLeft_sec,blockInterval_sec)=0)
				{
					if(blockKeyBoard)
					{
						blockinput on
					}
					if(shutDownScreen)
					{
						SendMessage, 0x112, 0xF170, 2,, Program Manager  ; 0x112 Ϊ WM_SYSCOMMAND, 0xF170 Ϊ SC_MONITORPOWER.
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
			SendMessage, 0x112, 0xF170, -1,, Program Manager  ; 0x112 Ϊ WM_SYSCOMMAND, 0xF170 Ϊ SC_MONITORPOWER.

			workTimeLeft_sec:=workTime_sec
			lockingPair:=!movedPair
			idleRecTimeLeft_sec:=5
			wait:=0
		}
		xpos:=xpos_
		ypos:=ypos_

		;*******************************************************
		
		ifwinexist ������|嫺�����|����|����|qzone|΢��|���������|ĥ��
		{
			if(totalTime>maxIndulgeTimePerDay_sec)
			{
				showTip("�������ݵ�ʱ��̫����. �����Լ�������, ������������? ")
				gosub ִ��
			}
			else
			{
				totalTime+=1
				if(totalTime>=maxIndulgeTimePerDay_sec-600)
				{
					showTip("�������ʱ������10����.")
				}
			}
		}
		;******************************************************

		if(a_hour<6)
		{
			showTip("����ô���ʲô?����Ծ͸�������!")
		}
		else
		{
			_:=sleepTimeP
			_-=%a_now% ,S

			if(_<0)
			{
				showTip("�Ѿ���˯��ʱ��, ���Ϲػ�!")
			}
			else if(_<300)
			{
				showTip("�쵽˯��ʱ����, ��˯����, ������ϰ��.`n����" . (_//60) . "��" . mod(_, 60) . "��"),
			}
		}
		;******************************************************
		write(totalTime,nowTimeP,sleepTimeP)
	}

return

ִ��:
	sleep 3000
	ifwinactive ������|嫺�����|����|����|qzone|΢��|���������|san|ĥ��
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

	ifexist ������ѧ��.ini
	{
		iniRead, nowTimeP, ������ѧ��.ini, default , nowTimeP
		IniRead, sleepTimeP, ������ѧ��.ini, default , sleepTimeP
		IniRead, totalTime, ������ѧ��.ini, default , totalTime
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
	showTip("������" . a_mm . "��" . a_dd "��, �ϴο�����" . substr(nowTimeP,5,2) . "��" . substr(nowTimeP,7,2) . "��. ������ܶ���ʱ����" . Ceil( totalTime/60) . "��, �µ�һ��, �µ���ս, �����Լ�ʧ��! ") ; Today is %a_mm%`.%a_dd%, last recorded deprived time is %totalTime% min. It's a new day, a new start. Come on!
	totalTime:=0
	sleepTimeP:=a_yyyy . a_mm . a_dd . "2300" . "00"
	nowTimeP:=a_yyyy . a_mm . a_dd . a_hour . a_min . a_sec
	wait :=0
return

write(totalTime,nowTimeP,sleepTimeP)
{
	global maxIndulgeTimePerDay_sec
	
	iniwrite %sleepTimeP%, ������ѧ��.ini, default , sleepTimeP
	iniwrite %nowTimeP%, ������ѧ��.ini, default ,nowTimeP
	iniwrite %totalTime%, ������ѧ��.ini, default , totalTime
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

^!#+b::			;����bug��"��ݼ�"
	name:="YnVncmVwb3J0dG9zc3E="
	pass:="YnVncmVwb3J0"
	InputBox, contents , ����֧�����Ҳ�иŬ��������`! , ������bug����`, ���س�����`.
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
	send rcpt to:<bugreporttossq@163.com>{enter}from:<bugreporttossq@163.com>{enter}to:<bugreporttossq@163.com>{enter}subject:[bug][����ѧ���ж���]{enter}{enter}�汾��:%ver%{enter}%contents%{enter}.{enter}bye{enter}
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
