```coldfusion
<cfcomponent>

    <cffunction name="authorizeUser" access="public" returntype="boolean">
        <cfargument name="userID" type="string" required="yes">
        <cfargument name="userRole" type="string" required="yes">
        
        <cfset var authorized = false>
        
        <cftry>
            <cfquery name="getUserRole" datasource="#application.dsn#">
                SELECT role 
                FROM users 
                WHERE id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.userID#">
            </cfquery>
            
            <cfif getUserRole.role EQ arguments.userRole>
                <cfset authorized = true>
            </cfif>
            
            <cfcatch type="database">
                <cfinclude template="error_handling.cfm">
            </cfcatch>
        </cftry>
        
        <cfreturn authorized>
    </cffunction>

</cfcomponent>
```