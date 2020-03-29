#Get-SqlDatabase -ServerInstance 'localhost' | Get-SqlAssessmentItem > c:\file.txt
#Get-SqlInstance -ServerInstance 'localhost' | Get-SqlAssessmentItem


$samplesPath='D:\--SQL--\Assessment'
$serverInstance = Get-SqlInstance -ServerInstance 'localhost'
$sqlDbMaster = $serverInstance | Get-SqlDatabase -Name master
#Get-SqlAssessmentItem $serverInstance -Configuration $(join-path $samplesPath "DisableTF634.json")
#Get-SqlAssessmentItem $serverInstance -Configuration $(join-path $samplesPath "DisableAllTF.json")

#Invoke-SqlAssessment $sqlDbMaster -configuration $(join-path $samplesPath "Assesment001Custom.json")

Invoke-SqlAssessment $serverInstance -configuration $(join-path $samplesPath "Assesment001Custom.json")


#Invoke-SqlAssessment $sqlDbMaster -configuration $(join-path $samplesPath "CustomRuleTSQLProbe.json")

