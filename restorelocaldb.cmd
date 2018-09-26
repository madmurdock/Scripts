@echo off
setlocal

set sqlbackupdir=D:\APM\Backup\
set SOURCEDIR=C:\src\Bentley\APM
set DATADIR=C:\Users\Rob.Prouse\

if "" == "%1" goto usage
if "" == "%2" goto usage

@echo Restoring the database backup %1
rem sqlcmd -S "(localdb)\MSSQLLocalDB" -d master -E -Q "DROP DATABASE %1_snap"
rem sqlcmd -S "(localdb)\MSSQLLocalDB" -d master -E -Q "ALTER DATABASE [%1] SET SINGLE_USER WITH ROLLBACK IMMEDIATE"
sqlcmd -S "(localdb)\MSSQLLocalDB" -d master -E -Q "RESTORE DATABASE [%1] FROM  DISK = N'%2' WITH  FILE = 1,  MOVE N'ivara_data' TO N'%DATADIR%\%1.mdf',  MOVE N'ivara_log' TO N'%DATADIR%\%1.ldf',  NOUNLOAD,  REPLACE,  STATS = 10"
rem sqlcmd -S "(localdb)\MSSQLLocalDB" -d master -E -Q "ALTER DATABASE [%1] SET MULTI_USER"
sqlcmd -S "(localdb)\MSSQLLocalDB" -d "%1" -E -i "%SOURCEDIR%\dbscripts\app\sqlserver\init_ivara.sql"
goto end

:usage
@echo usage: %0 dbname backupfilename
goto end

:nofile
echo Unable to locate file %2
:end
