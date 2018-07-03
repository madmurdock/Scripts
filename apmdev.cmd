@echo off

set DestDir=D:\Apm\backup\
set BuildDir=\\torprdfs01\Product\Builds\7.11.0\
set /p Current=<%BuildDir%Current.txt
set CurrentDir=%BuildDir%%Current%\

if %1.==. goto invalid
if %1==help goto help
if %1==getcache goto getcache
if %1==getapptesting goto getapptesting
if %1==getqabase goto getqabase
if %1==getall goto getall

:getcache
echo Fetching cache from %CurrentDir%
copy /Y %CurrentDir%\cache.7z %DestDir%
goto end

:getapptesting
echo Fetching IvaraApplicationTesting from %CurrentDir%
copy /Y %CurrentDir%\IvaraApplicationTestingLocal-%Current%.bak %DestDir%
goto end

:getqabase
echo Fetching QA_Base from %CurrentDir%
copy /Y %CurrentDir%\QA_BASE_TESTSUITESLocal-%Current%.bak %DestDir%
goto end

:getall
echo Fetching from %CurrentDir%
copy /Y %CurrentDir%\cache.7z %DestDir%
copy /Y %CurrentDir%\IvaraApplicationTestingLocal-%Current%.bak %DestDir%
copy /Y %CurrentDir%\QA_BASE_TESTSUITESLocal-%Current%.bak %DestDir%
goto end

:invalid
echo Invalid command
echo.

:help
echo Update my APM Development Environment
echo.
echo Options:
echo   help          - Show this help
echo   getcache      - Copies the current cache locally
echo   getapptesting - Copies the current app testing db locally
echo   getqabase     - Copies the current qa_base db locally

:end