# SQL-Assessment-API-Dashboard
Simple SQL Assessment demo, created on top of CMS server list. It is collecting results in database and presenting results in simple reporting master/detail dashboard

PowerShell script to use central management server, loop through managed instances and collect results of SQL Assessment API   



```powershell
#Powershell usage:
Run_SQLAssessment -DW_Server 'AlwaysOnN1' -CMS_Group 'Production' -Check_Type 'Server'
```

Dashboard view             |  Detail view
:-------------------------:|:-------------------------:
![](https://github.com/Petar-T/SQL-Assessment-API-Dashboard/blob/master/Instructions/Dashboard.JPG)  |  ![](https://github.com/Petar-T/SQL-Assessment-API-Dashboard/blob/master/Instructions/Dashboard2.JPG)

## Installation

1. Step : Create database (use the script in folder 1. Database) on same instance where you created CMS
2. Step : Deploy files from folder '2. Reports' on Reporting server. Configure .Rds file to point to previously configured database
3. Step : Run Powershell script from folder '3. Execution script' from client machine.


## Prereqs

1. Powershell **SQLServer module** installed
2. Powershell **DBATools module** installed
3. **SQL Server** installed
4. **Reporting Server** installed 


## Detailed HowTo

```python
Edit Run_SQLAssessment.ps1
  Run_SQLAssessment -DW_Server 'AlwaysOnN1' -CMS_Group 'Production' -Check_Type 'Server'
  #DW_Server -> server with database and CMS configured
  #CMS_Group -> Name of CMS group to use 
  #Check_Type -> 'Server' or 'Database' 
Open Assessment_Dashboard on Reporting portal   
```

Use the step by step instructions file  [instruction](https://github.com/Petar-T/SQL-Assessment-API-Dashboard/blob/master/Instructions/User_Manual.docx) 

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
Please make sure to update tests as appropriate.

