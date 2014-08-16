echo -------- >>C:\Users\vagrant\debug.log
date /t >>C:\Users\vagrant\debug.log
time /t >>C:\Users\vagrant\debug.log

if "%COMPUTERNAME:~0,8%"=="VAGRANT-" (
  echo COMPUTERNAME = %COMPUTERNAME% - do nothing >> C:\Users\vagrant\debug.log
) else (
  echo COMPUTERNAME = %COMPUTERNAME% - enable WinRM >> C:\Users\vagrant\debug.log
  netsh advfirewall firewall delete rule name="vagrant-vcloud-winrm" >> C:\Users\vagrant\debug.log
)
