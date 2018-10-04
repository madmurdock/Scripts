@echo off
setlocal

set sqlbackupdir=D:\APM\Backup\
set SOURCEDIR=C:\src\Bentley\APM
set DATADIR=C:\Users\Rob.Prouse\

if "" == "%1" goto usage
if "" == "%2" goto usage

@echo Restoring the database backup %1
sqlcmd -S "(localdb)\MSSQLLocalDB" -d master -E -Q "DROP DATABASE %1_snap"
sqlcmd -S "(localdb)\MSSQLLocalDB" -d master -E -Q "RESTORE DATABASE [%1] FROM  DISK = N'%2' WITH  FILE = 1,  MOVE N'ivara_data' TO N'%DATADIR%\%1.mdf',  MOVE N'ivara_log' TO N'%DATADIR%\%1.ldf',  NOUNLOAD,  REPLACE,  STATS = 10"
sqlcmd -S "(localdb)\MSSQLLocalDB" -d "%1" -E -i "%SOURCEDIR%\dbscripts\app\sqlserver\init_ivara.sql"
sqlcmd -S "(localdb)\MSSQLLocalDB" -E -Q "create database [%1_snap] on ( name=N'Ivara_data', filename=N'%DATADIR%%1_snap.ss' ) as snapshot of %1%"
sqlcmd -S "(localdb)\MSSQLLocalDB" -d "%1" -E -Q "UPDATE oq.ouser SET APMSERVERMAN=1, PRIVILEGE=1 WHERE LOGINNAME='Rob.Prouse'"
goto end

:usage
@echo usage: %0 dbname backupfilename
goto end

:nofile
echo Unable to locate file %2
:end
