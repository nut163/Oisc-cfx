```coldfusion
<cfcomponent>

    <cffunction name="createSession" access="public" returntype="void">
        <cfargument name="userID" type="string" required="yes">
        <cfset var sessionData = structNew()>
        <cfset sessionData.userID = arguments.userID>
        <cfset sessionData.startTime = now()>
        <cfset sessionData.lastAccess = now()>
        <cfset session[arguments.userID] = sessionData>
    </cffunction>

    <cffunction name="getSession" access="public" returntype="struct">
        <cfargument name="userID" type="string" required="yes">
        <cfreturn session[arguments.userID]>
    </cffunction>

    <cffunction name="updateSession" access="public" returntype="void">
        <cfargument name="userID" type="string" required="yes">
        <cfset session[arguments.userID].lastAccess = now()>
    </cffunction>

    <cffunction name="invalidateSession" access="public" returntype="void">
        <cfargument name="userID" type="string" required="yes">
        <cfset structDelete(session, arguments.userID)>
    </cffunction>

</cfcomponent>
```