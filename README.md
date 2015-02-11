# TMS
asp.net application timesheet management system
Group 1 - LE PHAT HUY - s3230237

+ Default username/password of the system
	admin/admin
+ Admin's Functions:
	- View, Add, Edit, Delete members
	- View, Add, Edit, Delete projects
	- View Audit Trail
+ Member's Functions:
	- View, Edit Profile
	- Add Tasks For Timesheet
	- View, Edit, Delete, Submit, Save Timesheet
	- View your timesheet's members
	- Approve/Reject timesheet's members
	- View Project's Timesheet of manager
+ Limit:
	- You have to type date on week starting textbox :( I cannot figure out the problems ajax control toolkit calendarextender doesn't work.
	
+ Supplement:
	- You should enter below xml in Web.config
	
	<appSettings>
		<add key="ConnString" value="Data Source=.\sqlexpress;Initial Catalog='TMSDB';Integrated Security=True;"/>
	</appSettings>

+ Thanks for reading!
