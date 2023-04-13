@echo off
set /p ip= "ip: "

echo "If you don't want to update specific FW, please type n"
set /p bmcfile="Plz drag BMC FW file or type (n) "
set /p biosfile="Plz drag BIOS FW file or type (n) "
set /p Checkuni= "Need Unique Password? (y/n)"

REM 檢查IP是否有效
ping %ip% > ping_result.txt
find "TTL=" ping_result.txt > nul
if not %errorlevel% equ 0 (
    echo %ip% is ivalid ip
    del ping_result.txt
    pause
    goto :eof REM 跳到腳本末尾，終止腳本的執行
)
del ping_result.txt

cd /d C:\
cd C:\Users\Stephenhuang\sum*

if /i %Checkuni%==y (
    set /p pwd= "Unique Password: "
) else (
    set pwd=ADMIN
)

if /i %bmcfile%==n (
    echo "Skip BMC update"
) else if /i %bmcfile%==m (
    echo "Skip BMC update"
) else if /i %bmcfile%==b (
    echo "Skip BMC update"
) else (
    echo "Updating BMC firmware"
    sum.exe -i %ip% -u ADMIN -p %pwd% -c Updatebmc --file %bmcfile% --overwrite_cfg --overwrite_sdr --overwrite_ssl --backup
)

if /i %biosfile%==n (
    echo "Skip BIOS update"
) else if /i %biosfile%==m (
    echo "Skip BIOS update"
) else if /i %biosfile%==b (
    echo "Skip BIOS update"
) else (
    echo "Updating BIOS firmware"
    sum.exe -i %ip% -u ADMIN -p %pwd% -c Updatebios --file %biosfile% --preserve_setting --reboot
)

pause