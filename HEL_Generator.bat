@echo off
set SMC_Parent=C:\Users\Stephenhuang
set /p ip= "BMC ip: "

set /p Checkuni= "Login via Unique Password (y/n) "
if /i %Checkuni%==y (
    set /p pwd="Input Unique Password: "
) else (
    set pwd=ADMIN
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
    echo Start generating HEL
    cd %SMC_Parent%\SMC*
    SMCIPMITOOL.exe %ip% ADMIN %pwd% ipmi raw 0a 44 10 00 02 00 00 00 00 20 00 04 07 01 02 01 ff ff
    SMCIPMITOOL.exe %ip% ADMIN %pwd% ipmi raw 4 2 4 1 1 1 0 ff ff
    SMCIPMITOOL.exe %ip% ADMIN %pwd% ipmi raw 4 2 4 2 24 1 4 ff ff
    SMCIPMITOOL.exe %ip% ADMIN %pwd% ipmi raw 4 2 4 5 aa 8 0 ff ff
    SMCIPMITOOL.exe %ip% ADMIN %pwd% ipmi raw 4 2 4 7 1 6f 1 ff ff
    @REM CATERR error
    SMCIPMITOOL.exe %ip% ADMIN %pwd% ipmi raw 4 2 4 7 1 6f 0 ff ff
    SMCIPMITOOL.exe %ip% ADMIN %pwd% ipmi raw 4 2 4 7 1 ef 0 ff ff
    cd /d D:\Script
) else (
    echo SMCIPMITool folder doesn't exist
    echo SMC Parent Path=%SMC_Parent%
    cd /d D:\Script
    goto :eof
)


:eof 
