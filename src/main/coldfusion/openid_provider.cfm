```coldfusion
<cfcomponent>

    <cfset this.openIDProviderURL = "https://your-openid-provider.com">
    <cfset this.clientID = "your-client-id">
    <cfset this.clientSecret = "your-client-secret">
    <cfset this.redirectURI = "https://your-redirect-uri.com">

    <cffunction name="getOpenIDProviderURL" access="public" returntype="string">
        <cfreturn this.openIDProviderURL>
    </cffunction>

    <cffunction name="getClientID" access="public" returntype="string">
        <cfreturn this.clientID>
    </cffunction>

    <cffunction name="getClientSecret" access="public" returntype="string">
        <cfreturn this.clientSecret>
    </cffunction>

    <cffunction name="getRedirectURI" access="public" returntype="string">
        <cfreturn this.redirectURI>
    </cffunction>

</cfcomponent>
```
This ColdFusion component represents the OpenID Provider settings. It includes the OpenID Provider URL, client ID, client secret, and redirect URI. The functions are used to retrieve these settings. You should replace the placeholders with your actual OpenID Provider settings.