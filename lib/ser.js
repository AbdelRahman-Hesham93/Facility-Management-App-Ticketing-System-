var express = require('express');
var bodyParser = require('body-parser');
var oracledb = require('oracledb');
var PORT = process.env.PORT || 5000;
var app = express();
var connectionProperties = {
    user: process.env.DBAAS_USER_NAME || "hr",
    password: process.env.DBAAS_USER_PASSWORD || "123",
    connectString: process.env.DBAAS_DEFAULT_CONNECT_DESCRIPTOR || "localhost/xe"
};

function doRelease(connection) {
    connection.release(function (err) {
        if (err) {
            console.error(err.message);
        }
    });
}

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json({ type: '*/*' }));

var router = express.Router();
router.use(function (request, response, next) {
    console.log("REQUEST:" + request.method + "   " + request.url);
    console.log("BODY:" + JSON.stringify(request.body));
    response.setHeader('Access-Control-Allow-Origin', '*');
    response.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
    response.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');
    response.setHeader('Access-Control-Allow-Credentials', true);
    next();
});


/**
 * GET /request
 * Returns a list of requests
 */
router.route('/request').get(function (request, response) {
    console.log("GET REQUESTS");
    oracledb.getConnection(connectionProperties, function (err, connection) {
        if (err) {
            console.error(err.message);
            response.status(500).send("Error connecting to DB");
            return;
        }
        connection.execute("SELECT * FROM REQUESTS", {},
            { outFormat: oracledb.OBJECT },
            function (err, result) {
                if (err) {
                    console.error(err.message);
                    response.status(500).send("Error getting data from DB");
                    doRelease(connection);
                    return;
                }
                console.log("RESULTSET:" + JSON.stringify(result));
                var requests = result.rows; // No need to manually map the fields
                response.json(requests);
                doRelease(connection);
            });
    });
});

/**
 * POST /request
 * Saves a new request
 */
router.route('/request').post(function (request, response) {
    console.log("POST REQUEST:");
    oracledb.getConnection(connectionProperties, function (err, connection) {
        if (err) {
            console.error(err.message);
            response.status(500).send("Error connecting to DB");
            return;
        }

        var body = request.body;

        connection.execute("INSERT INTO REQUESTS (IT_REQUESTS) VALUES (:itRequest)",
            [body.IT_REQUESTS],
            function (err, result) {
                if (err) {
                    console.error(err.message);
                    response.status(500).send("Error saving request to DB");
                    doRelease(connection);
                    return;
                }
                response.end();
                doRelease(connection);
            });
    });
});

app.use('/', router);

app.listen(PORT, function () {
    console.log(`Server is running on port ${PORT}`);
});
