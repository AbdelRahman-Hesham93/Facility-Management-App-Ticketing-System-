const express = require('express');
const oracledb = require('oracledb');
const app = express();
const PORT = 5000;

const dbConfig = {
    user: '***',
    password: '***',
    connectString: 'localhost/xe', // Replace with your Oracle Database connection string
};

    // oracledb.getConnection(dbConfig, (err, connection) => {
    //     if (err) {
    //       console.error('Error connecting to Oracle database:', err);
    //     } else {
    //       console.log('Connected to Oracle database');
    //     }
    //   });
      
    //   app.listen(PORT, () => {
    //     console.log(`Server is running on port ${PORT}`);
    //   });
    
  
const env =   dbConfig; 
module.exports = env;