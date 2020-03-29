#$DW_Server='(Local)'
$DW_DB='SQLAssessmentDemo'
#$Check_Type = 'Database' #possible values are 'Server' and 'Database'
#$CMS_Group = 'Production'
#$newid =0



function Get_NewRows ($SrvrName, $DBName, $InPar1, $InPar2) 
{

$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = "Server=$SrvrName;Database=$DBName;Integrated Security=True"

$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
$SqlCmd.CommandText = "[Assessment].[GetNewRows]"
$SqlCmd.CommandType = [System.Data.CommandType]'StoredProcedure'; 
$SqlCmd.Connection = $SqlConnection

$Par1 = new-object System.Data.SqlClient.SqlParameter;
$Par1.ParameterName = "@Assessment_Type";
$Par1.DbType = [System.Data.DbType]'String';
$Par1.Size = 20;
$Par1.Value = $InPar1;

$Par2 = new-object System.Data.SqlClient.SqlParameter;
$Par2.ParameterName = "@Assessment_Target";
$Par2.DbType = [System.Data.DbType]'String';
$Par2.Size = 20;
$Par2.Value = $InPar2;

$ParOut = new-object System.Data.SqlClient.SqlParameter;
$ParOut.ParameterName = "@new_id";
$ParOut.Direction = [System.Data.ParameterDirection]'Output';
$ParOut.DbType = [System.Data.DbType]'Int32';
#$ParOut.Value = 0;

$SqlCmd.Parameters.Add($Par1) >> $null;
$SqlCmd.Parameters.Add($Par2) >> $null;
$SqlCmd.Parameters.Add($ParOut) >> $null;


$SqlConnection.Open();
 $SqlCmd.ExecuteNonQuery() >> $null;
 $ResultID= $SqlCmd.Parameters["@New_ID"].Value;
 return $ResultID


$SqlConnection.Close();
$SqlConnection.Dispose();

}

function Run_SQLAssessment ($DW_Server, $CMS_Group,$Check_Type)
{

$srvrs=Get-DbaRegServer -SQLInstance AlwaysOnN1 -Group Production
foreach ($inst in $srvrs)
{
    try
    {
        If ($Check_Type -eq 'Server')
        {
            Get-SqlInstance -ServerInstance $inst.Name | Invoke-SqlAssessment -FlattenOutput |
            Write-SqlTableData -ServerInstance $DW_Server -DatabaseName $DW_DB -SchemaName Assessment -TableName Results_Staging -Force
        }
        else
        {
            Get-SqlDatabase -ServerInstance $inst.Name | Invoke-SqlAssessment -FlattenOutput |
            Write-SqlTableData -ServerInstance $DW_Server -DatabaseName $DW_DB -SchemaName Assessment -TableName Results_Staging -Force
        }
    }
    catch
    { 
    $msg =$_.Exception.Message 
    Write-Host $msg -ForegroundColor Red
    #|
    #Write-SqlTableData -ServerInstance $DW_Server -DatabaseName $DW_DB -SchemaName Assessment -TableName Error_Log -Force
    }
}

$outVar = Get_NewRows $DW_Server $DW_DB  $Check_Type  $CMS_Group 
Write-Host "Assesment Done!" -ForegroundColor Yellow

}


Run_SQLAssessment -DW_Server 'AlwaysOnN1' -CMS_Group 'Production' -Check_Type 'Server'