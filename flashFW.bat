@echo off
set /p ip= "ip: "

echo "If you don't want to update specific FW, please type n"
set /p bmcfile="Plz drag BMC FW file or type (n) "
set /p biosfile="Plz drag BIOS FW file or type (n) "
set /p Checkuni= "Login via Unique Password? (y/n)"

if /i %Checkuni%==y (
    set /p pwd= "Unique Password: "
) else (
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


REM 用ip查看SUT機種 也可以檢查是否要用Unique Password
set SubMask=255.255.255.255
cd /d C:\
cd C:\Users\Stephenhuang\SMC*
SMCIPMITOOL.exe %ip% ADMIN %pwd% find %ip% %ip% %SubMask% > Find_SUT.txt

set SUT=X13 H13 X12 H12 X11 X10

for %%i in (%SUT%) do (
    find "%%i" Find_SUT.txt > nul
    if %errorlevel% equ 0 (
        echo %%i is found
    )
)
del Find_SUT.txt

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