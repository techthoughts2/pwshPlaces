<#
.SYNOPSIS
    Nearby Search lets you search for different place types within a specified area.
.DESCRIPTION
    Performs a nearby search request with provided parameters.
    Nearby search is useful for finding place types near a specific geographic location.
    By default the location bias is IP based.
    Location bias can be controlled via parameters.
.EXAMPLE
    Search-BingNearbyPlace -Type Attractions

    Performs a nearby search biased by IP and returns Attraction places types.
.EXAMPLE
    Search-BingNearbyPlace -Type Restaurants -MaxResults 20

    Performs a nearby search biased by IP and returns Restaurant places types with a maximum of 20 results returned.
.EXAMPLE
    Search-BingNearbyPlace -Type CafeRestaurants -PointLatitude '29.7049806' -PointLongitude '-98.068343'

    Performs a nearby search near the provided Lat/Long and returns CafeRestaurant places types.
.EXAMPLE
    Search-BingNearbyPlace -Type BreweriesAndBrewPubs -CircleLatitude '29.7049806' -CircleLongitude '-98.068343' -CircleRadius '5000'

    Performs a nearby search biased by circle lat/long/radius and returns Bars and Pubs places types.
.EXAMPLE
    Search-BingNearbyPlace -Type Parks -SouthLatitude '39.8592387' -WestLongitude '-75.295486' -NorthLatitude '40.0381942' -EastLongitude '-75.0064087'

    Performs a nearby search biased by rectangular two lat/lng pairs in decimal degrees, representing the south/west and north/east points of a rectangle. Park places types are returned.
.EXAMPLE
    Search-BingNearbyPlace -Type Museums -PointLatitude '29.7049806' -PointLongitude '-98.068343' -Language en -MaxResults 20

    Performs a nearby search near the provided Lat/Long and returns Museum places types. Results are returned in English with a maximum of 20 results returned.
.EXAMPLE
    $searchBingNearbyPlaceSplat = @{
        Type           = 'Museums'
        PointLatitude  = '29.7049806'
        PointLongitude = '-98.068343'
        Language       = 'en'
        MaxResults     = 20
    }
    Search-BingNearbyPlace @searchBingNearbyPlaceSplat

    Performs a nearby search near the provided Lat/Long and returns Museum places types. Results are returned in English with a maximum of 20 results returned.
.PARAMETER Query
    A string that contains information about a location, such as an address or landmark name.
.PARAMETER PointLatitude
    Prefer results in a specified area by specifying a single coordinate for the north–south position of a point on the Earth's surface.
.PARAMETER PointLongitude
    Prefer results in a specified area by specifying a single coordinate for the east–west position of a point on the Earth's surface.
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
.PARAMETER RegionBias
    The region code, specified as a ccTLD ("top-level domain") two-character value.
.PARAMETER Language
    The language in which to return results.
.OUTPUTS
    Bing.Place
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

    Example:
        https://dev.virtualearth.net/REST/v1/LocalSearch/?type={type_string_id_list}&userLocation={point}&key={BingMapsAPIKey}
.COMPONENT
    pwshPlaces
.LINK
    https://github.com/techthoughts2/pwshPlaces/blob/master/docs/Search-BingNearbyPlace.md
.LINK
    https://docs.microsoft.com/bingmaps/rest-services/locations/local-search
.LINK
    https://docs.microsoft.com/bingmaps/rest-services/common-parameters-and-types/user-context-parameters
.LINK
    https://docs.microsoft.com/bingmaps/rest-services/common-parameters-and-types/supported-culture-codes
.LINK
    https://www.microsoft.com/maps/product/terms.html
.LINK
    https://privacy.microsoft.com/en-us/privacystatement
#>
function Search-BingNearbyPlace {
    [CmdletBinding(
        PositionalBinding = $false,
        DefaultParameterSetName = 'PlaceType')]
    param (

        [Parameter(Mandatory = $true,
            ParameterSetName = 'PlaceType',
            HelpMessage = 'Restricts the results to places matching the specified type')]
        [Parameter(ParameterSetName = 'Point', Mandatory = $false)]
        [Parameter(ParameterSetName = 'Circle', Mandatory = $false)]
        [Parameter(ParameterSetName = 'Rectangle', Mandatory = $false)]
        [typeIdentifier]$Type,

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

    $uri = '{0}{1}' -f $bingMapsBaseURI, 'v1/LocalSearch?output=json'
    Write-Debug -Message ('Base function URI: {0}' -f $uri)

    $fType = '&type={0}' -f [uri]::EscapeDataString($type)
    $uri += $fType

    switch ($PSCmdlet.ParameterSetName) {
        'Point' {
            Write-Debug -Message 'Point specified'
            $combinedPoint = '{0},{1}' -f $PointLatitude, $PointLongitude
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
    }

    return $finalResults

} #Search-BingNearbyPlace
