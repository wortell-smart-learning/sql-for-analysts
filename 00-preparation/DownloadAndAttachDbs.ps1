New-Item -ItemType Directory -Force -Path C:\awbackups

$downloads = @{
    "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2019.bak" = "c:\awbackups\AdventureWorks2019.bak"
    "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2019.bak" = "c:\awbackups\AdventureWorksDW2019.bak"
    "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksLT2019.bak" = "c:\awbackups\AdventureWorksLT2019.bak"
}
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

ForEach($key in $downloads.Keys) {
    (New-Object System.Net.WebClient).DownloadFile($key, $downloads[$key])
}

(sqlcmd -S . -Q "RESTORE DATABASE [AdventureWorks2019] FROM  DISK = N'C:\dbbackups\AdventureWorks2019.bak' WITH  FILE = 1,  MOVE N'AdventureWorks2017' TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AdventureWorks2019.mdf',  MOVE N'AdventureWorks2017_log' TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AdventureWorks2019_log.ldf',  NOUNLOAD,  REPLACE, STATS = 5")
(sqlcmd -S . -Q "RESTORE DATABASE [AdventureWorksLT2019] FROM  DISK = N'C:\dbbackups\AdventureWorksLT2019.bak' WITH  FILE = 1,  MOVE N'AdventureWorksLT2012_Data' TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AdventureWorksLT2012.mdf',  MOVE N'AdventureWorksLT2012_Log' TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AdventureWorksLT2012_log.ldf',  NOUNLOAD,  REPLACE, STATS = 5")
(sqlcmd -S . -Q "RESTORE DATABASE [AdventureWorksDW2019] FROM  DISK = N'C:\dbbackups\AdventureWorksDW2019.bak' WITH  FILE = 1,  MOVE N'AdventureWorksDW2017' TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AdventureWorksDW2019.mdf',  MOVE N'AdventureWorksDW2017_log' TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AdventureWorksDW2019_log.ldf',  NOUNLOAD, REPLACE, STATS = 5")
