@echo off
setlocal enabledelayedexpansion

set /p ip= "BMC ip: "

set "string=!ip:~0,3!"

if "!string!"=="10." (
    echo TW !string!
    set sec=5
)
if "!string!"=="172" (
    echo US !string!
    set sec=10
)

timeout !sec!