@echo off
@REM 2023/7/25 第一版 

set SMC_Parent=C:\Users\Stephenhuang
set /p ip= "BMC ip: "
set /p Uniqpwd="Input Unique Password: "
set pwd=ADMIN

REM 檢查IP是否有效
cd /d D:\Script
ping %ip% > ping_result.txt
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

REM 檢查是否要用Unique Password
echo %SMC_Parent% | findstr /C:"C:" > nul
if %errorlevel% equ 0 (
    cd /d C:\
) else (
    cd /d D:\
)

cd %SMC_Parent%\SMC*
SMCIPMITOOL.exe %ip% ADMIN %pwd% user list 2 > Login_Message.txt 
find "Can't login to" Login_Message.txt > nul
if not %errorlevel% equ 0 (
    del Login_Message.txt 
) else (
    echo Use %pwd% login failed
    if /i %Checkuni%==n (
        set /p pwd="Input Unique Password: "
    ) else (
        set pwd=ADMIN
    )
    del Login_Message.txt
)

cd %SMC_Parent%
if exist %SMC_Parent%\SMC* (
    cd %SMC_Parent%\SMC*
    echo Start executing ipmi raw 30 40
    SMCIPMITOOL.exe %ip% ADMIN %Uniqpwd% ipmi raw 30 40
    timeout 180
    echo Start executing ipmi raw 30 41
    SMCIPMITOOL.exe %ip% ADMIN %Uniqpwd% ipmi raw 30 41
    timeout 180
    echo Start executing ipmi raw 30 42
    SMCIPMITOOL.exe %ip% ADMIN %Uniqpwd% ipmi raw 30 42
    timeout 180
    echo Start executing ipmi raw 30 48 0
    SMCIPMITOOL.exe %ip% ADMIN %Uniqpwd% ipmi raw 30 48 0
    timeout 180
    echo Start executing ipmi raw 30 48 1
    SMCIPMITOOL.exe %ip% ADMIN %Uniqpwd% ipmi raw 30 48 1
    timeout 180
    echo Start executing FD 1
    SMCIPMITOOL.exe %ip% ADMIN %pwd% ipmi fd 1
    timeout 180
    echo Start executing FD 2
    SMCIPMITOOL.exe %ip% ADMIN %Uniqpwd% ipmi fd 2
    timeout 180
    echo Start executing FD 3
    SMCIPMITOOL.exe %ip% ADMIN %Uniqpwd% ipmi fd 3
    cd /d D:\Script
) else (
    echo SMCIPMITool folder doesn't exist
    echo SMC Parent Path=%SMC_Parent%
    cd /d D:\Script
    goto :eof
)

@REM 寫個方法查詢ping結果

:eof 