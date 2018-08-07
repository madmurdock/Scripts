@echo off
setlocal

set CacheDir=C:\src\Bentley\APM\bin
set DestDir=D:\Apm\backup
set BuildDir=\\torprdfs01\Product\Builds\7.11.0
set /p Current=<%BuildDir%\Current.txt
set CurrentDir=%BuildDir%\%Current%

if %1.==. goto invalid
if %1==help goto help
if %1==current goto current
if %1==get goto get
if %1==unzip goto unzip
if %1==restore goto restore
goto invalid

:current
echo The current APM build is %Current%
goto end

:get
if %2.==. goto invalid
if %2==cache goto getcache
if %2==apptest goto getapptesting
if %2==qabase goto getqabase
if %2==all goto getall
goto invalid

:unzip
if %2.==. goto invalid
if %2==cache goto unzipcache
goto invalid

:restore
if %2.==. goto invalid
if %2==apptest goto restoreapptesting
if %2==qabase goto restoreqabase
goto invalid

:getcache
echo Fetching cache from %CurrentDir%
copy %CurrentDir%\cache.7z %DestDir%
goto end

:getapptesting
echo Fetching IvaraApplicationTesting from %CurrentDir%
copy %CurrentDir%\IvaraApplicationTestingLocal-%Current%.bak %DestDir%
goto end

:getqabase
echo Fetching QA_Base from %CurrentDir%
copy %CurrentDir%\QA_BASE_TESTSUITESLocal-%Current%.bak %DestDir%
goto end

:getall
echo Fetching from %CurrentDir%
copy %CurrentDir%\cache.7z %DestDir%
copy %CurrentDir%\IvaraApplicationTestingLocal-%Current%.bak %DestDir%
copy %CurrentDir%\QA_BASE_TESTSUITESLocal-%Current%.bak %DestDir%
goto end

:unzipcache
set PATH=%PATH%;"C:\Program Files\7-Zip"
echo Deleting old cache files from %CacheDir%\cache
del %CacheDir%\cache /s /q
echo Unzipping Cache from %DestDir%\cache.7z to %CacheDir%
7z x -y %DestDir%\cache.7z -o%CacheDir%
popd
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
echo   help            - Show this help
echo   current         - Show the version of the latest APM build
echo   get cache       - Copies the current cache locally
echo   get apptest     - Copies the current app testing db locally
echo   get qabase      - Copies the current qa_base db locally
echo   get all         - Copies the current cache and dbs locally
echo   unzip cache     - Unzips the cache
echo   restore apptest - Restores the app testing db
echo   restore qabase  - Restores the qa_base db

:end