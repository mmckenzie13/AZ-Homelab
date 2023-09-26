# Disabling the bypass for October 2022 Update KB5020276
Reg delete HKLM\System\CurrentControlSet\Control\Lsa /v NetJoinLegacyAccountReuse /f
