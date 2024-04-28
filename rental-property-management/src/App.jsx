import { useState } from "react";
import "./App.css";
import { queries } from './queries';

function App() {
  const [selectedQuery, setSelectedQuery] = useState("");
  const [sqlQuery, setSqlQuery] = useState("");
  const [queryResult, setQueryResult] = useState([]);
  const [error, setError] = useState("");

  const handleQuerySelection = (event) => {
    setSelectedQuery(event.target.value);
    setSqlQuery(queries[event.target.value]?.sqlQuery || "")
    setQueryResult([]);
    setError("");
  };

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
        console.log(data);
        if (data.success) {
          setQueryResult(data.data);
          setError("");
        } else {
          setQueryResult([]);
          setError(data.data.sqlMessage);
        }
      })
      
  };

  return (
    <div className="container">
      <h1>Property Management System</h1>
      <select value={selectedQuery} onChange={handleQuerySelection}>
      <option value="">Select Query</option>
        {Object.keys(queries).map((key, i) => (
          <option key={i} value={key}>
            {queries[key].displayText}
          </option>
        ))}
      </select>
      <textarea value={sqlQuery} readOnly></textarea>
      <button onClick={handleQuerySubmit}>Send Query</button>
      {Array.isArray(queryResult) &&
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
      }
      {!Array.isArray(queryResult) && typeof(queryResult) == 'object' &&
        <div className="message-box">
          {queryResult.message}
        </div>
      }
      {queryResult.length == 0 && !!error &&
        <div className="error-box">
          ERROR!!!
          <br />
          {error}
        </div>
      }
    </div>
  );
}

export default App;
