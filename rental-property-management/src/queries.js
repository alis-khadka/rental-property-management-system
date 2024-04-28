export const queries = {
    query1: {
        displayText: "Query 1: Highest revenue generating properties",
        sqlQuery: `SELECT 
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
            LIMIT 5;`,
    },
    query2: {
        displayText: "Query 2: Properties With Ongoing Maintenance Requests",
        sqlQuery: `SELECT 
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
                property_id;`,
    },
    query3: {
        displayText: "Query 3: Properties with reports of violation",
        sqlQuery: `SELECT
                p.id AS property_id,
                p.address
            FROM
                properties p
            WHERE
                EXISTS (
                    SELECT
                        l.property_id
                    FROM
                        leases l
                        JOIN violations v ON l.id = v.lease_id
                    WHERE
                        l.property_id = p.id
                )
            ORDER BY
                property_id;`,
    },
    query4: {
        displayText: "Query 4: Total Revenue By Landlord",
        sqlQuery: `WITH LandlordRevenue AS (
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
                revenue DESC;`,
    },
    query5: {
        displayText: "Query 5: Tenants With More Than One Active Lease",
        sqlQuery: `SELECT 
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
                    COUNT(l.id) > 1;`,
    },
    query6: {
        displayText: "Query 6: Most Recent Maintenance Requests per Property",
        sqlQuery: `SELECT 
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
                    p.id
                ORDER BY
                    latest_request_date DESC;`,
    },
    query7: {
        displayText: "Query 7: Revenue Per Property for Last Year",
        sqlQuery: `SELECT 
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
                    revenue DESC;`,
    },
    query8: {
        displayText: "Query 8: Amount of money paid by each tenant in descending order",
        sqlQuery: `Select lease_id, sum(amount)
                From payments
                Group by lease_id
                Order by sum(amount) DESC;`,
    },
    
    query9: {
        displayText: "Query 9: Lowest and highest amount paid",
        sqlQuery: `Select Min(amount), Max(amount)
                From payments;`,
    },
    query10: {
        displayText: "Query 10: Description of violations whose lease are active",
        sqlQuery: `Select t.name, t.phone, t.email, v.description
                From violations v
                Join leases l
                On l.id = v.lease_id
                Join tenants t
                On t.id = l.tenant_id
                Where lease_id in
                    (select lease_id
                    From leases
                    Where status = TRUE);`,
    },
    query11: {
        displayText: "Query 11: Name Of Landlords thats starts with B, L, OR V (case insensitive)",
        sqlQuery: `Select name
                From landlords
                Where LEFT(name, 1) IN ('b', 'l', 'v', 'B', 'L', 'V');`
    },
    query12: {
        displayText: "Query 12: Update primary key of landlords (Error)",
        sqlQuery: `UPDATE landlords
                SET id = 100
                WHERE id = 1;`,
    },
    query13: {
        displayText: "Query 13: Update name and phone of a landlord",
        sqlQuery: `
        UPDATE landlords
        SET name = 'Damian Moon', phone = '+1 864-345-8679 x4123'
        WHERE name = 'Lakiesha Heathcote';
        `,
    },
    query14: {
        displayText: "Query 14: Update all active violations to false",
        sqlQuery: `
        UPDATE violations
        SET status = False
        WHERE status = TRUE;
        `,
    },
    query15: {
        displayText: "Query 15: Resolve the maintenace_requests if it was made before 2024 JAN",
        sqlQuery: `
        UPDATE maintenance_requests
        SET status = FALSE
        WHERE request_date < '2024-01-01';
        `,
    },
};
