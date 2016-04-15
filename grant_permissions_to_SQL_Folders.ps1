######################################################################################################################
#
# This script is meant for AD Domain Member servers only and runs remotely.
# It grants the DOMAINNAME\DOMAINGROUP AD Security Group Full Access to C:\*FOLDERNAME* if it exists.
# "servers.txt" must exist with a list of server hostnames.
# Created by Steve Tractenberg September 2015
#
######################################################################################################################

foreach ($srvr in Get-Content "C:\Users\stractenberg\Desktop\scripts\servers.txt")
{
$AccountName="*DOMAINGROUP*"
$DomainName="*DOMAINNAME*"
$Right="FullControl"
$Inheritperm="ContainerInherit, ObjectInherit"
$Principal="$DomainName\$AccountName"
$Permission =$Principal,$Right,$Inheritperm,"None","Allow"
$AccessRule=New-Object System.Security.AccessControl.FileSystemAccessRule($Permission)

$UNCPath="\\$srvr\c$\*FOLDERNAME"
$ACL = Get-Acl $UNCPath
$ACL.SetAccessRule($AccessRule)
Set-Acl $UNCPath -AclObject $ACL
write-host "Access granted for" $srvr $UNCPath -ForegroundColor green
}