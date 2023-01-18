chcp 65001
set ip=10.184.30.32
set pwd=ADMIN
cd C:\Users\Stephenhuang\sum_2.9.0_Win_x86_64

if EXIST Dmi.txt (
    echo delete file
    del Dmi.txt
    ) else (
    echo File doesn't exist
    )

sum.exe -i %ip% -u ADMIN -p %pwd% -c getdmiinfo --file Dmi.txt
echo 記事本關閉Command才會跑完
Dmi.txt


