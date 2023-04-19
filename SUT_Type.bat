@echo off
setlocal enabledelayedexpansion

set SUT_Type=X13 H13 X12 H12 H11 AST2500 AST2600 ASPD
set file=Find_SUT.txt
set SUT=

for %%i in (%SUT_Type%) do (
    find "%%i" Find_SUT.txt > nul
    if !errorlevel! equ 0 (
        set SUT=%%i
        if not %%i equ ASPD (
            echo SUT is %%i
        )
        if %%i equ ASPD (
            echo SUT is X10 
        )
    )
)  

if not %SUT% equ ASPD (
    goto :AboveX10
) else (
    goto :X10
)
endlocal



:AboveX10
echo "Put flash commands for the NEW version"
pause
exit

:X10
echo "Put X10 flash commands"
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