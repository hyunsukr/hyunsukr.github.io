var http = require('http');
var fs = require('fs');
var path = require('path');


http.createServer(function (req, res) {
    if (!req.url.includes('.js') && !req.url.includes('.css') && !req.url.includes('.jpg') && !req.url.includes('.png')) {
        console.log(req.url + "this is the req.url");
        if (req.url == '/') {
            fs.readFile('home.html', function(err, data) {
                res.writeHead(200, {'Content-Type': 'text/html'});
                res.write(data);
                res.end();
            });
        }
        else if (req.url == '/project') {
            fs.readFile('project.html', function(err, data) {
                res.writeHead(200, {'Content-Type': 'text/html'});
                res.write(data);
                res.end();
            });
        }
        else if (req.url == '/kseaweb') {
            fs.readFile('ksea.html', function(err, data) {
                res.writeHead(200, {'Content-Type': 'text/html'});
                res.write(data);
                res.end();
            });
        }
        else if (req.url == '/uscconsulation') {
            fs.readFile('uscconsulation.html', function(err, data) {
                res.writeHead(200, {'Content-Type': 'text/html'});
                res.write(data);
                res.end();
            });
        }
        else if (req.url == '/swifteats') {
            fs.readFile('swifteats.html', function(err, data) {
                res.writeHead(200, {'Content-Type': 'text/html'});
                res.write(data);
                res.end();
            });
        }
        else if (req.url == '/shinlab') {
            fs.readFile('shinlab.html', function(err, data) {
                res.writeHead(200, {'Content-Type': 'text/html'});
                res.write(data);
                res.end();
            });
        }
        else if (req.url == '/academics') {
            fs.readFile('academics.html', function(err, data) {
                res.writeHead(200, {'Content-Type': 'text/html'});
                res.write(data);
                res.end();
            });
        }
        else if (req.url == '/resume') {
            fs.readFile('resume_ryoo.pdf', function(err, data) {
                res.writeHead(200, {'Content-Type': 'application/pdf'});
                res.write(data);
                res.end();
            });
        }
        else if (req.url == '/contact') {
            fs.readFile('contact.html', function(err, data) {
                res.writeHead(200, {'Content-Type': 'text/html'});
                res.write(data);
                res.end();
            });
        }
        else {
        res.write('nopage');
        res.end();
        }
    } 
    else {
        var filePath = '.' + req.url;
        if (filePath == './')
            filePath = './index.html';
        var extname = path.extname(filePath);
        var contentType = 'text/html';
        switch (extname) {
            case '.js':
                contentType = 'text/javascript';
                break;
            case '.css':
                contentType = 'text/css';
                break;
            case '.json':
                contentType = 'application/json';
                break;
            case '.png':
                contentType = 'image/png';
                break;
            case '.jpg':
                contentType = 'image/jpg';
                break;
            case '.wav':
                contentType = 'audio/wav';
                break;
        }
        fs.readFile(filePath, function(error, content) {
            if (error) {
                if(error.code == 'ENOENT'){
                    fs.readFile('./404.html', function(error, content) {
                        res.writeHead(200, { 'Content-Type': contentType });
                        res.end(content, 'utf-8');
                    });
                }
                else {
                    res.writeHead(500);
                    res.end('Sorry, check with the site admin for error: '+error.code+' ..\n');
                    res.end();
                }
            }
            else {
                res.writeHead(200, { 'Content-Type': contentType });
                res.end(content, 'utf-8');
            }
        });
    }
}).listen(1234, '0.0.0.0'); //connect to local ip
    //}).listen(2020); //connect to localhost