CREATE DATABASE IF NOT EXISTS $db_name;
USE $db_name;

-- This drops all of the previously created tables so we can start with a clean database
DROP TABLE IF EXISTS violations, maintenance_requests, payments, leases, properties, tenants, landlords;

-- This creates all of our tables from our schema file
source $path/sql/DDL.sql;

-- This populates all of our tables with sample data
source $path/sql/data_population/landlords.sql;
source $path/sql/data_population/tenants.sql;
source $path/sql/data_population/properties.sql;
source $path/sql/data_population/leases.sql;
source $path/sql/data_population/payments.sql;
source $path/sql/data_population/maintenance_requests.sql;
source $path/sql/data_population/violations.sql;

-- And finally, these perform actions on our created test data to demonstrate database usage

SELECT payment_date FROM payments WHERE (lease_id = 30);

-- etc (add a bunch of these
