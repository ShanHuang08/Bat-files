
set /p ip= "ip: "

echo "If you don't want to update specific FW, please type n"
set /p bmcfile="Plz drag BMC FW file or type (n) "
set /p biosfile="Plz drag BIOS FW file or type (n) "
set /p Checkuni= "Input Unique Password (y/n)"

if /i %Checkuni%==n (
    set pwd=ADMIN
)

REM 檢查IP是否有效
ping %ip% > ping_result.txt
find "TTL=" ping_result.txt > nul
if not %errorlevel% equ 0 (
    echo %ip% is ivalid ip
    del ping_result.txt
    pause
    goto :eof REM 跳到腳本末尾，終止腳本的執行
) else (
    echo %ip% is valid ip
    del ping_result.txt
)

REM 檢查是否要用Unique Password
cd /d C:\
cd C:\Users\Stephenhuang\SMC*

SMCIPMITOOL.exe %ip% ADMIN %pwd% user list 2 > Login_Message.txt 
find "Can't login to" Login_Message.txt > nul
if not %errorlevel% equ 0 (
    del Login_Message.txt 
) else (
    if /i %Checkuni%==n (
        set /p pwd="Input Unique Password: "
    )
    del Login_Message.txt
)

REM 檢查SUT是哪一代 接goto flash commands
setlocal enabledelayedexpansion
set SubMask=255.255.255.255
SMCIPMITOOL.exe %ip% ADMIN %pwd% find %ip% %ip% %SubMask% > Find_SUT.txt

set SUT_Type=X13 H13 X12 H12 X11 X10
set SUT=

for %%i in (%SUT_Type%) do (
    find "%%i" Find_SUT.txt > nul
    if !errorlevel! equ 0 (
        set SUT=%%i
        echo SUT is %%i
    )
)
echo SUT=%SUT%
if not %SUT% equ "ASPD" (
    goto AboveX10
) else (
    goto X10
)
del Find_SUT.txt
endlocal



REM X10 BIOS不支援 --preserve_setting, BMC不支援--backup

:AboveX10
echo "Put New flash commands"
pause
exit

:X10
echo "Put X10 flash commands"
pause
exit



cd C:\Users\Stephenhuang\sum*

if /i %bmcfile%==n (
    echo "Skip BMC update"
) else if /i %bmcfile%==nn (
    echo "Skip BMC update"
) else if /i %bmcfile%==m (
    echo "Skip BMC update"
) else (
    echo "Updating BMC firmware"
    sum.exe -i %ip% -u ADMIN -p %pwd% -c Updatebmc --file %bmcfile% --overwrite_cfg --overwrite_sdr --overwrite_ssl --backup
)

if /i %biosfile%==n (
    echo "Skip BIOS update"
) else if /i %biosfile%==nn (
    echo "Skip BIOS update"
) else if /i %biosfile%==m (
    echo "Skip BIOS update"
) else (
    echo "Updating BIOS firmware"
    sum.exe -i %ip% -u ADMIN -p %pwd% -c Updatebios --file %biosfile% --preserve_setting --reboot
)

pause