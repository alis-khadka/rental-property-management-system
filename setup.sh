#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <db_name>"
    exit 1
fi

# Assign command-line argument to variable
database_name="$1"
echo $database_name

# Fetch the path of the current directory
dir_path=$(pwd)

# Read the content of sql_file_exec.sql file and replace $path with dir_path
content=$(cat "$dir_path/sql/exec_template.sql" | sed -e "s|\$path|$dir_path|g" -e "s|\$db_name|$database_name|g")

# Write the modified content to a new file in the same folder folder
echo "$content" > "$dir_path/sql/sql_exec_final.sql"

echo -e "\n\n!!! The final execution file is ready. (location = root_dir/sql/sql_exec_final.sql)!!!\n\n"
echo -e "Go into the mysql console and run the following command.\n\n"
echo -e "source $dir_path/sql/sql_exec_final.sql;\n\n\n"

echo -e "Use the below to view the schema of different tables of database: $database_name.\n\n"
echo -e "source $dir_path/sql/schema.sql;\n\n\n"

echo -e "Use the below command to run the different DML queries.\n\n"
echo -e "source $dir_path/sql/DML.sql;\n\n\n"

echo -e "Run the following command for some select sql.\n\n"
echo -e "source $dir_path/sql/queries.sql;\n\n\n"

echo -e "!!!CHEERS!!!\n\n"
