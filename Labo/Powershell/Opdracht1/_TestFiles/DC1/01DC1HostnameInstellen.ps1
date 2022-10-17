# ====================
# ======hostname======
# ====================
$current_hostname=hostname
$new_hostname="win00-DC1"

Rename-Computer -Computername $current_hostname -NewName $new_hostname -Restart -Confirm:$false (confirm:$false) # is omdat hij niet nog eens extra zou vragen of je zeker bent
