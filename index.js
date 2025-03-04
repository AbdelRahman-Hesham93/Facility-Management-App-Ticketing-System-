const express = require('express');
const app = express();
const oracledb = require('oracledb');
const PORT = process.env.PORT || 5000;
const http = require('http');
const socketIO = require('socket.io');

const server = http.createServer();
const io = socketIO(server);

io.on('connection', (socket) => {
  console.log('A user connected:', socket.id);

  socket.on('chat message', (message) => {
    console.log('Received message:', message);
    io.emit('chat message', message); // Broadcast the message to all connected clients
  });

  socket.on('disconnect', () => {
    console.log('User disconnected:', socket.id);
  });
});
 // Ensure you have your Oracle DB configuration in this file
const Request = require('./Server/Routes/Requests');
const OraRequest = require('./Server/Routes/OraRequests');
// Middleware
app.use(express.json());
app.use('/', Request); 
app.use('/', OraRequest); 



server.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

// Database connection parameters
