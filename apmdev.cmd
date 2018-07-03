@echo off
setlocal

set DestDir=D:\Apm\backup
set BuildDir=\\torprdfs01\Product\Builds\7.11.0
set /p Current=<%BuildDir%\Current.txt
set CurrentDir=%BuildDir%\%Current%

if %1.==. goto invalid
if %1==help goto help
if %1==getcache goto getcache
if %1==getapptesting goto getapptesting
if %1==getqabase goto getqabase
if %1==getall goto getall
if %1==uzipcache goto unzipcache
if %1==restoreapptesting goto restoreapptesting
if %1==restoreqabase goto restoreqabase

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

:uzipcache
echo Unzipping Cache
rem
goto end

:restoreapptesting
echo Restoring IvaraApplicationTestingLocal-%Current%.bak
call %~dp0restoredb IvaraApplicationTestingLocal %DestDir%\IvaraApplicationTestingLocal-%Current%.bak
goto end

:restoreqabase
echo Restoring QA_BASE_TESTSUITESLocal-%Current%.bak
call %~dp0restoredb QA_Base %DestDir%\QA_BASE_TESTSUITESLocal-%Current%.bak
goto end


:invalid
echo Invalid command
echo.

:help
echo Update my APM Development Environment
echo.
echo Options:
echo   help              - Show this help
echo   getcache          - Copies the current cache locally
echo   getapptesting     - Copies the current app testing db locally
echo   getqabase         - Copies the current qa_base db locally
echo   getall            - Copies the current cache and dbs locally
echo   unzipcache        - Unzips the cache
echo   restoreapptesting - Restores the app testing db
echo   restoreqabase     - Restores the qa_base db

:end