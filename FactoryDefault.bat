@echo off
setlocal enabledelayedexpansion
@REM 2023/8/4 第5版 

set SMC_Parent=C:\Users\Stephenhuang
set /p ip= "BMC ip: "
set /p Uniqpwd= "Input Unique Password: "
set pwd=ADMIN

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
            SMCIPMITOOL.exe %ip% ADMIN %Uniqpwd% !command:~1,-1!
        ) else (
            echo Start executing !command:~1,-1!
            SMCIPMITOOL.exe %ip% ADMIN %pwd% !command:~1,-1!
        )
        if %%i equ "ipmi raw 30 40" (
            echo Start executing !command:~1,-1!
            SMCIPMITOOL.exe %ip% ADMIN %pwd% !command:~1,-1!
        )
        timeout !sec!
        call :PingSUT
    )
    cd /d D:\Script
    goto :eof
) else (
    echo SMCIPMITool folder doesn't exist
    echo SMC Parent Path=%SMC_Parent%
    cd /d D:\Script
    goto :eof
)

@REM 寫個方法查詢ping結果
:PingSUT
ping -n 1 %ip% > ping_result.txt
find "TTL=" ping_result.txt > nul
if %errorlevel% equ 0 (
    echo PASS
    del ping_result.txt
) else (
    del ping_result.txt
    timeout 30
    call :PingAgain
)
goto :eof

:PingAgain
ping -n 1 %ip% > ping_again.txt
find "TTL=" ping_again.txt > nul
if %errorlevel% equ 0 (
    echo PASS
    del ping_again.txt
) else (
    echo FAIL
    del ping_again.txt
)
cd /d D:\Script
:eof 