chcp 65001
@echo off
set /p ip="ip: "
set /p Checkuni= "Need Unique Password? (y/n) "
if /i %Checkuni%==y (
    set /p pwd= "Unique Password: "
) else (
    set pwd=ADMIN
)
echo %ip%
echo %pwd%
cd /d C:\
cd C:\Users\Stephenhuang\sum*

if exist Dmi.txt (
    echo delete file
    del Dmi.txt
    ) else (
    echo File doesn't exist
    )

sum.exe -i %ip% -u ADMIN -p %pwd% -c getdmiinfo --file Dmi.txt
echo 記事本關閉Command才會關閉
Dmi.txt

