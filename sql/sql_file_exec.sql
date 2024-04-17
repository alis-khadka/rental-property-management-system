-- This drops all of the previously created tables so we can start with a clean database
DROP TABLE IF EXISTS landlords, tenants, properties, leases, payments, maintenance_requests, violations;

-- This creates all of our tables from our schema file
source DDL.sql;

-- This populates all of our tables with sample data
source data_population/landlords.sql;
source data_population/tenants.sql;
source data_population/properties.sql;
source data_population/leases.sql;
source data_population/payments.sql;
source data_population/maintenance_requests.sql;
source data_population/violations.sql;

-- And finally, these perform actions on our created test data to demonstrate database usage

SELECT payment_date FROM payments WHERE (lease_id = 30);

-- etc (add a bunch of these
