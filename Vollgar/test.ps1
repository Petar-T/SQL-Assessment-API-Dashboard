$samplesPath=Get-Location
$serverInstance = Get-SqlInstance -ServerInstance 'localhost'
$TestFileName = "Vollgar_BP.json"

Invoke-SqlAssessment $serverInstance -Configuration $(join-path $samplesPath $TestFileName), $(join-path $samplesPath "Disable_Default_Ruleset.json")
