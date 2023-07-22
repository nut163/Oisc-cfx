```coldfusion
<cfcomponent>

    <cffunction name="handleError" access="public" returntype="void">
        <cfargument name="errorCode" type="numeric" required="yes">
        <cfargument name="errorMessage" type="string" required="yes">
        <cfargument name="errorDetail" type="string" required="no" default="">

        <cflog file="errorLog" text="#errorCode# - #errorMessage# - #errorDetail#">

        <cfif IsDefined('session')>
            <cfset session.errorMessage = errorMessage>
            <cfset session.errorDetail = errorDetail>
        </cfif>

        <cflocation url="errorPage.cfm" addtoken="no">
    </cffunction>

    <cffunction name="handleAuthenticationError" access="public" returntype="void">
        <cfargument name="errorCode" type="numeric" required="yes">
        <cfargument name="errorMessage" type="string" required="yes">
        <cfargument name="errorDetail" type="string" required="no" default="">

        <cfset handleError(errorCode, errorMessage, errorDetail)>
    </cffunction>

    <cffunction name="handleTokenError" access="public" returntype="void">
        <cfargument name="errorCode" type="numeric" required="yes">
        <cfargument name="errorMessage" type="string" required="yes">
        <cfargument name="errorDetail" type="string" required="no" default="">

        <cfset handleError(errorCode, errorMessage, errorDetail)>
    </cffunction>

    <cffunction name="handleCommunicationError" access="public" returntype="void">
        <cfargument name="errorCode" type="numeric" required="yes">
        <cfargument name="errorMessage" type="string" required="yes">
        <cfargument name="errorDetail" type="string" required="no" default="">

        <cfset handleError(errorCode, errorMessage, errorDetail)>
    </cffunction>

</cfcomponent>
```