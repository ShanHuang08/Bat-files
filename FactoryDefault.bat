@echo off
setlocal enabledelayedexpansion
@REM 2023/11/30 第6版 

set SMC_Parent=C:\Users\Stephenhuang
set /p ip= "BMC ip: "
set /p account = "Input account: "
set /p Uniqpwd= "Input Unique Password: "
set pwd=ADMIN
@REM set pwd=admin

set "string=!ip:~0,3!"
if "!string!"=="10." (
    set sec=150
)
if "!string!"=="172" (
    set sec=160
)

REM 檢查IP是否有效
cd /d D:\Script
ping -n 2 %ip% > ping_result.txt
find "TTL=" ping_result.txt > nul
if %errorlevel% equ 0 (
    echo %ip% is valid ip
    del ping_result.txt
) else (
    echo %ip% is invalid ip
    del ping_result.txt
    pause
    goto :eof 
)

rem 檢查資料夾
echo %SMC_Parent% | findstr /C:"C:" > nul
if %errorlevel% equ 0 (
    cd /d C:\
) else (
    cd /d D:\
)

set cmd1="ipmi raw 30 40"
set cmd2="ipmi raw 30 41"
set cmd3="ipmi raw 30 42"
set cmd4="ipmi raw 30 48 0"
set cmd5="ipmi fd 1"
set cmd6="ipmi raw 30 48 1"
set cmd7="ipmi fd 2"
set cmd8="ipmi fd 3"
set Commands=%cmd1% %cmd2% %cmd3% %cmd4% %cmd5% %cmd6% %cmd7% %cmd8%


cd %SMC_Parent%
if exist %SMC_Parent%\SMC* (
    cd %SMC_Parent%\SMC*
    for %%i in (%Commands%) do (
        set "command=%%i"
        if %%i neq "ipmi raw 30 40" if %%i neq "ipmi fd 2" (
            echo Start executing !command:~1,-1!
            SMCIPMITOOL.exe %ip% %account% %Uniqpwd% !command:~1,-1!
        ) else (
            echo Start executing !command:~1,-1!
            SMCIPMITOOL.exe %ip% %account% %pwd% !command:~1,-1!
        )
        if %%i equ "ipmi raw 30 40" (
            echo Start executing !command:~1,-1!
            SMCIPMITOOL.exe %ip% %account% %pwd% !command:~1,-1!
        )
        timeout !sec!
        call :CheckMEL_pwd 
    )
    cd /d D:\Script
    goto :eof
) else (
    echo SMCIPMITool folder doesn't exist
    echo SMC Parent Path=%SMC_Parent%
    cd /d D:\Script
    goto :eof
)

:CheckMEL_pwd    
cd %SMC_Parent%\SMC*
SMCIPMITOOL.exe %ip% %account% %pwd% mel list 10 > %SMC_Parent%\Mel_list.txt
find "MEL-0056" %SMC_Parent%\Mel_list.txt > nul
if %errorlevel% equ 0 (
    echo MEL-0056 has found
    echo PASS
    del %SMC_Parent%\Mel_list.txt
) else (
    find "unauthorized" %SMC_Parent%\Mel_list.txt > nul
    if %errorlevel% equ 0 (
        SMCIPMITOOL.exe %ip% %account% %Uniqpwd% mel list 10 > %SMC_Parent%\Mel_list.txt
        find "MEL-0056" %SMC_Parent%\Mel_list.txt > nul
        if %errorlevel% equ 0 (
            echo MEL-0056 has found
            echo PASS
            del %SMC_Parent%\Mel_list.txt
        ) else (
            echo MEL-0056 has not found
            echo FAIL
        )
    ) 
)