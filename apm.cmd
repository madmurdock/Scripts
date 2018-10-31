@echo off
setlocal

set CacheDir=C:\src\Bentley\APM\bin
set DestDir=D:\Apm\backup
set BuildDir=\\torprdfs01\Product\Builds\7.12.0
set /p CurrentLocal=<%DestDir%\Current.txt
set /p Current=<%BuildDir%\Current.txt
set CurrentDir=%BuildDir%\%Current%

if %1.==. goto invalid
if %1==help goto help
if %1==current goto current
if %1==get goto get
if %1==restore goto restore
goto invalid

:current
echo APM build:  %Current%
echo Downloaded: %CurrentLocal%
goto end

:get
echo Fetching from %CurrentDir%
echo Copying Current.txt
copy %BuildDir%\Current.txt %DestDir%
echo Copying cache.7z
copy %CurrentDir%\cache.7z %DestDir%
echo Copying IvaraApplicationTestingLocal-%Current%.bak
copy %CurrentDir%\IvaraApplicationTestingLocal-%Current%.bak %DestDir%\IvaraApplicationTestingLocal.bak
echo Copying QA_BASE_TESTSUITESLocal-%Current%.bak
copy %CurrentDir%\QA_BASE_TESTSUITESLocal-%Current%.bak %DestDir%\QA_BASE_TESTSUITESLocal.bak
goto end

:restore
if %2.==. goto restorecache
if %2==all goto restorecache
if %2==cache goto restorecache
if %2==apptest goto restoreapptesting
if %2==qabase goto restoreqabase
if %2==localdb goto restorelocaldb
goto invalid

:restorecache
set PATH=%PATH%;"C:\Program Files\7-Zip"
echo Deleting old cache files from %CacheDir%\cache
del %CacheDir%\cache /s /q
echo Unzipping Cache from %DestDir%\cache.7z to %CacheDir%
7z x -y %DestDir%\cache.7z -o%CacheDir%
popd
if %2.==. goto restoreapptesting
if %2==all goto restoreapptesting
goto end

:restoreapptesting
echo Restoring IvaraApplicationTestingLocal.bak v%Current%
call %~dp0restoredb IvaraApplicationTestingLocal %DestDir%\IvaraApplicationTestingLocal.bak
if %2.==. goto restoreqabase
if %2==all goto restoreqabase
goto end

:restoreqabase
echo Restoring QA_BASE_TESTSUITESLocal.bak v%Current%
call %~dp0restoredb QA_Base %DestDir%\QA_BASE_TESTSUITESLocal.bak
goto end

:restorelocaldb
echo Restoring IvaraApplicationTestingLocal.bak v%Current% to LocalDB
call %~dp0restorelocaldb IvaraApplicationTestingLocal %DestDir%\IvaraApplicationTestingLocal.bak
echo Restoring QA_BASE_TESTSUITESLocal.bak v%Current% to LocalDB
call %~dp0restorelocaldb QA_Base %DestDir%\QA_BASE_TESTSUITESLocal.bak
goto end

:invalid
echo Invalid command
echo.

:help
echo Update my APM Development Environment
echo.
echo Options:
echo   help                    - Show this help
echo   current                 - Show the version of the latest APM build
echo   get                     - Copies the current cache and dbs locally
echo   restore                 - Unzips the cache and restores all dbs
echo   restore all             - Unzips the cache and restores all dbs
echo   restore cache           - Unzips the cache
echo   restore apptest         - Restores the app testing db
echo   restore qabase          - Restores the qa_base db
echo   restore localdb         - Restores all dbs to localDB

:end