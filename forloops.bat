@REM chcp 65001
@REM FOR %variable IN (set) DO 命令 [command-parameters]

@REM   %variable  指定一個可以取代的參數。
@REM   (set)      指定由一或多個檔案組成的檔案組。您可使用通配字元。
@REM   command    指定命令來執行每一個檔案。
@REM   command-parameters
@REM              為所指定的命令指定變數或參數。

@REM FOR /F ["options"] %variable IN (file-set) DO command [command-parameters]
@REM FOR /F ["options"] %variable IN ("string") DO command [command-parameters]
@REM FOR /F ["options"] %variable IN ('command') DO command [command-parameters]


for /f %%i in ("Thisis a test.") do (
    echo %%i
)
echo %%i
for /f %%j in ("Hello World!") do echo %%j

for %%k in (*.exe) do set var=%%k
echo %var%


