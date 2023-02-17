@echo off
set /p ip= "ip: "
set pwd=ADMIN
cd /d C:\
cd C:\Users\Stephenhuang\sum*
sum.exe -i %ip% -u ADMIN -p %pwd% -c getbiosinfo --showall
sum.exe -i %ip% -u ADMIN -p %pwd% -c getbmcinfo
sum.exe -i %ip% -u ADMIN -p %pwd% -c getcpldinfo
pause

@REM checkassetinfo
@REM getnvmeinfo
@REM getpsuinfo
@REM getaocnicinfo
