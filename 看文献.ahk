#singleinstance force
#persistent
#installkeybdhook
SetTitleMatchMode, 2

nowPage := 0
interval := 60
program := ""

InputBox, nowPage , 输入当前页码
InputBox, interval , 输入翻页秒数
InputBox, program, 限制开启的程序

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
			showTip("恭喜提前翻页!翻页间隔变为" . interval)
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
				showTip("还没看完么? 翻页间隔变为" . interval)
				finally:= 0
				break
			}
		}
	}
	if finally =1
	{
		nowPage := nowPage + 1
		thisInterval := interval
		showTip("还没看完么? 当前页为" . nowPage)
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