import express from "express";
import mysql from "mysql";

const app = express();

app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "*"); // Allow requests from any origin
  res.header(
    "Access-Control-Allow-Headers",
    "Origin, X-Requested-With, Content-Type, Accept"
  );
  next();
});

const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "S@m.sql.pw22",
  database: "rental_db",
});

app.use(express.json());

app.get("/", (req, res) => {
  res.json("Welcome to the Rental API");
});

app.post("/executeQuery", (req, res) => {
  const { sqlQuery } = req.body;
  if (!sqlQuery) {
    return res.status(400).json({ error: "SQL query is required" });
  }

  db.query(sqlQuery, (err, result) => {
    if (err) {
      console.error("Error executing query:", err);
      return res.status(500).json({ error: "Internal server error" });
    }

    return res.json(result);
  });
});

// app.get("/executeQuery", (req, res) => {
//   const { sqlQuery } = req.body;
//   console.log("Received SQL query:", sqlQuery);
// });

// app.get("/test", (req, res) => {
//   // res.json("Select * from landlords")
//   const sql = "SELECT * FROM landlords";
//   db.query(sql, (err, result) => {
//     if (err) return res.json(err); // not connected!
//     return res.json(result);
//     // console.log(result);
//     // res.send('Data received from MySQL server');
//   });
// });

app.listen(8800, () => {
  console.log("Connected to the backend!!!");
});
