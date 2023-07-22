```java
import com.nimbusds.oauth2.sdk.*;
import com.nimbusds.oauth2.sdk.id.*;
import com.nimbusds.oauth2.sdk.token.*;
import com.nimbusds.openid.connect.sdk.*;
import com.nimbusds.openid.connect.sdk.claims.*;

import java.net.URI;
import java.util.*;

public class OIDCLibrary {

    private String clientID;
    private String clientSecret;
    private String redirectURI;
    private String providerURI;

    public OIDCLibrary(String clientID, String clientSecret, String redirectURI, String providerURI) {
        this.clientID = clientID;
        this.clientSecret = clientSecret;
        this.redirectURI = redirectURI;
        this.providerURI = providerURI;
    }

    public AuthorizationRequest createAuthRequest() {
        Scope scope = new Scope("openid", "profile", "email");
        State state = new State();
        Nonce nonce = new Nonce();

        ClientID clientID = new ClientID(this.clientID);
        URI redirectURI = URI.create(this.redirectURI);

        AuthorizationRequest request = new AuthorizationRequest.Builder(
                new ResponseType(ResponseType.Value.CODE), clientID)
                .scope(scope)
                .state(state)
                .nonce(nonce)
                .endpointURI(URI.create(this.providerURI))
                .build();

        return request;
    }

    public OIDCTokens processAuthResponse(AuthorizationResponse response) {
        if (!response.indicatesSuccess()) {
            throw new RuntimeException("Authentication failed");
        }

        AuthorizationSuccessResponse successResponse = (AuthorizationSuccessResponse) response;

        AuthorizationCodeGrant grant = new AuthorizationCodeGrant(
                successResponse.getAuthorizationCode(), URI.create(this.redirectURI));

        ClientID clientID = new ClientID(this.clientID);
        Secret clientSecret = new Secret(this.clientSecret);

        ClientAuthentication clientAuth = new ClientSecretBasic(clientID, clientSecret);

        TokenResponse tokenResponse;
        try {
            tokenResponse = OIDCTokenResponseParser.parse(grant.toHTTPRequest().send());
        } catch (Exception e) {
            throw new RuntimeException("Failed to retrieve tokens", e);
        }

        if (!tokenResponse.indicatesSuccess()) {
            throw new RuntimeException("Failed to retrieve tokens");
        }

        OIDCTokenResponse oidcResponse = (OIDCTokenResponse) tokenResponse;
        OIDCTokens tokens = oidcResponse.getOIDCTokens();

        return tokens;
    }

    public UserInfo getUserInfo(OIDCTokens tokens) {
        UserInfoRequest userInfoReq = new UserInfoRequest(URI.create(this.providerURI), tokens.getBearerAccessToken());

        UserInfoResponse userInfoResponse;
        try {
            userInfoResponse = UserInfoResponse.parse(userInfoReq.toHTTPRequest().send());
        } catch (Exception e) {
            throw new RuntimeException("Failed to retrieve user info", e);
        }

        if (!userInfoResponse.indicatesSuccess()) {
            throw new RuntimeException("Failed to retrieve user info");
        }

        UserInfoSuccessResponse successResponse = (UserInfoSuccessResponse) userInfoResponse;
        UserInfo userInfo = successResponse.getUserInfo();

        return userInfo;
    }
}
```