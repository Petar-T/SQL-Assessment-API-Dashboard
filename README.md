# SQL-Assessment-API-Dashboard
Simple SQL Assessment demo, created on top of CMS server list. It is collecting results in database and presenting results in simple reporting master/detail dashboard

PowerShell script to use central management server, loop through managed instances and collect results of SQL Assessment API   

![](https://github.com/Petar-T/PerfMon-collector/blob/master/Docs/CaptureMain.JPG)
## Installation

```python
run PerfMon_Setup.ps1
  #to create performance collector
run PerfMon_Fix_Header.ps1
  #to standardize header of file  
Open Perfmon_Dashboard.pbix and load file 
  #to analyze data
  
```

## Detailed HowTo

```python
Edit Run_SQLAssessment.ps1
  Run_SQLAssessment -DW_Server 'AlwaysOnN1' -CMS_Group 'Production' -Check_Type 'Server'
  #DW_Server -> server with database and CMS configured
  #CMS_Group -> Name of CMS group to use 
  #Check_Type -> 'Server' or 'Database' 
Open Assessment_Dashboard on Reporting portal   
```

Use the step by step instructions file  [instruction](https://github.com/Petar-T/PerfMon-collector/blob/master/Docs/User_Manual.docx) 

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
Please make sure to update tests as appropriate.

