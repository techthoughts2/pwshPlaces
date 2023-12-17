<#
.SYNOPSIS
    Retrieves time zone information for a specific location on Earth.
.DESCRIPTION
    The Find-BingTimeZone function queries the Bing Maps Time Zone API to obtain local
    time zone and daylight saving time (DST) information based on either geographic coordinates
    or a place name. This function is useful for determining the time zone of any location,
    including whether DST is observed and the current local time.
.EXAMPLE
    Find-BingTimeZone -Query 'New Braunfels, TX' -BingMapsAPIKey $bingAPIKey

    Retrieves time zone information for the location matching the query 'New Braunfels, TX'.
.EXAMPLE
    Find-BingTimeZone -Query 'New Braunfels, TX' -BingMapsAPIKey $bingAPIKey -IncludeDSTRules

    Retrieves time zone information for the location matching the query 'New Braunfels, TX', including DST rules.
.EXAMPLE
    Find-BingTimeZone -PointLatitude 29.70 -PointLongitude -98.11 -BingMapsAPIKey $bingAPIKey

    Returns time zone information for the specified latitude and longitude coordinates.
.PARAMETER Query
    Specifies the search term string, such as an address, business name, or landmark name.
.PARAMETER PointLatitude
    Specifies the latitude for location-based searches. Single coordinate for the north–south position of a point on the Earth's surface.
.PARAMETER PointLongitude
    Specifies the longitude for location-based searches. Single coordinate for the east–west position of a point on the Earth's surface.
.PARAMETER RegionBias
    The region code, specified as a ccTLD ("top-level domain") two-character value.
.PARAMETER Language
    The language in which to return results.
.PARAMETER BingMapsAPIKey
    Bing Maps API Key
.PARAMETER IncludeDSTRules
    Include Daylight Saving Time (DST) rules in the search results. Returns additional information about the DST observance and rules applicable to the places found in the search.
.OUTPUTS
    Bing.TimeZone
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

    Direct API Example:
        https://dev.virtualearth.net/REST/v1/TimeZone/{point}?datetime={datetime_utc}&key={BingMapsAPIKey}

    Ensure you have a valid Bing Maps API Key.
        How to get a Bing Maps API Key:
            https://pwshplaces.readthedocs.io/en/latest/BingMapsAPI/#how-to-get-a-bing-maps-api-key
.COMPONENT
    pwshPlaces
.LINK
    https://pwshplaces.readthedocs.io/en/latest/Find-BingTimeZone
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
        [string]$BingMapsAPIKey,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Include DST rules')]
        [switch]$IncludeDSTRules
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
    } #switch_ParameterSetName

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
    if ($IncludeDSTRules) {
        Write-Debug -Message 'IncludeDSTRules specified'
        $fIncludeDSTRules = '&includeDstRules={0}' -f $IncludeDSTRules
        $uri += $fIncludeDSTRules
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
        if ($PSCmdlet.ParameterSetName -eq 'Point') {
            $finalResults = ($results.resourceSets.resources.timeZone | Format-BingTimeZone)
        }
        else {
            $finalResults = ($results.resourceSets.resources.timeZoneAtLocation.timeZone | Format-BingTimeZone)
        }
    }

    return $finalResults

} #Find-BingTimeZone
