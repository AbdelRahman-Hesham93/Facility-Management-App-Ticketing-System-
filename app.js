const express = require('express');
const oracledb = require('oracledb');
const app2 = require('./app');
// Define your routes using approuter




approuter.use(express.json()); // Middleware to parse JSON data in requests

approuter.get('/', (req, res) => {
  res.send('Hello world');
});



// Route to fetch data
approuter.get('/requests', (req, res) => {
  async function fetchOracle() {
    try {

      const result = await connection.execute('SELECT * FROM hr.requests');
      // Process the result and construct the desired JSON structure
      const metaData = result.metaData.map((column) => column.name);
      const rows = result.rows.map((row) => {
        const request = {};
        result.metaData.forEach((column, index) => {
          request[column.name] = row[index];
        });
        return request;
      });


      // Construct the final JSON response
      const jsonResponse = {
        metaData, 
        rows,
      };

      return jsonResponse;
    } catch (error) {
      return error;
    }
  }

  approuter.get('/companies', (req, res) => {
    async function fetchOracle() {
      try {
  
        const result2 = await connection.execute('SELECT * FROM hr.company');
        // Process the result and construct the desired JSON structure
        const metaData2 = result2.metaData2.map((column) => column.name);
        const rows2 = result2.rows2.map((row) => {
          const request2 = {};
          result2.metaData2.forEach((column, index) => {
            request2[column.name] = row[index];
          });
          return request2;
        });
  
  
        // Construct the final JSON response
        const jsonResponse = {
          metaData2, 
          rows2,
        };
  
        return jsonResponse;
      } catch (error) {
        return error;
      }
    }});
  // fetchOracle()
  //   .then((dbRes) => {
  //     res.json(dbRes); // Send the JSON response
  //   })
  //   .catch((err) => {
  //     res.status(500).json({ error: err.message });
  //   });
});
    
// Route to insert data
// app.post('/insertRequest', async (req, res) => {
//   const requestData = req.body; // Assuming you send data in the request body

//   async function insertRequest() {
//     try {
//       const connection = await oracledb.getConnection({
//         user: '***',
//         password: '***',
//         connectString: 'localhost/xe',
//       });

//       // Your SQL query to insert data into the 'requests' table
//       const sql = 'INSERT INTO hr.requests (IT_Requests) VALUES (:val1)';
//     const bindParams = {
//       val1: 'Req 7',
//     };

//       // Bind the values from requestData to the SQL query
     

//       const options = {
//         autoCommit: true,
//         bindDefs: bindParams,
//       };

//       const result = await connection.execute(sql, bindParams, options);

//       return result;
//     } catch (error) {
//       return error;
//     }
//   }

//   insertRequest()
//     .then((dbRes) => {
//       res.json({ message: 'Request inserted successfully' });
//     })
//     .catch((err) => {
//       res.status(500).json({ error: err.message });
//     });
// });
module.exports = { app2 };
