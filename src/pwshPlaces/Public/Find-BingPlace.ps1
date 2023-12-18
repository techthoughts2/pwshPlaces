<#
.SYNOPSIS
    Searches for business entities or points of interest based on a query and geographic parameters.
.DESCRIPTION
    The Find-BingPlace function interfaces with the Bing Maps API to perform text-based searches
    for business entities or points of interest. By default, search results are biased based on
    the user's IP location, but this can be customized using various geographic parameters.
    This function is ideal for locating specific places or exploring areas of interest.
    Location bias and language can also be controlled via parameters.
.EXAMPLE
    Find-BingPlace -Query "Krause's cafe" -BingMapsAPIKey $bingAPIKey

    Performs a search for "Krause's cafe" and biases the results based on the IP location of the user.
.EXAMPLE
    Find-BingPlace -Query "Krause's cafe" -Language es -BingMapsAPIKey $bingAPIKey

    Searches for "Krause's cafe" and returns portions of the results in Spanish, biased by the user's IP location.
.EXAMPLE
    Find-BingPlace -Query 'cafe' -PointLatitude '29.7049806' -PointLongitude '-98.068343' -BingMapsAPIKey $bingAPIKey

    Searches for cafes near the specified latitude and longitude coordinates.
.EXAMPLE
    Find-BingPlace -Query 'cafe' -CircleLatitude '29.7049806' -CircleLongitude '-98.068343' -CircleRadius '5000' -BingMapsAPIKey $bingAPIKey

    Searches for cafes within a 5000-meter radius of the given lat/long point.
.EXAMPLE
    Find-BingPlace -Query 'cafe' -SouthLatitude '39.8592387' -WestLongitude '-75.295486' -NorthLatitude '40.0381942' -EastLongitude '-75.0064087' -BingMapsAPIKey $bingAPIKey

    Searches for cafes within a specified rectangular area defined by two sets of lat/long coordinates.
    These are represented by the south/west and north/east points of a rectangle.
.EXAMPLE
    Find-BingPlace -Query 'cafe' -PointLatitude '29.7049806' -PointLongitude '-98.068343' -Language en -MaxResults 20 -BingMapsAPIKey $bingAPIKey

    Finds up to 20 cafes near the specified point, with results in English.
.EXAMPLE
    $findBingPlaceSplat = @{
        Query          = 'cafe'
        PointLatitude  = '29.7049806'
        PointLongitude = '-98.068343'
        Language       = 'en'
        MaxResults     = 20
        BingMapsAPIKey = $bingAPIKey
    }
    Find-BingPlace @findBingPlaceSplat

    Finds up to 20 cafes near the specified point, with results in English.
.PARAMETER Query
    Specifies the search term string, such as an address, business name, or landmark name.
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
.PARAMETER RegionBias
    The region code, specified as a ccTLD ("top-level domain") two-character value.
.PARAMETER Language
    The language in which to return results.
.PARAMETER BingMapsAPIKey
    Bing Maps API Key
.OUTPUTS
    Bing.Place
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

    Direct API Example:
        https://dev.virtualearth.net/REST/v1/LocalSearch/?query={query}&userLocation={point}&key={BingMapsAPIKey}

    Ensure you have a valid Bing Maps API Key.
        How to get a Bing Maps API Key:
            https://pwshplaces.readthedocs.io/en/latest/BingMapsAPI/#how-to-get-a-bing-maps-api-key
.COMPONENT
    pwshPlaces
.LINK
    https://pwshplaces.readthedocs.io/en/latest/Find-BingPlace/
.LINK
    https://pwshplaces.readthedocs.io/en/latest/pwshPlaces-Bing-Maps-Examples/
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
        [int]$MaxResults,

        [Parameter(Mandatory = $true,
            HelpMessage = 'Bing Maps API Key')]
        [ValidateNotNullOrEmpty()]
        [string]$BingMapsAPIKey
    )

    Write-Debug -Message ($PSCmdlet.ParameterSetName)

    $uri = '{0}{1}' -f $bingMapsBaseURI, 'v1/LocalSearch?output=json'
    Write-Debug -Message ('Base function URI: {0}' -f $uri)

    $fQuery = '&query={0}' -f [uri]::EscapeDataString($Query)
    $uri += $fQuery

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
    } #switch_ParameterSetName

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
    $fAPIKey = '&key={0}' -f $BingMapsAPIKey
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
        Write-Warning -Message 'Did not get a successful return from Bing Location API endpoint'
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

} #Find-BingPlace
