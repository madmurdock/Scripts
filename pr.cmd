@echo off
if %1.==. goto assigned
if %1==help goto help
if %1==open goto open
if %1==show goto show
if %1==assigned goto assigned
if %1==mine goto mine

:open
if %2.==. goto invalid
set id=%2
echo Opening PR %id%
vsts code pr show --open --id %id%
goto end

:show
if %2.==. goto invalid
set id=%2
echo Showing PR %id%
vsts code pr show --output jsonc --id %id%
goto end

:assigned
echo PRs assigned to me
vsts code pr list --reviewer rob.prouse

:mine
echo My PRs
vsts code pr list --creator rob.prouse

:invalid
echo Invalid command
echo.

:help
echo Work with VSTS Pull Requests
echo.
echo Options:
echo   help      - Show this help
echo   open id   - Opens a pull request in the browser
echo   show id   - Shows a pull request as JSON
echo   assigned  - Shows pull requests assigned to me
echo   mine      - Shows pull requests I created

:end