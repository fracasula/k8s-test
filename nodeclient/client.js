const fs = require('fs');
const net = require('net');
const http = require('http');

const HTTP_SERVER_PORT = 8081;

const client = new net.Socket();

http.createServer((req, res) => {
    console.log('Incoming request', req.url);

    switch (req.url) {
        case '/':
            res.writeHead(200, {'Content-Type': 'text/html'});
            res.end(fs.readFileSync(`${__dirname}/website/index.html`));
            break;
        case '/connect.html':
            res.writeHead(200, {'Content-Type': 'text/html'});

            client.connect(1337, 'nodeserver.default.svc.cluster.local', () => {
                res.write('Hello, server! Love, Client.<br>');
            });

            client.on('data', data => {
                res.write('Received: ' + data + '<br>');
                client.destroy(); // kill client after server's response
            });

            client.on('close', () => {
                res.end('Connection closed');
            });
            break;
        default:
            // endpoint for testing client errors
            res.writeHead(404, {'Content-Type': 'text/plain'});
            res.end('404 Not Found');
    }
}).listen(HTTP_SERVER_PORT);

console.log(`Listening on ${HTTP_SERVER_PORT}`);