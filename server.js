const fs = require('fs');
const http = require('http');
const HTTP_SERVER_PORT = 8081;

http.createServer((req, res) => {
    console.log('Incoming request', req.url);

    switch (req.url) {
        case '/':
            // serving the homepage (which is the only endpoint available)
            res.writeHead(200, {'Content-Type': 'text/html'});
            res.end(fs.readFileSync(`${__dirname}/website/index.html`));

            console.log(
                fs.readFileSync(`${__dirname}/website/index.html`).toString('UTF-8')
            );
            break;
        default:
            // endpoint for testing client errors
            res.writeHead(404, {'Content-Type': 'text/plain'});
            res.end('404 Not Found');
    }
}).listen(HTTP_SERVER_PORT);

console.log(`Listening on ${HTTP_SERVER_PORT}`);