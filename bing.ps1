# Bing Maps REST Services
<#
https://docs.microsoft.com/en-us/bingmaps/rest-services/

https://docs.microsoft.com/en-us/bingmaps/rest-services/getting-started-with-the-bing-maps-rest-services

Bing Maps Locations API
https://docs.microsoft.com/en-us/bingmaps/rest-services/locations/

Bing Maps API Best Practices
https://docs.microsoft.com/en-us/bingmaps/getting-started/bing-maps-api-best-practices

When a request is rate limited, the response will return no results. This may be confusing at
first as it looks like Bing Maps was unable to find results. To indicate that the request was rate
limited a flag is added to the header of the response (X-MS-BM-WS-INFO) which is set to the
value of 1 as documented the Status Codes and Error Handling page.
https://msdn.microsoft.com/en-us/library/ff701703.aspx

Supported Culture Codes
https://docs.microsoft.com/en-us/bingmaps/rest-services/common-parameters-and-types/supported-culture-codes

The Bing Maps geocoder will attempt to find the closest match as possible to your query. In some cases,
it will not be able to find an exact match. This is where the match code parameter of the returned results
becomes useful. The match code parameter is an array of values and can have any combination of the following
three values; Good, Ambiguous, or UpHierarchy. If you are only interested in exact matches then keep a look
out for UpHierachy as this indicates that your exact query was not found but an upper level address value was found.

REST services take your IP address into consideration when making a request
o help reduce this issue you can set the userIp parameter of the request to 127.0.0.1.
This will trick the service into thinking you are making the call from a local application
and cause it to ignore your IP address.

Base URL Structure
https://docs.microsoft.com/en-us/bingmaps/rest-services/common-parameters-and-types/base-url-structure
https://dev.virtualearth.net/REST/version/restApi/resourcePath?queryParameters&key=BingMapsKey
http://dev.virtualearth.net/REST/v1/Locations?q=seattle&output=xml&key=BingMapsKey

Limit your coordinates to 6 decimal places.
don’t encode coordinate based locations.

Output Parameters
    https://docs.microsoft.com/en-us/bingmaps/rest-services/common-parameters-and-types/output-parameters
Culture Parameter
    https://docs.microsoft.com/en-us/bingmaps/rest-services/common-parameters-and-types/culture-parameter
    &c=
User Context Parameters
    https://docs.microsoft.com/en-us/bingmaps/rest-services/common-parameters-and-types/user-context-parameters
Types
    https://docs.microsoft.com/bingmaps/rest-services/common-parameters-and-types/type-identifiers/
#>