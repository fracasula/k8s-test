const net = require('net');

const server = net.createServer(socket => {
    socket.write('Echo from server.js\r\n');
    socket.pipe(socket);
});

server.listen(1337);