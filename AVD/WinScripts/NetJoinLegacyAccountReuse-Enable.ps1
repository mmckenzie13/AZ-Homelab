# October 2022 Update KB5020276 Blocks Powershell Account Reuse for Imaging. Adding this Registry Key bypasses the issue. 
Reg add HKLM\System\CurrentControlSet\Control\Lsa /v NetJoinLegacyAccountReuse /t REG_DWORD /d 1 /f
