######################################################################################################################
# 
# This script imports server IPs and local administrator passwords provided in array-data.txt formatted as "ip,password"
# and connects to them in order to create a local admin account for Solar Winds Patch Manager purposes. You must enter
# the password below in cleartext before running.
# Created by Steve Tractenberg February 2016
#
######################################################################################################################

$userdata = Import-Csv C:\Users\stractenberg\Desktop\scripts\array-data.txt

ForEach ($i in $userdata)
{
$user = "administrator"

$computer = $i.ip

$cred2 = "$computer" + "\" + "$user"

$passwd = convertto-securestring -AsPlainText -Force -String $i.password

$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $cred2,$passwd

echo $computer

$s = new-pssession -computername $computer -credential $cred

invoke-command -session $s -scriptblock {
$cn = [ADSI]"WinNT://localhost"
$user = $cn.Create("User","**PUT_NEW_ADMIN_ACCOUNT_NAME_HERE**")
$user.SetPassword("**PUT_PASSWORD_HERE**")
$user.setinfo()
$user.description = "Local admin account for ..."
$User.UserFlags = 65536
$user.SetInfo()

$server = Get-WMIObject Win32_ComputerSystem | Select-Object -ExpandProperty name
$group = [ADSI]"WinNT://$server/Administrators,group"
$group.Add("WinNT://$server/**PUT_NEW_ADMIN_ACCOUNT_NAME_HERE**,user")

}

Remove-PSSession $s

}