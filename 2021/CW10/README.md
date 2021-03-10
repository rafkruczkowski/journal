# SAML vs oAuth
---
## SAML
### Solution it solves
SAML evolved from the business requirement to allow applications to de-couple authentication and the service the user is requesting. Similar to Kerberos, it uses a token (signed XML assertion) from a ticketing system (IDP) to grant access to the service (SP). In contrast to Kerberos, SAML uses HTTPS as the transport.

### Use cases
Web applications where the service can be internal to an organization or public where the service is multi-tenant. The focus of the solution is that the service does not need to store or maintain authentication passwords or know the level of access in the case of group or privilege. Group memberships can be centrally managed in AD, for example, users who are promoted and need elevated access to multiple services.

### Method it uses
A IDP (Identity Provider) usually bound with Active Directory or LDAP issues the assertions.
The SP (Service Provider) consumes the assertion, and with the embedded information enables the application with the appropriate level of access to the application.
Assertions are signed-XML within the HTTPS payload.
Signed security is maintained by PKI (Public Key Infrastructure), a trust relationship needs to be established with the IDP and SP in advance.

### Limitations of solution
SAML solves the problem of separating the service from the authentication but has limited features for authorization other than group membership. Additional extension using artifacts where the SP can query for additional parameters is available.
But the solution does not work well on mobile devices and API connections where the mobile device may not have a consistent IP and also the app may not have all the Javascript features of a full desktop browser.
But the main limitation of SAML is that it does not allow the user to easily view or consent to the authorization the SP is requesting from the IDPs APIs.

### Observations
SAML works great in an enterprise setting where there is little concern between the scope of what the SP may want to do with the information in the assertion from the IDP. But more widespread use of social applications and distributed teams that may not have a central IDP, SAML does not work as well. For example, when a user would like to limit sharing their birthday or profile photo, there is no way to allow the user to easily see that level of detail. Also, in 2010, mobile web browsers and apps had limited functionality and were not able to work around the security constraints such as [cross-site domain scripting](https://en.wikipedia.org/wiki/Cross-site_scripting) and need to access multiple API endpoints quickly within a user session.

---
## oAuth
### Solution it solves

oAuth initial focus was to solve the authorization limitation that SAML did not address where the user was unable to easily see the scope of the assertion. This evolved as public websites and apps requested limited information from a user, but were unable to convince end users that their services only had limited scope. Later as oAuth evolved and the stack was adapted for authentication, OpenID was released as an extension to oAuth to standardize authentication within the oAuth ecosystem.

### Use cases
A fictitious app, such as a COVID tracker, would like to collect the user location for contract tracing and also public statistics of location gatherings. The app would like this information from Google Maps that is already installed and using this information when moving around. Legal and public relations aside, the app developers notice that Google publishes the scopes for Google Services and writes their app to request those from the user. The user installs the app and then the app is able to access the Google API endpoint where that information is current. No other information is shared between Google and the App other than what was specified in the oAuth scope.

### Method it uses
oAuth is similar to SAML. The user opens the app or website of the service and selects the Authorization Provider that they would like for authorization. Then the user is redirected and proceeds to login, or if already is logged into their IDP, then their service will ask the user if they agree to the scope that the original application is requesting. Once permitted, the Authorization Server will generate an authorization code to the app’s server. That app’s backend server will then contact the Authorization Server and exchange that authentication code for a token that the users app will then use to contact the API endpoint directly. This exchange for a token increases security by not exposing the token to the end client device where it can be intercepted by proxies or browser plugins.

There is an alternative response type called implicit where the Authorization Server will send back a token without the additional handshake, this was needed for single-page-websites where the code ran in client-side Javascript and page reload was not possible. There is an updated method called PKCE that increases security by using hashes.

### Limitations of solution
oAuth did not define how authentication should be done. Different services developed different methods to perform authentication and then used the oAuth spec to do authorization. OpenID evolved to address the authentication limitations, but the adoption is not as widespread. In addition the code method that exchanges the authorization code for a token has limitations with some mobile devices and Javascript. There is an alternative method (Implicit Flow) where the token is issued without the exchange. In addition there are additional extensions such as PKCE that generate hashed values for the components that are exchanged in the process.

### Observations
oAuth is evolving. The initial requirement of authorization was addressed but the details around authentications were not defined, so several services adapted and generated their own methods. In addition, in 2010 mobile devices had many more limitations that they do now. Newer oAuth Javascript libraries address some of the older limitations and also newer extensions such as PKCE focus on the problems mobile APIs had and those same solutions are now moving to the desktop libraries too.

## Compare and Contrast
Both SAML and oAuth (with OpenID) address the same problems that Kerberos worked to address in the 1980’s. The problem of offering a service and keeping the store of user profiles with their credentials separate. Kerberos worked within the space of desktop, servers and printers all connected on a common network with multiple ports. As applications evolved to be based on the Web, the common transport was HTTPS. Microsoft evolved their Kerberos and LDAP implementation to ADFS where it was based on SAML. The SAML protocol uses HTTPS as transport and also has an assertion that was based on PKI to separate the authentication store from the service the user is accessing.
But as mobile devices became more popular and services and ID providers more widespread, the idea of one trusted domain was broken apart. Users wanted to see more details of the permissions they were allowing and also to have control.

oAuth addresses the authorization method by defining individual scopes on the API  side and then the application is able to select the ones it needs. When the user connects to the service via the IDP, they are able to see in human format the claims the application is requesting from IDP and API. At this point the user is able to accept or even modify the scopes they allow from their IDP to the service. SAML does have an artifact resolution method, but it’s based on group membership and it’s not as easy to define granular groups on API endpoints that map to particular functions the API may offer, it’s also a backend channel communication.

---
[Link to ToC](https://github.com/rafkruczkowski/journal)