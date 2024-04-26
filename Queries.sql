-- GET ALL TABLES FROM PROPERTIES IF THE LANDLORD ID = 4
SELECT *
FROM properties
WHERE landlord_id = 4;

-- GET LEASE iD AND DESCRIPTION FROM MAINTENANCE REQUESTS IF STATUS = FALSE
Select lease_id, description
From maintenance_requests
Where status = FALSE;

-- GET NAME, ID, ADDRESS RESPECTIVE TO TENANT
Select id, name, address
From tenants;

-- GET THE AMOUNT OF MONEY PAID BY EACH TENANT IN DESCENDING ORDER
Select lease_id, sum(amount)
From payments
Group by lease_id
Order by sum(amount) DESC;

-- GET NAME OF LANDLORD THATS STARTS WITH B, L, OR V
Select name
From landlord
Where LEFT(name, 1) IN ('b', 'l', 'v', 'B', 'L', 'V');

-- GET THE AMOUNT OF MONEY PAID BY EACH TENANT IF IT IS GREATER THAN 12000 IN DESCENDING ORDER
Select lease_id, sum(amount) amount
From payments
Group by lease_id
Having sum(amount) > 1200
Order by sum(amount) DESC;

-- GET ALL TABLES FROM TENANTS AND LEASES
Select *
From tenants natural join leases;

-- GET THE DESCRIPTION OF THE VIOLATION IF LEASE STATUS = TRUE
Select descriptions
From violations
Where lease_id in 
(select lease_id
 From leases
 Where status = TRUE);

-- RETURN ALL TABLES OF OF MAINTENANCE REQUESTS IF THE LEASE_ID HAS NOT CAUSED ANY PRIOR VIOLATIONS AND IF THE STATUS IS FALSE
Select *
From maintenance_requests
Where NOT EXISTS (select lease_id from violations where violations.lease_id = maintenance_requests.lease_id) AND status = FALSE;

-- CHANGE ID 1 OF MAINTENANCE REQUESTS TO TRUE
UPDATE maintenance_requests
SET status = TRUE
WHERE id = 1;

-- CHANGE NAME OF ID 1 IN TENANTS
UPDATE tenants
SET name = ‘Trevor Landon’
WHERE id = 1;

-- CHANGE THE PHONE NUMBER AND EMAIL OF ID 7
UPDATE tenants
SET phone = ‘+1 244-785-3623’, email = ‘Effie_here@arrival.test’
WHERE id = 7;

-- SET LAKIESHA HEATHCOTE’S NAME TO DAMIAN MOON AND CHANGE PHONE NUMBER
UPDATE landlords
SET name = ‘Damian Moon’, phone = ‘+1 864-345-8679 x4123’
WHERE name = ‘Lakiesha Heathcote’

-- SET ALL VIOLATIONS WITH A TRUE STATUS TO FALSE
UPDATE violations
SET status = False
WHERE status = TRUE;

-- RETURN NAME AND PHONE NUMBER OF BOTH LANDLORDS AND TENANTS
Select name, phone
From landlords
UNION
Select name, phone
From tenants;

-- RETURN THE LOWEST AMOUNT PAID IN ONE PAYMENT DATE AND THE HIGHEST AMOUNT PAID IN ONE PAYMENT DATE
Select Min(amount), Max(amount)
From payments;









