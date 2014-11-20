
#SingleInstance force
#notrayicon
#persistent
;***************************************************************
;定时重载守护程序

settimer L1, 1000

L1:
	process exist, ahkDeamon.exe
	if(errorlevel=0)
		run % a_scriptdir . "\ahkDeamon.exe"

return				;下文全是标签或热键, 运行部分只可能在上方.
;***************************************************************
