var app = require('./express');
var mysql = require('mysql');
var http = require('http').Server(app);
var express = app.express;
var bodyParser = require('body-parser');
app.use(bodyParser.json({limit: '50mb'}));
app.use(bodyParser.urlencoded({limit: '50mb', extended: true}));
var cookieParser = require('cookie-parser');

app.use(cookieParser());

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.use(express.static(__dirname + '/public'));

require("./server/app");

var port = process.env.PORT || 3000;

app.listen(port);


app.use(require("express").static('data'));

var con = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "xci18783",
    database: "zoo"
});


app.get("/",function(req,res){
    res.sendFile(__dirname + '/index.html');
});

app.post('/get_data', function (req, res) {
    var table = req.body['type'];

    var query="select * from " + table;

    con.query(String(query),function(err,rows){
        //con.close();
        if(!err) {
            if(rows.length > 0){
                res.write(JSON.stringify(rows));
                res.end();
            }else{
                rows=[];
                res.write(JSON.stringify(rows));
                res.end();
            }
        } else {
            console.log("Query failed");
        }
    });
});

http.listen(8080,function(){
    console.log("Listening on http://127.0.0.1:8080/");
});


