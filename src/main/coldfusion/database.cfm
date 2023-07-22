```coldfusion
<cfscript>
    // Database connection parameters
    dbParams = {
        datasource: "myDataSource",
        username: "dbUser",
        password: "dbPassword"
    };

    // Function to establish a database connection
    function connectToDatabase() {
        try {
            dbConn = new query();
            dbConn.setDatasource(dbParams.datasource);
            dbConn.setUsername(dbParams.username);
            dbConn.setPassword(dbParams.password);
            return dbConn;
        } catch (any e) {
            include "error_handling.cfm";
            handleDatabaseConnectionError(e);
        }
    }

    // Function to close a database connection
    function closeDatabaseConnection() {
        try {
            dbConn.close();
        } catch (any e) {
            include "error_handling.cfm";
            handleDatabaseConnectionError(e);
        }
    }

    // Function to execute a query
    function executeQuery(sql, params) {
        try {
            query = dbConn.execute(sql, params);
            return query.getResult();
        } catch (any e) {
            include "error_handling.cfm";
            handleDatabaseQueryError(e);
        }
    }
</cfscript>
```