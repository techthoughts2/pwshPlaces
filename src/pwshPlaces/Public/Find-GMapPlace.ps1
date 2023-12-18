<#
.SYNOPSIS
    Searches for a place using text input, returning key details about the location.
.DESCRIPTION
    The Find-GMapPlace function uses Google Maps API to perform text-based searches for places,
    such as businesses, landmarks, or addresses. It supports searches by name, address, or phone number
    (in international format). The function defaults to using the user's IP address for location bias,
    but this can be adjusted with additional parameters. Basic search results are provided without
    extra cost, while Contact and Atmosphere information are available at a higher rate.
    Note: For more detailed information at reduced cost, consider using Get-GMapPlaceDetail.
.EXAMPLE
    Find-GMapPlace -Query "Krause's cafe" -GoogleAPIKey $googleAPIKey

    Searches for "Krause's cafe," returning results biased by the user's IP location.
.EXAMPLE
    Find-GMapPlace -Query "Krause's cafe" -Language es -GoogleAPIKey $googleAPIKey

    Searches for "Krause's cafe" and returns results in Spanish, biased by IP location.
.EXAMPLE
    Find-GMapPlace -Query '+18306252807' -GoogleAPIKey $googleAPIKey

    Searches using a phone number, returning place information with an IP location bias.
.EXAMPLE
    Find-GMapPlace -Query 'cafe' -PointLatitude '29.7049806' -PointLongitude '-98.068343' -GoogleAPIKey $googleAPIKey

    Searches for cafes near specified coordinates.
.EXAMPLE
    Find-GMapPlace -Query 'cafe' -PointLatitude '29.7049806' -PointLongitude '-98.068343' -Language en -GoogleAPIKey $googleAPIKey

    Searches for cafes near specified coordinates and returns results in English.
.EXAMPLE
    Find-GMapPlace -Query 'cafe' -CircleLatitude '29.7049806' -CircleLongitude '-98.068343' -CircleRadius '8046' -GoogleAPIKey $googleAPIKey

    Searches for cafes within a specified radius around given coordinates.
.EXAMPLE
    Find-GMapPlace -Query 'cafe' -SouthLatitude '39.8592387' -WestLongitude '-75.295486' -NorthLatitude '40.0381942' -EastLongitude '-75.0064087' -GoogleAPIKey $googleAPIKey

    Searches for cafes within a defined rectangular area.
.EXAMPLE
    Find-GMapPlace -Query '+18306252807' -PointLatitude '29.7049806' -PointLongitude '-98.068343' -Contact -Atmosphere -Language en -GoogleAPIKey $googleAPIKey

    Searches using a phone number near specified coordinates, requesting additional Contact and Atmosphere information in English.
.EXAMPLE
    $findGMapPlaceSplat = @{
        Query          = '+18306252807'
        PointLatitude  = '29.7049806'
        PointLongitude = '-98.068343'
        Contact        = $true
        Atmosphere     = $true
        Language       = 'en'
        GoogleAPIKey   = $googleAPIKey
    }
    Find-GMapPlace @findGMapPlaceSplat

    Searches using a phone number near specified coordinates, requesting additional Contact and Atmosphere information in English.
.PARAMETER Query
    The search input, such as a place name, address, or phone number in international format.
.PARAMETER PointLatitude
    Specifies the latitude for location-based searches. Single coordinate for the north–south position of a point on the Earth's surface.
.PARAMETER PointLongitude
    Specifies the longitude for location-based searches. Single coordinate for the east–west position of a point on the Earth's surface.
.PARAMETER CircleLatitude
    Prefer results in a specified area by specifying a radius plus lat/long - north–south position of a point on the Earth's surface.
.PARAMETER CircleLongitude
    Prefer results in a specified area by specifying a radius plus lat/long - east–west position of a point on the Earth's surface.
.PARAMETER CircleRadius
    Prefer results in a specified area by specifying a radius plus lat/long - radius in meters
.PARAMETER SouthLatitude
    Prefer results in a specified area by specifying two lat/lng pairs representing the south/west and north/east points of a rectangle - south latitude
.PARAMETER WestLongitude
    Prefer results in a specified area by specifying two lat/lng pairs representing the south/west and north/east points of a rectangle - west longitude
.PARAMETER NorthLatitude
    Prefer results in a specified area by specifying two lat/lng pairs representing the south/west and north/east points of a rectangle - north latitude
.PARAMETER EastLongitude
    Prefer results in a specified area by specifying two lat/lng pairs representing the south/west and north/east points of a rectangle - east longitude
.PARAMETER Contact
    Returns contact related information about the result - contact fields are billed at a higher rate.
.PARAMETER Atmosphere
    Returns atmosphere related information including reviews and pricing about the result - atmosphere fields are billed at a higher rate.
.PARAMETER Language
    Specifies the language for the search results.
.PARAMETER GoogleAPIKey
    Google API Key
.OUTPUTS
    GMap.Place
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

    - Use Invoke-GMapGeoCode if you need to retrieve latitude and longitude information.
    - Basic field types are included without additional cost. Contact and Atmosphere fields incur extra charges.
        - Don't use the Contact or Atmosphere parameters of this function. They aren't worth it.
            - For more detailed place information, consider Get-GMapPlaceDetail.
    - Phone numbers must be in international format (prefixed by a plus sign ("+"), followed by the country code, then the phone number itself)
    - If you provide faulty lat/long info the API call will default back to IP based locationbias.

    Direct API Example:
        https://maps.googleapis.com/maps/api/place/findplacefromtext/json?fields=formatted_address%2Cname%2Crating%2Copening_hours%2Cgeometry&input=Museum%20of%20Contemporary%20Art%20Australia&inputtype=textquery&key=YOUR_API_KEY

    Ensure you have a valid Google API Key.
        How to get a Google API Key:
            https://pwshplaces.readthedocs.io/en/latest/GoogleMapsAPI/#how-to-get-a-google-maps-api-key

    For basic place information, Find-GMapPlace is sufficient. However, if you need more detailed data
    about a place, use Get-GMapPlaceDetail with the Place ID obtained from `Find-GMapPlace`.
    For a detailed guide on using these functions effectively, please refer to our documentation:
    [here](link-to-detailed-guide).

    This function includes Google Maps features and content; use of Google Maps features and content is subject to the terms of service and Google privacy (linked below).
.COMPONENT
    pwshPlaces
.LINK
    https://pwshplaces.readthedocs.io/en/latest/Find-GMapPlace
.LINK
    https://developers.google.com/maps/documentation/places/web-service/search-find-place
.LINK
    https://maps.googleapis.com/maps/api/place/findplacefromtext/output?parameters
.LINK
    https://developers.google.com/maps/faq#languagesupport
.LINK
    https://cloud.google.com/maps-platform/terms/
.LINK
    https://www.google.com/policies/privacy/
#>
function Find-GMapPlace {
    [CmdletBinding(
        PositionalBinding = $false,
        DefaultParameterSetName = 'textquery')]
    param (
        # 'Phone numbers must be in international format (prefixed by a plus sign ("+"), followed by the country code, then the phone number itself)')]
        [Parameter(Mandatory = $true,
            ParameterSetName = 'textquery',
            HelpMessage = 'Text input that identifies the search target, such as a name, address, or phone number.')]
        [Parameter(ParameterSetName = 'Point', Mandatory = $false)]
        [Parameter(ParameterSetName = 'Circle', Mandatory = $false)]
        [Parameter(ParameterSetName = 'Rectangle', Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$Query,

        [Parameter(Mandatory = $false,
            ParameterSetName = 'Point',
            HelpMessage = 'Location bias by point lat')]
        [ValidateNotNullOrEmpty()]
        [string]$PointLatitude,

        [Parameter(Mandatory = $false,
            ParameterSetName = 'Point',
            HelpMessage = 'Location bias by point long')]
        [ValidateNotNullOrEmpty()]
        [string]$PointLongitude,

        [Parameter(Mandatory = $false,
            ParameterSetName = 'Circle',
            HelpMessage = 'Location bias circular lat')]
        [ValidateNotNullOrEmpty()]
        [string]$CircleLatitude,

        [Parameter(Mandatory = $false,
            ParameterSetName = 'Circle',
            HelpMessage = 'Location bias circular long')]
        [ValidateNotNullOrEmpty()]
        [string]$CircleLongitude,

        [Parameter(Mandatory = $false,
            ParameterSetName = 'Circle',
            HelpMessage = 'Location bias circular radius')]
        [ValidateNotNullOrEmpty()]
        [string]$CircleRadius,

        # A string specifying two lat/lng pairs in decimal degrees, representing the south/west and north/east points of a rectangle.
        [Parameter(Mandatory = $true,
            ParameterSetName = 'Rectangle',
            HelpMessage = 'Location bias rectangle south lat')]
        [ValidateNotNullOrEmpty()]
        [string]$SouthLatitude,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'Rectangle',
            HelpMessage = 'Location bias rectangle west long')]
        [ValidateNotNullOrEmpty()]
        [string]$WestLongitude,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'Rectangle',
            HelpMessage = 'Location bias rectangle north lat')]
        [ValidateNotNullOrEmpty()]
        [string]$NorthLatitude,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'Rectangle',
            HelpMessage = 'Location bias rectangle east long')]
        [ValidateNotNullOrEmpty()]
        [string]$EastLongitude,

        [Parameter(Mandatory = $false,
            HelpMessage = 'return additional contact information')]
        [switch]$Contact,

        [Parameter(Mandatory = $false,
            HelpMessage = 'return additional atmosphere information')]
        [switch]$Atmosphere,

        [Parameter(Mandatory = $false,
            HelpMessage = 'The language in which to return results')]
        [languages]$Language,

        [Parameter(Mandatory = $true,
            HelpMessage = 'Google API Key')]
        [ValidateNotNullOrEmpty()]
        [string]$GoogleAPIKey
    )

    <#
        API Notes:
        Required parameters
            input
                Text input that identifies the search target, such as a name, address, or phone number. The input must be a string.
            inputtype
                The type of input. This can be one of either textquery or phonenumber.
                    Phone numbers must be in international format (prefixed by a plus sign ("+"), followed by the country code, then the phone number itself)
        Optional parameters
            fields
                Billing Categories
                    Basic - no charge
                    Contact
                    Atmosphere
            language
            locationbias
                Prefer results in a specified area, by specifying either a radius plus lat/lng, or two lat/lng pairs representing the points of a rectangle. If this parameter is not specified, the API uses IP address biasing by default.

        IP bias: Instructs the API to use IP address biasing. Pass the string ipbias (this option has no additional parameters).
        Point: A single lat/lng coordinate. Use the following format: point:lat,lng.
        Circular: A string specifying radius in meters, plus lat/lng in decimal degrees. Use the following format: circle:radius@lat,lng.
        Rectangular: A string specifying two lat/lng pairs in decimal degrees
    #>

    Write-Debug -Message ($PSCmdlet.ParameterSetName)

    $uri = '{0}{1}' -f $googleMapsBaseURI, 'place/findplacefromtext/json?'
    Write-Debug -Message ('Base function URI: {0}' -f $uri)

    $fQuery = 'input={0}' -f [uri]::EscapeDataString($Query)
    $uri += $fQuery

    if ($Query -match '^\+\d+$') {
        Write-Debug -Message 'Phone number input type'
        $fInputType = '&inputtype=phonenumber'
    }
    else {
        $fInputType = '&inputtype=textquery'
    }
    $uri += $fInputType

    switch ($PSCmdlet.ParameterSetName) {
        'Point' {
            Write-Debug -Message 'Point specified'
            $combinedPoint = ':{0},{1}' -f $PointLatitude, $PointLongitude
            $fLocationBias = '&locationbias=point{0}' -f [uri]::EscapeDataString($combinedPoint)
            $uri += $fLocationBias
        } #point
        'Circle' {
            Write-Debug -Message 'Circle specified'
            $combinedCircle = ':{0}@{1},{2}' -f $CircleRadius, $CircleLatitude, $CircleLongitude
            $fLocationBias = '&locationbias=circle{0}' -f [uri]::EscapeDataString($combinedCircle)
            $uri += $fLocationBias
        } #circle
        'Rectangle' {
            Write-Debug -Message 'Rectangle specified'
            $combinedRectangle = ':{0},{1}|{2},{3}' -f $SouthLatitude, $WestLongitude, $NorthLatitude, $EastLongitude
            $fLocationBias = '&locationbias=rectangle{0}' -f [uri]::EscapeDataString($combinedRectangle)
            $uri += $fLocationBias
        } #rectangle
    } #switch_ParameterSetName

    if ($Language) {
        Write-Debug -Message ('Language: {0}' -f $Language)
        $fLanguage = '&language={0}' -f $Language
        $uri += $fLanguage
    }

    $fFields = '&fields='
    $basicFields = 'business_status,formatted_address,geometry,icon,icon_mask_base_uri,icon_background_color,name,photo,place_id,plus_code,type'
    $fFields += [uri]::EscapeDataString($basicFields)
    if ($Contact) {
        $contactFields = ',opening_hours'
        $fFields += [uri]::EscapeDataString($contactFields)
    }
    if ($Atmosphere) {
        $atmosphereFields = ',price_level,rating,user_ratings_total'
        $fFields += [uri]::EscapeDataString($atmosphereFields)
    }
    $uri += $fFields

    Write-Verbose -Message ('Querying Google API: {0}' -f $uri)

    Write-Debug -Message 'Adding API key'
    $fAPIKey = '&key={0}' -f $GoogleAPIKey
    $uri += $fAPIKey
    Write-Debug -Message ('Final URI: {0}' -f $uri)

    $invokeRestMethodSplat = @{
        Uri         = $uri
        ErrorAction = 'Stop'
    }
    try {
        $results = Invoke-RestMethod @invokeRestMethodSplat
    }
    catch {
        throw $_
    }

    if ($results.status -ne 'OK') {
        Write-Warning -Message 'Did not get a successful return from Google Geocode API endpoint'
        $finalResults = $results
    }
    else {
        $finalResults = ($results.candidates | Format-GMapPlace)
    }

    return $finalResults

} #Find-GMapPlace
