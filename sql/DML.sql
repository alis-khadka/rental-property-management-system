-- 1.-- 
-- Highest revenue generating properties
-- This query will give you a list of properties, the count of leases associated with each property,
--  and the total amount of revenue generated from those properties. It focuses solely on the total payments to 
--  determine the top properties, which might be of interest if you're looking to maximize revenue rather than the number of leases.
SELECT 
  p.id AS property_id, 
  p.address, 
  COUNT(l.id) AS lease_count,
  SUM(pm.amount) AS total_revenue
FROM 
  properties p
JOIN 
  leases l ON p.id = l.property_id
JOIN 
  payments pm ON l.id = pm.lease_id
GROUP BY 
  p.id
ORDER BY 
  total_revenue DESC
LIMIT 5;

-- 2 --
-- Properties With Ongoing Maintenance Requests:
SELECT 
  DISTINCT p.id AS property_id, p.address, mr.status
FROM 
  properties p
JOIN 
  leases l ON p.id = l.property_id
JOIN 
  maintenance_requests mr ON l.id = mr.lease_id
WHERE 
  mr.status = 0
ORDER BY 
  property_id;

-- 3 --
-- Properties with no violation
-- change to tenants with no violation
SELECT 
  p.id AS property_id, 
  p.address
FROM 
  properties p
WHERE NOT EXISTS (
  SELECT 1
  FROM leases l
  JOIN violations v ON l.id = v.lease_id
  WHERE l.property_id = p.id
)
ORDER BY 
  property_id;

-- 4 --
-- Total Revenue By Landlord:
-- 

WITH LandlordRevenue AS (
  SELECT 
    ld.id AS landlord_id, 
    ld.name AS landlord_name,
    SUM(pm.amount) AS revenue
  FROM 
    landlords ld
  JOIN 
    properties p ON ld.id = p.landlord_id
  JOIN 
    leases l ON p.id = l.property_id
  JOIN 
    payments pm ON l.id = pm.lease_id
  GROUP BY 
    ld.id
)
SELECT *
FROM LandlordRevenue
ORDER BY 
  revenue DESC;

-- 5 --
-- Tenants With More Than One Active Lease:

SELECT 
  t.name,
  t.phone,
  t.email,
  COUNT(l.id) AS lease_count
FROM 
  tenants t
JOIN 
  leases l ON t.id = l.tenant_id
WHERE 
  l.status = 'Active'
GROUP BY 
  t.id
HAVING 
  COUNT(l.id) > 1;

-- 6 --
-- Most Recent Maintenance Requests per Property:
-- 
SELECT 
  p.id AS property_id, 
  p.address,
  MAX(mr.request_date) AS latest_request_date
FROM 
  properties p
JOIN 
  leases l ON p.id = l.property_id
JOIN 
  maintenance_requests mr ON l.id = mr.lease_id
GROUP BY 
  p.id;
ORDER BY
  latest_request_date;


-- 7 -- 
-- Oldest Tenant per Property:
SELECT 
  p.id AS property_id, 
  p.address, 
  t.name AS oldest_tenant_name, 
  t.date_of_birth AS oldest_tenant_dob
FROM 
  properties p
JOIN 
  leases l ON p.id = l.property_id
JOIN 
  tenants t ON l.tenant_id = t.id
WHERE 
  t.date_of_birth = (
    SELECT MIN(t2.date_of_birth)
    FROM tenants t2
    JOIN leases l2 ON t2.id = l2.tenant_id
    WHERE l2.property_id = p.id
  )
GROUP BY 
  p.id, t.id;


-- 8 --
-- Revenue Per Property for Last Year:
SELECT 
  p.id AS property_id, 
  p.address, 
  SUM(pm.amount) AS revenue
FROM 
  properties p
JOIN 
  leases l ON p.id = l.property_id
JOIN 
  payments pm ON l.id = pm.lease_id
WHERE 
  pm.payment_date >= DATE_ADD(CURRENT_DATE, INTERVAL -1 YEAR)
GROUP BY 
  p.id
ORDER BY 
  revenue DESC;


-- 9 --

