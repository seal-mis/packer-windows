rem Disable-NetFirewallRule for WinRM for first boot in vCloud until guest customization
netsh advfirewall firewall add rule name="vagrant-vcloud-winrm" dir=in action=block protocol=TCP localport=5985

copy a:\enable-winrm-after-customization.bat C:\Users\vagrant\enable-winrm-after-customization.bat

reg import a:\enable-winrm-after-customization.reg
