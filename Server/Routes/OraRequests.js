const express = require('express');
const app = express();
const oracledb = require('oracledb');
const OraRequest = express.Router();
const dbConfig = {
    user: "***",
    password: "***",
    connectString:"localhost/xe",
  };
  
  OraRequest.get('/submitOrarequest', async (req, res) => {
    try {
      // Establish a connection to the Oracle database
      const connection = await oracledb.getConnection(dbConfig);
      console.log('Connected to Oracle database');
  
      // Execute the SQL query to fetch data from the 'hr.requests' table
      const result = await connection.execute('SELECT * FROM hr.Oracle_Service_Request');
  
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
  
      // Send the JSON response to the client
      res.json(jsonResponse);
  
      // Release the Oracle database connection
      await connection.close();
    } catch (error) {
      console.error('Error fetching data from Oracle database:', error);
      res.status(500).json({ error: 'Error fetching data from Oracle database' });
    }
  });
  
  OraRequest.post('/submitOrarequest', async (req, res) => {
    try {
      // Check if 'IT_REQUESTS' is present in the request body
   
      const requestData = req.body;
      // Check if 'IT_REQUESTS' is a string and its length does not exceed 30 characters
   
    //   if (typeof itRequest !== 'string' || itRequest.length > 30) {
    //     return res.status(400).json({ error: 'IT_REQUESTS must be a string of maximum 30 characters' });
    //   }
  
      // Establish a connection to the Oracle database
      const connection = await oracledb.getConnection(dbConfig);
      console.log('Connected to Oracle database');
  
      // Your SQL query to insert data into the 'hr.requests' table
      const sql = `INSERT INTO hr.Oracle_Service_Request (REQUEST, REQUESTTYPE, PHONENO, DEPT, FLOOR_, EMAIL, USER_, submitDate, STATUS, EMP_TYPE)
                 VALUES (:Request, :requestType, :phoneNo, :dept, :floor_, :email, :submitDate, :user_, :status, :emp_type)`;
  
      // Bind the values from the request body to the SQL query
      const bindParams = {
        
      request: requestData.Request,
      requestType: requestData.RequestType,
      phoneNo: requestData.PhoneNo,
      dept: requestData.Dept,
      floor_: requestData.Floor,
      email: requestData.Email,
      submitDate: requestData.SubmitDate,
      user_: requestData.User,
      status: requestData.Status,
      emp_type: null,
        // Add more binds for other columns if needed
      };
  
      // Execute the SQL query to insert data
      await connection.execute(sql, bindParams);
  
      // Commit the transaction
      await connection.commit();
  
      // Send a success response
      
  
      // Release the Oracle database connection
       connection.close();
       res.json({ message: 'Request submitted successfully' });
    } catch (err) {
      console.error('Error processing request: ', err);
      res.status(500).json({ error: 'Request processing failed' });
    }
  });

  // Add a DELETE request to delete a request by ID

  
//   Request.delete('/requests/:id', async (req, res) => {
//       try {
//         const requestId = req.body.requestId;
//         const requestDepartment = req.body.department;
//         const requestFloor = req.body.floor;

//         if (!requestId || !requestDepartment || !requestFloor) {
//             return res.status(400).json({ error: 'Request ID, Department, and Floor are required' });
//         }

//         // Establish a connection to the Oracle database
//         const connection = await oracledb.getConnection(dbConfig);
//         console.log('Connected to Oracle database');

//         // Your SQL query to delete a request by ID and other columns
//         const sql = 'DELETE FROM hr.requests WHERE IT_REQUESTS = :requestId AND DEPARTMENT = :requestDepartment AND FLOOR = :requestFloor';

//         // Bind the request parameters to the SQL query
//         const bindParams = {
//             requestId,
//             requestDepartment,
//             requestFloor,
//         };

//         // Execute the SQL query to delete the request
//         const result = await connection.execute(sql, bindParams);

//         if (result.rowsAffected === 0) {
//             return res.status(404).json({ error: 'Request not found' });
//         }

//         // Commit the transaction
//         await connection.commit();

//         // Send a success response
//         res.json({ message: 'Request deleted successfully' });

//         // Release the Oracle database connection
//         await connection.close();
//     } catch (error) {
//         console.error('Error deleting data from Oracle database:', error);
//         res.status(500).json({ error: 'Error deleting data from Oracle database' });
//     }
// });
  
  module.exports = OraRequest;