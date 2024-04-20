## This project is done as a course requirement of CSC 4402 Database Systems.

## This project aims to digitize the process of renting a property like signing the lease, making monthly payments, maintenance request, and so on.

## USAGE
- To copy the project from local device to the classes server, run the following;\
`scp -r /your/local/path/ cs4402xx@classes.csc.lsu.edu:/classes/cs4402/cs4402xx/`
- cd into the root directory of the project.\
- Run the below script file from the root directory.\
`./setup.sh database_name`\
> Note:
> - If you are trying run this in the **classes** server, you don't have access to create new database.So, provide your account_id(csc4402xx).
> - If it says **permission denied** while running the script file, run the following;\
> `chmod +x ./setup.sh`
- The above command will create a new file named sql_exec_final.sql\
- Run the file from mysql console.\
`source path/to/sql_exec/final.sql`\ \

The database and tables should be created.
