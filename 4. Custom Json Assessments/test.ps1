$samplesPath=Get-Location
$serverInstance = Get-SqlInstance -ServerInstance 'localhost'


#Invoke-SqlAssessment $serverInstance -configuration $(join-path $samplesPath "Assesment001Custom.json")
#Invoke-SqlAssessment $serverInstance -Configuration $(join-path $samplesPath "Assesment001Custom.json"), $(join-path $samplesPath "Disable_All.json")
Invoke-SqlAssessment $serverInstance -Configuration $(join-path $samplesPath "Assesment001Custom.json"), $(join-path $samplesPath "Disable_Default_Ruleset.json")




