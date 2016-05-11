$InstanceId = (Invoke-RestMethod 'http://169.254.169.254/latest/meta-data/instance-id').ToString()
$AvailabilityZone = (Invoke-RestMethod 'http://169.254.169.254/latest/meta-data/placement/availability-zone').ToString()
$Region = $AvailabilityZone.Substring(0,$AvailabilityZone.Length-1)
$Tags = Get-EC2Tag -Filters @{Name='resource-id';Value=$InstanceId}  -Region $Region -AccessKey XXXXXXXXXXXXXX -SecretKey XXXXXXXXXXXXXXXXXXXXX
$InstanceName = ($Tags | Where-Object {$_.Key -eq 'Name'}).Value
Rename-Computer -NewName $InstanceName -Force