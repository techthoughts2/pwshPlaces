<#
.SYNOPSIS
    Find Place request takes a text input and returns a place. The input can be any kind of Places text data, such as a name, address, or phone number.
.DESCRIPTION
    Performs a find place request with provided parameters.
    A text search is performed unless a properly formatted phone number is provided in which case
    a phonenumber search is completed. By default the location bias and language is IP based.
    Location bias and language can be controlled via parameters. The information returned in a normal
    call contains all basic field types. Additional field types including contact and atmosphere information
    can be called for but these carry an additional cost. The Find Place return does not return
    all fields of these more expensive calls and has a limited return. See notes for details.
.EXAMPLE
    Find-GMapPlace -Query "Krause's cafe"

    Returns place information for the query location biased by IP.
.EXAMPLE
    Find-GMapPlace -Query "Krause's cafe" -Language es

    Returns place information for the query location biased by IP and returns results in Spanish.
.EXAMPLE
    Find-GMapPlace -Query '+18306252807'

    Returns place information for the query location biased by IP.
.EXAMPLE
    Find-GMapPlace -Query 'cafe' -PointLatitude '29.7049806' -PointLongitude '-98.068343'

    Returns place information for the query location biased by provided lat/long point.
.EXAMPLE
    Find-GMapPlace -Query 'cafe' -PointLatitude '29.7049806' -PointLongitude '-98.068343' -Language en

    Returns place information for the query location biased by provided lat/long point and returns results in English.
.EXAMPLE
    Find-GMapPlace -Query 'cafe' -CircleLatitude '29.7049806' -CircleLongitude '-98.068343' -CircleRadius '8046'

    Returns place information for the query location biased by circle lat/long/radius.
.EXAMPLE
    Find-GMapPlace -Query 'cafe' -SouthLatitude '39.8592387' -WestLongitude '-75.295486' -NorthLatitude '40.0381942' -EastLongitude '-75.0064087'

    Returns place information for the query location biased by rectangular two lat/lng pairs in decimal degrees, representing the south/west and north/east points of a rectangle.
.EXAMPLE
    Find-GMapPlace -Query '+18306252807' -PointLatitude '29.7049806' -PointLongitude '-98.068343' -Contact -Atmosphere -Language en

    Returns place information for the query location biased by provided lat/long point with additional Contact and Atmosphere fields with results in English.
.EXAMPLE
    $findGMapPlaceSplat = @{
        Query          = '+18306252807'
        PointLatitude  = '29.7049806'
        PointLongitude = '-98.068343'
        Contact        = $true
        Atmosphere     = $true
        Language       = 'en'
    }
    Find-GMapPlace @findGMapPlaceSplat

    Returns place information for the query location biased by provided lat/long point with additional Contact and Atmosphere fields with results in English.
.PARAMETER Query
    Text input that identifies the search target, such as a name, address, or phone number. Phone numbers must be in international format (prefixed by a plus sign ("+"), followed by the country code, then the phone number itself)
.PARAMETER PointLatitude
    Prefer results in a specified area by specifying a single coordinate for the north–south position of a point on the Earth's surface.
.PARAMETER PointLongitude
    Prefer results in a specified area by specifying a single coordinate for the east–west position of a point on the Earths surface.
.PARAMETER CircleLatitude
    Prefer results in a specified area by specifying a radius plus lat/long - north–south position of a point on the Earth's surface.
.PARAMETER CircleLongitude
    Prefer results in a specified area by specifying a radius plus lat/long - east–west position of a point on the Earths surface.
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
    The language in which to return results.
.OUTPUTS
    GMap.Place
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

    Latitude and Longitude information can be easily retrieved using Invoke-GMapGeoCode

    If you provide faulty lat/long info the API call will default back to IP based locationbias.

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

    Example:
        https://maps.googleapis.com/maps/api/place/findplacefromtext/json?fields=formatted_address%2Cname%2Crating%2Copening_hours%2Cgeometry&input=Museum%20of%20Contemporary%20Art%20Australia&inputtype=textquery&key=YOUR_API_KEY

    Caution: Place Search requests and Place Details requests do not return the same fields.
    Place Search requests return a subset of the fields that are returned by Place Details requests.
    If the field you want is not returned by Place Search, you can use Place Search to get a place_id,
    then use that Place ID to make a Place Details request.
    ^ this essentially means you are better served with the find by using basic fields only.
    If you need additional information make a subsequent Place Details API call.

    Don't use the Contact or Atmosphere parameters of this function. They aren't worth it. If you need more detail use Get-GMapPlaceDetail

    This function includes Google Maps features and content; use of Google Maps features and content is subject to the terms of service and Google privacy (linked below).
.COMPONENT
    pwshPlaces
.LINK
    https://github.com/techthoughts2/pwshPlaces/blob/master/docs/Find-GMapPlace.md
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
        [languages]$Language
    )

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
    } #switch_parametersetname

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
    $fAPIKey = '&key={0}' -f $env:GoogleAPIKey
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
        Write-Warning -Message 'Did not get a succcessful return from Google Geocode API endpoint'
        $finalResults = $results
    }
    else {
        $finalResults = ($results.candidates | Format-GMapPlace)
    }

    return $finalResults

} #Find-GMapPlace
