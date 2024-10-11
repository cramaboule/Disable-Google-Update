::Disable Google Update on all server
@echo off

if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
cd %~dp0

SET ListServer=C:\path\to\Serveurs-list.txt

echo %DATE% %TIME% > GUpdate.log

SETLOCAL ENABLEDELAYEDEXPANSION

for /f "tokens=*" %%a in (%ListServer%) do (
	echo %%a | tee GUpdate.log
	sc \\%%a query state=all | findstr /I /R /C:"^SERVICE_NAME: Googleu.*" > GUpdate.txt
	FOR /F "tokens=1,2" %%G IN (GUpdate.txt) DO (
	  echo %%H | tee GUpdate.log
	  SC \\%%a config %%H start= disabled | tee GUpdate.log
	  SC \\%%a DELETE %%H | tee GUpdate.log
	)
	sc \\%%a query state=all | findstr /I /R /C:"^SERVICE_NAME: GUpdate" > GUpdate.txt
	FOR /F "tokens=1,2" %%G IN (GUpdate.txt) DO (
	  echo %%H | tee GUpdate.log
	  SC \\%%a config %%H start= disabled | tee GUpdate.log
	  SC \\%%a DELETE %%H | tee GUpdate.log
	)
)
