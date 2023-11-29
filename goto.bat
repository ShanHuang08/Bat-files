@echo off

set SMC_Parent=C:\Users\Stephenhuang
set /p ip= "BMC ip: "
set pwd=ADMIN
cd /d C:\
if exist %SMC_Parent%\SMC* (
    cd %SMC_Parent%\SMC*
    
    
:CheckMEL_pwd    
cd %SMC_Parent%\SMC*
SMCIPMITOOL.exe %ip% ADMIN %pwd% mel list 10 > %SMC_Parent%\Mel_list.txt
find "MEL-0056" %SMC_Parent%\Mel_list.txt > nul
if %errorlevel% equ 0 (
    echo MEL-0056 has found
    del %SMC_Parent%\Mel_list.txt
    cd /d D:\Script
) else (
    echo MEL-0056 has not found
    echo FAIL
)

:CheckMEL_Unique    
cd %SMC_Parent%\SMC*
SMCIPMITOOL.exe %ip% ADMIN %Uniqpwd% mel list 10 > %SMC_Parent%\Mel_list.txt
find "MEL-0056" %SMC_Parent%\Mel_list.txt > nul
if %errorlevel% equ 0 (
    echo MEL-0056 has found
    del %SMC_Parent%\Mel_list.txt
    cd /d D:\Script
) else (
    echo MEL-0056 has not found
    echo FAIL
)