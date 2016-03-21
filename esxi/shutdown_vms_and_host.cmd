@echo Off
@setlocal
set server=192.168.1.23
set username=root
set password=Passw0rd!
set TXT_LOG=c:\temp\logapagado.txt
pushd "c:\Program Files (x86)\VMware\VMware vSphere CLI\bin"

:: Para ver un listado del los WorldID de un host usar el siguiente comando
::esxcli --server %server% --username %username% --password %password% vm process list

:: Inicio secuencia apagado
@echo --------------------------------------------------------------  >>  %TXT_LOG%
@echo --------------------------------------------------------------  >>  %TXT_LOG%
@echo --------------------------------------------------------------  >>  %TXT_LOG%
@echo %date% %time% Inicio secuencia apagado ---- en %server%  >>  %TXT_LOG%
@echo --------------------------------------------------------------  >>  %TXT_LOG%

esxcli --server %server% --username %username% --password %password% vm process list | findstr /m "World" > c:\temp\worlid.txt
type %TXT_LOG% > c:\temp\worlid.txt

for /F "tokens=1,2,3" %%i in (c:\temp\worlid.txt) do call :process %%i %%j %%k


:process
set VAR1=%1
set VAR2=%2
set WorldID=%3
::COMMANDS TO PROCESS INFORMATION
@echo %date% %time% Apagando: - World ID: %WorldID% ---- en %server% >> %TXT_LOG%
@echo esxcli --server %server% --username %username% --password %password% vm process kill --type=soft --world-id=%WorldID%
:: @notepad %TXT_LOG%
goto :FIN

:FIN
popd