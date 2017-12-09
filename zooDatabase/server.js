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

if(process.env.DB_USERNAME && process.env.DB_PASSWORD) {
    console.log("Running remotely");
    var con = mysql.createConnection({
        host: process.env.DB_HOST,
        user: process.env.DB_USERNAME,
        password: process.env.DB_PASSWORD,
        database: process.env.DB_DATABASE
    });
}
else {
    console.log("Running locally");
    var con = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "###",
        database: "zoo"
    });
}


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

app.post('/addEmployee', function (req, res) {
   var name = req.body['name'];
   var salary = req.body['salary'];
   var role = req.body['role'];
   var query = "CALL addEmployee('"+ name + "', "+ salary + ", '" + role +"');";
    con.query(String(query),function(err,rows){
        //con.close();
        if(!err) {
            res.write("true");
            res.end();
        } else {
            console.log("Query failed");
        }
    });
});



app.post('/updateEmployee', function (req, res) {
    var name = req.body['name'];
    var salary = req.body['salary'];
    var role = req.body['role'];
    var query = "CALL updateEmployee('"+ name + "', "+ salary + ", '" + role +"');";
    con.query(String(query),function(err,rows){
        //con.close();
        if(!err) {
            res.write("true");
            res.end();
        } else {
            console.log("Query failed");
        }
    });
});

app.post('/addAnimal', function (req, res) {
    var name = req.body['name'];
    var speciesKey = req.body['speciesKey'];
    var medicalHistKey = req.body['medicalHistKey'];
    var animalPerforms = req.body['animalPerforms'];
    var exhibitKey = req.body['exhibitKey'];

    var query = "CALL addAnimal('"+ name + "', "+ speciesKey + ", " + medicalHistKey +
        ", " + exhibitKey + ", " + animalPerforms + ");";

    con.query(String(query),function(err,rows){
        //con.close();
        if(!err) {
            res.write("true");
            res.end();
        } else {
            console.log("Query failed");
        }
    });
});


app.post('/delAnimal', function (req, res) {
    var name = req.body['name'];
    var query = "CALL removeAnimal('"+ name + "');";
    con.query(String(query),function(err,rows){
        //con.close();
        if(!err) {
            res.write("true");
            res.end();
        } else {
            console.log("Query failed");
        }
    });
});


app.post('/delEmployee', function (req, res) {
    var name = req.body['name'];
    var query = "CALL removeEmployee('"+ name + "');";
    con.query(String(query),function(err,rows){
        //con.close();
        if(!err) {
            res.write("true");
            res.end();
        } else {
            console.log("Query failed");
        }
    });
});

app.post('/updateMedical', function (req, res){
   var id = req.body['id'];
   var date = req.body['date'];
   var query = "CALL updateMedicalHistory("+ id+", " + date +");";
   con.query(String(query), function(err,rows){
       if(!err) {
           res.write("true");
           res.end();
       }
       else {
           console.log("Query failed");
       }
   })
});


http.listen(8080,function(){
    console.log("Listening on http://127.0.0.1:8080/");
});


