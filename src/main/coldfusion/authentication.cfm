```coldfusion
<cfcomponent>

    <cfset var oidcLibrary = createObject("java", "src.main.java.OIDCLibrary")>
    <cfset var databaseConnection = createObject("component", "src.main.coldfusion.database")>
    <cfset var errorHandling = createObject("component", "src.main.coldfusion.error_handling")>

    <cffunction name="authenticateUser" access="public" returntype="boolean">
        <cfargument name="username" type="string" required="yes">
        <cfargument name="password" type="string" required="yes">

        <cfset var authenticationResult = false>
        <cfset var userInfo = {}>

        <cftry>
            <cfset userInfo = oidcLibrary.authenticateUser(arguments.username, arguments.password)>
            <cfif structKeyExists(userInfo, "id")>
                <cfset session.userID = userInfo.id>
                <cfset session.userName = userInfo.name>
                <cfset session.userEmail = userInfo.email>
                <cfset authenticationResult = true>
            </cfif>

            <cfcatch type="any">
                <cfset errorHandling.logError(cfcatch)>
                <cfset authenticationResult = false>
            </cfcatch>
        </cftry>

        <cfreturn authenticationResult>
    </cffunction>

</cfcomponent>
```