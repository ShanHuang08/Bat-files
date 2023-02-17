chcp 65001
@echo off
set /p ip="ip: "
set pwd=ADMIN
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


