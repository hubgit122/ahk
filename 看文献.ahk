#singleinstance force
#persistent
#installkeybdhook
SetTitleMatchMode, 2

nowPage := 0
interval := 60
program := ""

InputBox, nowPage , ���뵱ǰҳ��
InputBox, interval , ���뷭ҳ����
InputBox, program, ���ƿ����ĳ���

thisInterval := interval
settimer L1, 1000

loop
{
    if %program%
        IfWinNotActive , %program%
            ifwinexist , %program%
                winactivate %program%

	finally:= 1
	counter:= 0
	page_ := nowPage
	
	loop, %thisInterval%
	{
		sleep 1000
		
		counter := counter+1
		
		if nowPage>%page_%
		{
			interval := interval - 0.5 * (thisInterval-counter)
			showTip("��ϲ��ǰ��ҳ!��ҳ�����Ϊ" . interval)
			thisInterval := interval
			finally:= 0
			break
		}
		else
		{
			if nowPage<%page_%
			{
				thisInterval := interval*0.5
				interval := interval + thisInterval
				showTip("��û����ô? ��ҳ�����Ϊ" . interval)
				finally:= 0
				break
			}
		}
	}
	if finally =1
	{
		nowPage := nowPage + 1
		thisInterval := interval
		showTip("��û����ô? ��ǰҳΪ" . nowPage)
		;send {pgdn}
	}
}
return

~pgdn::
	nowPage := nowPage+1
return

~pgup::
	nowPage := nowPage-1
return

^#!+p::
	Pause
return

showTip(str)
{
	str:="*************************************`n" . str . "`n*************************************"
	tooltip % str
	SetTimer, RemoveToolTip, 2000
}

RemoveToolTip:
	SetTimer, RemoveToolTip, Off
	ToolTip
return


L1:
	ifwinactive PDF
	{
	}
	else
	{
		winactivate PDF
	}