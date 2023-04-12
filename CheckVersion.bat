@echo off
set /p ip="ip: "
set /p Checkuni="Need Unique Password? (y/n) "
if /i %Checkuni%==y (
    set /p pwd="Unique Password: "
) else (
    set pwd=ADMIN
)

@REM echo %ip%
@REM echo %pwd%
cd /d C:\
cd C:\Users\Stephenhuang\sum*
sum.exe -i %ip% -u ADMIN -p %pwd% -c getbiosinfo --showall
sum.exe -i %ip% -u ADMIN -p %pwd% -c getbmcinfo
sum.exe -i %ip% -u ADMIN -p %pwd% -c getcpldinfo

cd C:\Users\Stephenhuang
cd SMCIPMITool*
echo Redfish version: 
SMCIPMITool.exe %ip% ADMIN %pwd% redfish version
pause

@REM checkassetinfo
@REM getnvmeinfo
@REM getpsuinfo
@REM getaocnicinfo
