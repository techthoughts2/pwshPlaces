<#
.SYNOPSIS
    Returns a list of business entities centered around a location or a geographic region
.DESCRIPTION
    Performs a find place request with provided parameters.
    A text search is performed that returns a list of business entities.
    By default the location bias is IP based.
    Location bias and language can be controlled via parameters.
.EXAMPLE
    Find-BingPlace -Query "Krause's cafe"

    Returns place information for the query location biased by IP.
.EXAMPLE
    Find-BingPlace -Query "Krause's cafe" -Language es

    Returns place information for the query location biased by IP and returns a few portion of the results in Spanish.
.EXAMPLE
    Find-BingPlace -Query 'cafe' -PointLatitude '29.7049806' -PointLongitude '-98.068343'

    Returns place information for the query location biased by provided lat/long point.
.EXAMPLE
    Find-BingPlace -Query 'cafe' -CircleLatitude '29.7049806' -CircleLongitude '-98.068343' -CircleRadius '5000'

    Returns place information for the query location biased by circle lat/long/radius.
.EXAMPLE
    Find-BingPlace -Query 'cafe' -SouthLatitude '39.8592387' -WestLongitude '-75.295486' -NorthLatitude '40.0381942' -EastLongitude '-75.0064087'

    Returns place information for the query location biased by rectangular two lat/lng pairs in decimal degrees, representing the south/west and north/east points of a rectangle.
.EXAMPLE
    Find-BingPlace -Query 'cafe' -PointLatitude '29.7049806' -PointLongitude '-98.068343' -Language en -MaxResults 20

    Returns place information for the query location biased by provided lat/long point with a maximum of 20 results in English.
.EXAMPLE
    $findBingPlaceSplat = @{
        Query          = 'cafe'
        PointLatitude  = '29.7049806'
        PointLongitude = '-98.068343'
        Language       = 'en'
        MaxResults     = 20
    }
    Find-BingPlace @findBingPlaceSplat

    Returns place information for the query location biased by provided lat/long point with a maximum of 20 results in English.
.PARAMETER Query
    A string that contains information about a location, such as an address or landmark name.
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
.PARAMETER RegionBias
    The region code, specified as a ccTLD ("top-level domain") two-character value.
.PARAMETER Language
    The language in which to return results.
.OUTPUTS
    Output from this cmdlet (if any)
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

    Example:
        http://dev.virtualearth.net/REST/v1/Locations?countryRegion={countryRegion}&adminDistrict={adminDistrict}&locality={locality}&postalCode={postalCode}&addressLine={addressLine}&userLocation={userLocation}&userIp={userIp}&usermapView={usermapView}&includeNeighborhood={includeNeighborhood}&maxResults={maxResults}&key={BingMapsKey}
.COMPONENT
    pwshPlaces
.LINK
    https://github.com/techthoughts2/pwshPlaces/blob/master/docs/Find-BingPlace.md
.LINK
    https://docs.microsoft.com/bingmaps/rest-services/locations/find-a-location-by-query
.LINK
    https://docs.microsoft.com/bingmaps/rest-services/common-parameters-and-types/user-context-parameters
.LINK
    https://docs.microsoft.com/bingmaps/rest-services/common-parameters-and-types/supported-culture-codes
.LINK
    https://www.microsoft.com/maps/product/terms.html
.LINK
    https://privacy.microsoft.com/en-us/privacystatement
#>
function Find-BingPlace {
    [CmdletBinding(
        PositionalBinding = $false,
        DefaultParameterSetName = 'textquery')]
    param (
        [Parameter(Mandatory = $true,
            ParameterSetName = 'textquery',
            HelpMessage = 'A string that contains information about a location, such as an address or landmark name')]
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
        [ValidateRange(0, 5000)]
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
            HelpMessage = 'The region code, specified as a ccTLD')]
        [ccTLD]$RegionBias,

        [Parameter(Mandatory = $false,
            HelpMessage = 'The language in which to return results')]
        [languages]$Language,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Specifies the maximum number of locations to return in the response')]
        [ValidateRange(1, 20)]
        [int]$MaxResults
    )

    Write-Debug -Message ($PSCmdlet.ParameterSetName)

    # $uri = '{0}{1}' -f $bingMapsBaseURI, 'v1/Locations?output=json'
    $uri = '{0}{1}' -f $bingMapsBaseURI, 'v1/LocalSearch?output=json'
    Write-Debug -Message ('Base function URI: {0}' -f $uri)

    $fQuery = '&query={0}' -f [uri]::EscapeDataString($Query)
    $uri += $fQuery

    switch ($PSCmdlet.ParameterSetName) {
        'Point' {
            Write-Debug -Message 'Point specified'
            $combinedPoint = '{0},{1}' -f $PointLatitude, $PointLongitude
            # $fLocationBias = '&userLocation={0}' -f $combinedPoint
            $fLocationBias = '&userLocation={0}' -f [uri]::EscapeDataString($combinedPoint)
            $uri += $fLocationBias
        } #point
        'Circle' {
            Write-Debug -Message 'Circle specified'
            $combinedCircle = '{0},{1},{2}' -f $CircleLatitude, $CircleLongitude, $CircleRadius
            $fLocationBias = '&userCircularMapView={0}' -f [uri]::EscapeDataString($combinedCircle)
            $uri += $fLocationBias
        } #circle
        'Rectangle' {
            Write-Debug -Message 'Rectangle specified'
            $combinedRectangle = '{0},{1},{2},{3}' -f $SouthLatitude, $WestLongitude, $NorthLatitude, $EastLongitude
            # $fLocationBias = '&userMapView={0}' -f $combinedRectangle
            $fLocationBias = '&userMapView={0}' -f [uri]::EscapeDataString($combinedRectangle)
            $uri += $fLocationBias
        } #rectangle
    } #switch_parametersetname

    if ($RegionBias) {
        Write-Debug -Message ('RegionBias: {0}' -f $RegionBias)
        $fRegion = '&userRegion={0}' -f $RegionBias
        $uri += $fRegion
    }
    if ($MaxResults) {
        Write-Debug -Message ('MaxResults: {0}' -f $MaxResults)
        $fMaxResults = '&maxResults={0}' -f $MaxResults
        $uri += $fMaxResults
    }
    if ($Language) {
        Write-Debug -Message ('Language: {0}' -f $Language)
        $fLanguage = '&culture={0}' -f $Language
        $uri += $fLanguage
    }

    Write-Verbose -Message ('Querying Bing API: {0}' -f $uri)

    Write-Debug -Message 'Adding API key'
    $fAPIKey = '&key={0}' -f $env:BingAPIKey
    $uri += $fAPIKey

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

    if ($results.statusDescription -ne 'OK') {
        Write-Warning -Message 'Did not get a succcessful return from Bing Location API endpoint'
        $finalResults = $results
    }
    elseif (-not ($results.resourceSets.estimatedTotal -ge 1)) {
        Write-Warning -Message 'No results returned from query'
        $finalResults = $results
    }
    else {
        $finalResults = ($results.resourceSets.resources | Format-BingPlace)
        # $finalResults = $results
    }

    return $finalResults

} #Find-BingPlace

