@echo off
if %1.==. goto invalid
if %1==help goto help
if %1==start goto start
if %1==open goto open
if %1==show goto show
if %1==assigned goto assigned
if %1==hockeyapp goto hockeyapp

:start
if %2.==. goto invalid
set id=%2
echo Setting work item %id% to in-progress
vsts work item update --state "In Progress" --id %id%
goto end

:open
if %2.==. goto invalid
set id=%2
echo Opening work item %id%
vsts work item show --open --id %id%
goto end

:show
if %2.==. goto invalid
set id=%2
echo Showing work item %id%
vsts work item show --output jsonc --id %id%
goto end

:assigned
echo Work Items assigned to me
vsts work item query --id c76aebae-b24e-4c50-b815-408c5c67d77e

:hockeyapp
echo Latest HockeyApp Issues
vsts work item query --id 14a5d8cc-3c22-4fc6-a71e-20c0f8942d9c

:invalid
echo Invalid command
echo.

:help
echo Work with VSTS Work Items
echo.
echo Options:
echo   help      - Show this help
echo   start id  - Start work on a work item by marking it in-progress
echo   open id   - Opens a work item in the browser
echo   show id   - Shows a work item as JSON
echo   assigned  - Shows work items assigned to me
echo   hockeyapp - Shows incoming HockeyApp issues

:end