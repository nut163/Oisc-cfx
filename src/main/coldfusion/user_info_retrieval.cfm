```coldfusion
<cfcomponent>

    <cffunction name="getUserInfo" access="public" returntype="struct">
        <cfargument name="accessToken" type="string" required="yes">
        
        <cfset var userInfo = structNew()>
        <cfset var oidcLibrary = createObject("java", "com.nimbusds.openid.connect.sdk.claims.UserInfo")>
        
        <cftry>
            <!--- Use the OIDC library to retrieve user info --->
            <cfset userInfo = oidcLibrary.getUserInfo(arguments.accessToken)>
            
            <cfcatch type="any">
                <!--- Handle errors --->
                <cfinclude template="error_handling.cfm">
            </cfcatch>
        </cftry>
        
        <!--- Return the user info --->
        <cfreturn userInfo>
    </cffunction>

</cfcomponent>
```