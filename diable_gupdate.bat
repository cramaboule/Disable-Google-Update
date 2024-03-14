::Disable Google Update on all server

@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

for /f "tokens=*" %%a in (C:\path\to\Serveurs-list.txt) do (
	echo %%a
	sc \\%%a query state=all | findstr /I /R /C:"^SERVICE_NAME: Googleu.*" > GUpdate.txt
	SET count=1
	FOR /F "tokens=1,2" %%G IN (GUpdate.txt) DO (
	  echo %%H
	  SC \\%%a config %%H start= disabled
	)


)
