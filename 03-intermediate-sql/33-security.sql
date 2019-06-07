-- Security and management of your SQL Server Database is generally something performed best in SSMS

-- Use the GUI for the following tasks:

-- * Enable SQL logins.
-- * Create a Login. Test if you can log in
-- * Create a User inside a database. Test your permissions.
-- * Alter rights. See the effects

-- ## Enable SQL Login

-- In order to do this demo, we need to enable SQL logins. These are username-password style logins, where all information
-- is kept inside SQL Server.

-- 1. Right-click on the server name, check "Properties"
-- 2. Open "Security"
-- 3. Under "Server authentication", click "SQL Server and Windows Authentication mode"
-- 4. Click "OK" 

-- SQL Server Logins are now enabled

-- ## Create a login

-- Logins exist at the **instance** level of SQL Server. 