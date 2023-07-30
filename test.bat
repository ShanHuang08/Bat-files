@echo off
set ip=1.2.3.4

set cmd1="ipmi raw 30 40"
set cmd2="ipmi raw 30 41"
set cmd3="ipmi raw 30 42"
set cmd4="ipmi raw 30 48 0"
set cmd5="ipmi fd 1"
set cmd6="ipmi raw 30 48 1"
set cmd7="ipmi fd 2"
set cmd8="ipmi fd 3"
set Commands=%cmd1% %cmd2% %cmd3% %cmd4% %cmd5% %cmd6% %cmd7% %cmd8%

setlocal enabledelayedexpansion
for %%i in (%Commands%) do (
    set "command=%%i"
    if %%i neq "ipmi raw 30 40" if %%i neq "ipmi fd 2" (
        echo !command:~1,-1! is Not ADMIN 
        call :PingSUT
    ) else (
        echo !command:~1,-1! is ADMIN 
        call :PingSUT
    )
    if %%i equ "ipmi raw 30 40" (
        echo !command:~1,-1! is ADMIN 
        call :PingSUT
    )
    if %%i neq %cmd8% (
        timeout 10
    )
)
goto :eof

:PingSUT
ping -n 1 %ip% > ping_result.txt
find "TTL=" ping_result.txt > nul
if %errorlevel% equ 0 (
    echo PASS
    del ping_result.txt
) else (
    del ping_result.txt
    timeout 5
    call :PingAgain
)
goto :eof

:PingAgain
ping -n 1 %ip% > ping_result2.txt
find "TTL=" ping_result2.txt > nul
if %errorlevel% equ 0 (
    echo PASS
    del ping_result2.txt
) else (
    echo FAIL
    del ping_result2.txt
)

:eof 