@echo off & setlocal enabledelayedexpansion
chcp 65001
for /f "tokens=1 delims=[]" %%i in ('nbtstat -S^| find /n "乙太網路:"') do (
nbtstat -S | more +%%i >$
set /p Str=<$
del $
for /f "tokens=2 delims=[]" %%i in ('echo "!Str!"') do set LIP=%%i
)

for /f "tokens=16" %%i in ('ipconfig /all ^| find /i "IPv4 Address"') do set ip=%%i
echo 本機使用者名稱為: %COMPUTERNAME%

echo 本機有線IP為：%LIP%
echo %ip%

for /f "tokens=1,3 delims=," %%i in ('getmac /v /nh /fo:csv ^| findstr
"..-..-..-..-..-.."') do (
echo %%i %%j
)

pause
