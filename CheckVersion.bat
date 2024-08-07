@echo off
echo Please check your SMCIPMITool and sum parent folder path are correct before executing this file.
echo Incorrect folder path will result failed execution with error message.
echo --------------------------------------------------------------------------

set FolderPath=C:\Users\Stephenhuang\Downloads
set SMC_Parent=C:\Users\Stephenhuang
set sum_Parent=C:\Users\Stephenhuang
set /p ip="BMC ip: "
set /p Checkuni="Need Unique Password? (y/n) "
if /i %Checkuni%==y (
    set /p pwd="Unique Password: "
) else (
    set pwd=ADMIN
)

REM 檢查IP是否有效
ping %ip% > ping_result.txt
find "TTL=" ping_result.txt > nul
if %errorlevel% equ 0 (
    echo %ip% is valid ip
    del ping_result.txt
) else (
    echo %ip% is invalid ip
    del ping_result.txt
    pause
    goto :eof 
)

rem 檢查資料夾

echo %SMC_Parent% | findstr /C:"C:" > nul
if %errorlevel% equ 0 (
    cd /d C:\
) else (
    cd /d D:\
)
cd %SMC_Parent%
if exist %SMC_Parent%\SMC* (
    rem do nothing
) else (
    echo SMCIPMITool folder doesn't exist
    echo SMC Parent Path=%SMC_Parent%
    pause
    goto :eof
)

echo %sum_Parent% | findstr /C:"C:" > nul
if %errorlevel% equ 0 (
    cd /d C:\
) else (
    cd /d D:\
)
cd %sum_Parent%
if exist %sum_Parent%\sum* (
    rem do nothing
) else (
    echo sum folder doesn't exist
    echo sum Parent Path=%sum_Parent%
    pause
    goto :eof
)

REM 檢查是否要用Unique Password
echo %SMC_Parent% | findstr /C:"C:" > nul
if %errorlevel% equ 0 (
    cd /d C:\
) else (
    cd /d D:\
)
cd %SMC_Parent%\SMC*
SMCIPMITOOL.exe %ip% ADMIN %pwd% user list 2 > Login_Message.txt 
find "Can't login to" Login_Message.txt > nul
if not %errorlevel% equ 0 (
    del Login_Message.txt 
) else (
    echo Use %pwd% login failed
    if /i %Checkuni%==n (
        set /p pwd="Input Unique Password: "
        pause
    ) else (
        set pwd=ADMIN
    )
    del Login_Message.txt
)


set filename=%ip%_CheckVersion.txt

echo %sum_Parent% | findstr /C:"C:" > nul
if %errorlevel% equ 0 (
    cd /d C:\
) else (
    cd /d D:\
)
cd %SMC_Parent%\SMCIPMITool*
echo Firmware info >> %FolderPath%\%filename%
echo -------------------------------------------------------------------------------- >> %FolderPath%\%filename%
SMCIPMITool.exe %ip% ADMIN %pwd% redfish firmwareInventory info >> %FolderPath%\%filename%
echo Get CPLD and On-demand results from raw: >> %FolderPath%\%filename%
echo "ipmi raw 30 68 28 3, CPLD version should reverse" >> %FolderPath%\%filename%
SMCIPMITool.exe %ip% ADMIN %pwd% ipmi raw 30 68 28 3 >> %FolderPath%\%filename%
echo "ipmi raw 30 68 29 3, CPLD version should reverse" >> %FolderPath%\%filename%
SMCIPMITool.exe %ip% ADMIN %pwd% ipmi raw 30 68 29 3 >> %FolderPath%\%filename%
echo "ipmi raw 30 68 E3 00 01 should responds 00 (Only for intel On-demand)" >> %FolderPath%\%filename%
SMCIPMITool.exe %ip% ADMIN %pwd% ipmi raw 30 68 E3 00 01 >> %FolderPath%\%filename%
echo "ipmi raw 30 68 E3 00 02 should responds 00 (Only for intel On-demand)" >> %FolderPath%\%filename%
SMCIPMITool.exe %ip% ADMIN %pwd% ipmi raw 30 68 E3 00 02 >> %FolderPath%\%filename%
echo "https://wiki.supermicro.com/index.php/NS_SWPM:SW_PM/IPMI/0x30_0x68_0xE3" >> %FolderPath%\%filename%
echo " " >> %FolderPath%\%filename%

cd %sum_Parent%\sum*
echo BIOS info >> %FolderPath%\%filename%
echo -------------------------------------------------------------------------------- >> %FolderPath%\%filename%
sum.exe -i %ip% -u ADMIN -p %pwd% -c getbiosinfo --showall >> %FolderPath%\%filename%
echo BMC info >> %FolderPath%\%filename%
echo -------------------------------------------------------------------------------- >> %FolderPath%\%filename%
sum.exe -i %ip% -u ADMIN -p %pwd% -c getbmcinfo >> %FolderPath%\%filename%
echo CPLD info >> %FolderPath%\%filename%
echo -------------------------------------------------------------------------------- >> %FolderPath%\%filename%
sum.exe -i %ip% -u ADMIN -p %pwd% -c getcpldinfo >> %FolderPath%\%filename%
echo DMI info >> %FolderPath%\%filename%
echo -------------------------------------------------------------------------------- >> %FolderPath%\%filename%
sum.exe -i %ip% -u ADMIN -p %pwd% -c getdmiinfo >> %FolderPath%\%filename%

echo %SMC_Parent% | findstr /C:"C:" > nul
if %errorlevel% equ 0 (
    cd /d C:\
) else (
    cd /d D:\
)
cd %SMC_Parent%\SMCIPMITool*
echo Redfish version: >> %FolderPath%\%filename%
SMCIPMITool.exe %ip% ADMIN %pwd% redfish version >> %FolderPath%\%filename%


start %FolderPath%
start %FolderPath%\%filename%

cd /d D:\Script

@REM checkassetinfo
@REM getnvmeinfo
@REM getpsuinfo
@REM getaocnicinfo
