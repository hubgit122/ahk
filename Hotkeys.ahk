
#SingleInstance force
#notrayicon
#persistent
;***************************************************************
;��ʱ�����ػ�����

settimer L1, 1000

L1:
	process exist, ahkDeamon.exe
	if(errorlevel=0)
		run % a_scriptdir . "\ahkDeamon.exe"

return				;����ȫ�Ǳ�ǩ���ȼ�, ���в���ֻ�������Ϸ�.
;***************************************************************
