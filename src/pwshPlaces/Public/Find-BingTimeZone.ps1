<#
.SYNOPSIS
    Retrieve time zone information for any point on Earth
.DESCRIPTION
    Given a pair of coordinates or a place name query the Time Zone API will return local time zone and daylight savings (DST) information for that location.
.EXAMPLE
    Find-BingTimeZone -Query 'New Braunfels, TX' -BingMapsAPIKey $bingAPIKey

    Returns Time Zone information for matches found for the provided query.
.EXAMPLE
    Find-BingTimeZone -PointLatitude 29.70 -PointLongitude -98.11 -BingMapsAPIKey $bingAPIKey

    Returns Time Zone information for the provided coordinates.
.PARAMETER Query
    A string that contains information about a location, such as an address or landmark name.
.PARAMETER PointLatitude
    Prefer results in a specified area by specifying a single coordinate for the north–south position of a point on the Earth's surface.
.PARAMETER PointLongitude
    Prefer results in a specified area by specifying a single coordinate for the east–west position of a point on the Earth's surface.
.PARAMETER RegionBias
    The region code, specified as a ccTLD ("top-level domain") two-character value.
.PARAMETER Language
    The language in which to return results.
.PARAMETER BingMapsAPIKey
    Bing Maps API Key
.OUTPUTS
    Bing.TimeZone
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

    Example:
        https://dev.virtualearth.net/REST/v1/TimeZone/{point}?datetime={datetime_utc}&key={BingMapsAPIKey}

    How to get a Bing Maps API Key:
        https://github.com/techthoughts2/pwshPlaces/blob/main/docs/BingMapsAPI.md#how-to-get-a-bing-maps-api-key
.COMPONENT
    pwshPlaces
.LINK
    https://github.com/techthoughts2/pwshPlaces/blob/master/docs/Find-BingTimeZone.md
.LINK
    https://docs.microsoft.com/bingmaps/rest-services/timezone/find-time-zone
.LINK
    https://docs.microsoft.com/bingmaps/rest-services/common-parameters-and-types/supported-culture-codes
.LINK
    https://www.microsoft.com/maps/product/terms.html
.LINK
    https://privacy.microsoft.com/en-us/privacystatement
#>
function Find-BingTimeZone {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            ParameterSetName = 'textquery',
            HelpMessage = 'A string that contains information about a location, such as an address or landmark name')]
        [ValidateNotNullOrEmpty()]
        [string]$Query,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'Point',
            HelpMessage = 'Location bias by point lat')]
        [ValidateNotNullOrEmpty()]
        [string]$PointLatitude,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'Point',
            HelpMessage = 'Location bias by point long')]
        [ValidateNotNullOrEmpty()]
        [string]$PointLongitude,

        [Parameter(Mandatory = $false,
            HelpMessage = 'The region code, specified as a ccTLD')]
        [ccTLD]$RegionBias,

        [Parameter(Mandatory = $false,
            HelpMessage = 'The language in which to return results')]
        [languages]$Language,

        [Parameter(Mandatory = $true,
            HelpMessage = 'Bing Maps API Key')]
        [ValidateNotNullOrEmpty()]
        [string]$BingMapsAPIKey
    )

    Write-Debug -Message ($PSCmdlet.ParameterSetName)

    switch ($PSCmdlet.ParameterSetName) {
        'textquery' {
            Write-Debug -Message 'Query specified'

            $uri = '{0}{1}' -f $bingMapsBaseURI, 'v1/TimeZone?output=json'
            Write-Debug -Message ('Base function URI: {0}' -f $uri)

            $fQuery = '&query={0}' -f [uri]::EscapeDataString($Query)
            $uri += $fQuery
        } #point
        'Point' {
            Write-Debug -Message 'Point specified'

            Write-Debug -Message 'Location specified'
            $latLong = 'v1/TimeZone/{0},{1}?output=json' -f $PointLatitude, $PointLongitude
            $uri = '{0}{1}' -f $bingMapsBaseURI, $latLong
            Write-Debug -Message ('Base function URI: {0}' -f $uri)
        } #point
    } #switch_parametersetname

    if ($RegionBias) {
        Write-Debug -Message ('RegionBias: {0}' -f $RegionBias)
        $fRegion = '&userRegion={0}' -f $RegionBias
        $uri += $fRegion
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
        Write-Warning -Message 'Did not get a succcessful return from Bing Location API endpoint'
        $finalResults = $results
    }
    elseif (-not ($results.resourceSets.estimatedTotal -ge 1)) {
        Write-Warning -Message 'No results returned from query'
        $finalResults = $results
    }
    else {
        if ($PSCmdlet.ParameterSetName -eq 'Point') {
            $finalResults = ($results.resourceSets.resources.timeZone | Format-BingTimeZone)
        }
        else {
            $finalResults = ($results.resourceSets.resources.timeZoneAtLocation.timeZone | Format-BingTimeZone)
        }
    }

    return $finalResults

} #Find-BingTimeZone
