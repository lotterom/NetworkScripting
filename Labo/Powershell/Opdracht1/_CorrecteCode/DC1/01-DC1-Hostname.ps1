$new_hostname="win09-DC1"

Rename-Computer -NewName $new_hostname -DomainCredential intranet\administrator -Restart

# Bron:
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/rename-computer?view=powershell-7.2