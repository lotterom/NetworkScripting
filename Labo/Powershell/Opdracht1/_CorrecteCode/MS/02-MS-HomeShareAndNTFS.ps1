$PC_Name = "Win09-MS"

#Connecteren naar PS on DC2
$s = New-PSSession -ComputerName $PC_Name -Credential "INTRANET\Administrator" 

Invoke-Command -Session $s -ScriptBlock {

    $Share_Name = "Home"
    $Share_Path = "C:\$Share_Name"
       
    # Dir die we willen delen
    mkdir $Share_Path
    
    # Dir delen op netwerk en geef iedereen full control
    New-SmbShare -Name $Share_Name -path $Share_Path -FullAccess Everyone

    $acl = Get-ACL -Path $Share_Path

    # Disable inheritance
    $acl.SetAccessRuleProtection($True, $False)
    
    # IEdereen verwijderen van de map
    $acl.Access | %{$acl.RemoveAccessRule($_)}

    # Administrators full control
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("BUILTIN\Administrators","FullControl","Allow")
    $acl.SetAccessRule($AccessRule)

    # system full control
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("NT AUTHORITY\SYSTEM","FullControl","Allow")
    $acl.SetAccessRule($AccessRule)

    # authenticated Users ReadAndExecute rechten
    $AccessRule = new-object system.security.AccessControl.FileSystemAccessRule('Authenticated Users','ReadAndExecute','Allow')
    $acl.AddAccessRule($AccessRule)

    # uitvoeren
    Set-Acl -Path $Share_Path -AclObject $acl
}