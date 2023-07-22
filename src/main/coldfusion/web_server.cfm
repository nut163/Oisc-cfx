```coldfusion
<!--- Web Server Configuration --->

<cfset webServerSettings = {
    "serverType": "Apache", <!--- or "IIS" --->
    "serverVersion": "2.4", <!--- version of your server --->
    "serverHost": "localhost", <!--- host of your server --->
    "serverPort": "80", <!--- port of your server --->
    "serverAdmin": "admin@example.com", <!--- admin email of your server --->
    "documentRoot": "/var/www/html", <!--- document root of your server --->
    "serverName": "localhost", <!--- name of your server --->
    "serverAlias": "www.example.com", <!--- alias of your server --->
    "errorLog": "${APACHE_LOG_DIR}/error.log", <!--- error log of your server --->
    "customLog": "${APACHE_LOG_DIR}/access.log combined" <!--- custom log of your server --->
}>

<!--- Set Web Server Settings --->

<cfset setWebServerSettings(webServerSettings)>

<!--- Function to Set Web Server Settings --->

<cffunction name="setWebServerSettings" access="public" returntype="void" output="false">
    <cfargument name="settings" type="struct" required="true">
    
    <cfset var key = "">
    
    <cfloop collection="#arguments.settings#" item="key">
        <cfset server[key] = arguments.settings[key]>
    </cfloop>
</cffunction>
```