@echo off
setlocal enabledelayedexpansion
cd /d D:\
cd Script
set SUT_Type=X13 H13 X12 H12 X11 X10
set file=Find_SUT.txt
set SUT=

for %%i in (%SUT_Type%) do (
    find "%%i" Find_SUT.txt > nul
    if !errorlevel! equ 0 (
        set SUT=%%i
        echo SUT is %%i
    )
)
if %SUT%=="X12" (
    goto x
) else if %SUT%=="X13" (
    goto y
)
endlocal



:x
echo "gotoX12 flash commands"
pause
exit

:y
echo "gotoX13 flash commaneds"
pause
exit

@REM find "X13" Find_SUT.txt > nul
@REM echo %errorlevel%

@REM 請注意，使用 enabledelayedexpansion 時需要使用 ! 符號來展開變數，而不再使用 % 符號。


@REM TXT TEST
@REM Finding IPMI Devices ...
@REM   10.184.30.32         	 IPMI 2.0 ASPD_T IPMI+KVM     
@REM Found hosts loaded
@REM 1 IPMI device(s) found. Use "found" to list found devices

@REM Devices type
@REM X13: X13 AST2600RoT
@REM H13: H13RoT
@REM X12: X12 AST2500,X12 AST2600RoT, X12 AST2600NonRoT
@REM H12: H12RoT
@REM X11: AST2500
@REM H11: H11
@REM X10: IPMI 2.0 ASPD_T IPMI+KVM

@REM Not Found: No IPMI Device found!