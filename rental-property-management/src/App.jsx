import { useState } from "react";
import "./App.css";

function App() {
  const [selectedQuery, setSelectedQuery] = useState("");
  const [sqlQuery, setSqlQuery] = useState("");
  const [queryResult, setQueryResult] = useState([]);

  const handleQuerySelection = (event) => {
    setSelectedQuery(event.target.value);
    switch (event.target.value) {
      case "query1":
        setSqlQuery(`SELECT 
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
      LIMIT 5;`);
        break;
      case "query2":
        setSqlQuery(`SELECT 
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
        property_id;`);
        break;
      case "query3":
        setSqlQuery(`SELECT 
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
        property_id;`);
        break;
      case "query4":
        setSqlQuery(`WITH LandlordRevenue AS (
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
          revenue DESC;`);
        break;
      case "query5":
        setSqlQuery(`SELECT 
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
        COUNT(l.id) > 1;`);
        break;
      case "query6":
        setSqlQuery(`SELECT 
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
        latest_request_date DESC;`);
        break;
      case "query7":
        setSqlQuery(`SELECT 
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
        p.id, t.id;`);
        break;
      case "query8":
        setSqlQuery(`SELECT 
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
        revenue DESC;`);
        break;
      default:
        setSqlQuery("");
    }
  };

  // const handleQuerySubmit = () => {
  //   // Here you would send the SQL query to your backend for execution
  //   // and update the queryResult state with the returned data
  //   // For demonstration, let's assume queryResult is an array of objects
  //   setQueryResult([{ id: 1, name: "Property 1", value: 100000 }]);
  // };

  const handleQuerySubmit = () => {
    if (!sqlQuery) {
      setQueryResult([]);
      return; // Do nothing if there's no SQL query
    }

    fetch("http://localhost:8800/executeQuery", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ sqlQuery }),
    })
      .then((response) => response.json())
      .then((data) => {
        setQueryResult(data); // Update queryResult state with the returned data
      })
      .catch((error) => {
        console.error("Error executing query:", error);
        // Handle error if necessary
      });
  };

  return (
    <div className="container">
      <h1>Property Management System</h1>
      <select value={selectedQuery} onChange={handleQuerySelection}>
        <option value="">Select Query</option>
        <option value="query1">
          Query 1: Highest revenue generating properties
        </option>
        <option value="query2">
          Query 2: Properties With Ongoing Maintenance Requests
        </option>
        <option value="query3">Query 3: Properties with no violation</option>
        <option value="query4">Query 4: Total Revenue By Landlord</option>
        <option value="query5">
          Query 5: Tenants With More Than One Active Lease
        </option>
        <option value="query6">
          Query 6: Most Recent Maintenance Requests per Property
        </option>
        <option value="query7">Query 7: Oldest Tenant per Property</option>
        <option value="query8">
          Query 8: Revenue Per Property for Last Year
        </option>
        <option value="query9">Query 9</option>
        <option value="query10">Query 10</option>
        <option value="query11">Query 11</option>
        <option value="query12">Query 12</option>
        <option value="query13">Query 13</option>
        <option value="query14">Query 14</option>
        <option value="query15">Query 15</option>
        <option value="query16">Query 16</option>

        {/* Add more options for additional queries */}
      </select>
      <textarea value={sqlQuery} readOnly></textarea>
      <button onClick={handleQuerySubmit}>Send Query</button>
      <div className="table-container">
        <table className="query-table">
          <thead>
            <tr>
              {queryResult.length > 0 &&
                Object.keys(queryResult[0]).map((key) => (
                  <th key={key}>{key}</th>
                ))}
            </tr>
          </thead>
          <tbody>
            {queryResult.map((item, index) => (
              <tr key={index}>
                {Object.values(item).map((value, index) => (
                  <td key={index}>{value}</td>
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      {/* <div className="grid-container">
        <table>
          <thead>
            <tr>
              {queryResult.length > 0 &&
                Object.keys(queryResult[0]).map((key) => (
                  <th key={key}>{key}</th>
                ))}
            </tr>
          </thead>
          <tbody>
            {queryResult.map((item, index) => (
              <tr key={index}>
                {Object.values(item).map((value, index) => (
                  <td key={index}>{value}</td>
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      </div> */}
    </div>
  );
}

export default App;
