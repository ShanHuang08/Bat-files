@echo off
set /p ip= "ip: "

echo "If you don't want to update specific FW, please type n"
set /p bmcfile="Plz drag BMC FW file or type (n) "
set /p biosfile="Plz drag BIOS FW file or type (n) "
set /p Checkuni= "Need Unique Password? (y/n)"

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

@REM For test
@REM echo %bmcfile%
@REM echo %biosfile%

pause