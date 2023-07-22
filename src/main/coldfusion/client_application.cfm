```coldfusion
<cfscript>
    // Import the OIDC library
    createObject("java", "com.nimbusds.openid.connect.sdk.oidc");

    // Define the OpenID Provider's URL
    openid_provider_url = "https://openid.example.com";

    // Define the client's redirect URI
    redirect_uri = "https://client.example.com/callback";

    // Define the client's ID and secret
    client_id = "your-client-id";
    client_secret = "your-client-secret";

    // Create an OIDC client
    oidc_client = createObject("java", "com.nimbusds.openid.connect.sdk.oidc.Client");
    oidc_client.setProviderURL(openid_provider_url);
    oidc_client.setRedirectURI(redirect_uri);
    oidc_client.setClientID(client_id);
    oidc_client.setClientSecret(client_secret);

    // Create an OIDC request
    oidc_request = createObject("java", "com.nimbusds.openid.connect.sdk.oidc.Request");
    oidc_request.setClient(oidc_client);

    // Redirect the user to the OpenID Provider's authorization endpoint
    location(url=oidc_request.getAuthorizationURL(), addtoken=false);
</cfscript>

<cfif isDefined("URL.code")>
    <cfscript>
        // The user has been redirected back from the OpenID Provider

        // Get the authorization code from the URL
        authorization_code = URL.code;

        // Exchange the authorization code for an access token
        access_token = oidc_request.exchangeCodeForAccessToken(authorization_code);

        // Store the access token in the session
        session.access_token = access_token;

        // Redirect the user to the home page
        location(url="home.cfm", addtoken=false);
    </cfscript>
</cfif>
```