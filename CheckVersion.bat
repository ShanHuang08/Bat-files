@echo off
set ip=10.184.30.32
set pwd=ADMIN
cd C:\Users\Stephenhuang\sum_2.9.0_Win_x86_64
sum.exe -i %ip% -u ADMIN -p %pwd% -c getbiosinfo --showall
sum.exe -i %ip% -u ADMIN -p %pwd% -c getbmcinfo
sum.exe -i %ip% -u ADMIN -p %pwd% -c getcpldinfo
pause