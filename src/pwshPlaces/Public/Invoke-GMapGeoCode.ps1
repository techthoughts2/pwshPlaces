<#
.SYNOPSIS
    Engages Geocoding API to return address and geographic coordinates based on provided query parameters.
.DESCRIPTION
    Geocoding is the process of converting addresses (like "1600 Amphitheatre Parkway, Mountain View, CA") into geographic coordinates.
    This function can take in an address and return coordinate information.
    You can also provide coordinates to return multiple nearby address results.
    If you know the exact google placeID this can also be provided to return Geocoding information about that location.
.EXAMPLE
    Invoke-GMapGeoCode -Address '148 S Castell Ave, New Braunfels, TX 78130, United States' -GoogleAPIKey $googleAPIKey

    Performs Geocoding (latitude/longitude lookup) on provided address.
.EXAMPLE
    Invoke-GMapGeoCode -Latitude '29.7012853' -Longitude '-98.1250235' -GoogleAPIKey $googleAPIKey

    Performs Reverse geocoding (address lookup) on provided coordinates and can return multiple address results.
.EXAMPLE
    Invoke-GMapGeoCode -Latitude '37.621313' -Longitude '-122.378955' -Language es -GoogleAPIKey $googleAPIKey

    Performs Reverse geocoding (address lookup) on provided coordinates and can return multiple address results in Spanish.
.EXAMPLE
    Invoke-GMapGeoCode -PlaceID 'ChIJK34phme9XIYRqstHW_gHr2w' -GoogleAPIKey $googleAPIKey

    Returns Geocoding information about the provided place.
.PARAMETER Address
    The street address or plus code that you want to geocode. Specify addresses in accordance with the format used by the national postal service of the country concerned. Additional address elements such as business names and unit, suite or floor numbers should be avoided.
.PARAMETER Latitude
    Geographic coordinate that specifies the north–south position of a point on the Earth's surface.
.PARAMETER Longitude
    Geographic coordinate that specifies the east–west position of a point on the Earth's surface.
.PARAMETER PlaceID
    The place ID of the place for which you wish to obtain the human-readable address. The place ID is a unique identifier that can be used with other Google APIs.
.PARAMETER Language
    The language in which to return results.
.PARAMETER RegionBias
    The region code, specified as a ccTLD ("top-level domain") two-character value. This parameter will only influence, not fully restrict, results from the geocoder.
.PARAMETER GoogleAPIKey
    Google API Key
.OUTPUTS
    GMap.GeoCode
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

    This function does not support pipeline input because of this issue:
        https://github.com/PowerShell/PowerShell/issues/10188

    LAT LONG LOOKUP
        Required parameters
            address
            key
        Optional parameters
            bounds
            language
            region
            components
        Direct API Example:
            https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=YOUR_API_KEY
    Reverse geocoding (address lookup)
        Required parameters
            latlng
            key
        Optional parameters
            language
            result_type
            location_type
        Direct API Example:
            https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&key=YOUR_API_KEY

    Ensure you have a valid Google API Key.
        How to get a Google API Key:
            https://pwshplaces.readthedocs.io/en/latest/GoogleMapsAPI/#how-to-get-a-google-maps-api-key

    This function includes Google Maps features and content; use of Google Maps features and content is subject to the terms of service and Google privacy (linked below).
.COMPONENT
    pwshPlaces
.LINK
    https://pwshplaces.readthedocs.io/en/latest/Invoke-GMapGeoCode
.LINK
    https://developers.google.com/maps/documentation/geocoding/overview
.LINK
    https://maps.googleapis.com/maps/api/geocode/outputFormat?parameters
.LINK
    https://developers.google.com/maps/documentation/geocoding/overview#geocoding-lookup
.LINK
    https://developers.google.com/maps/documentation/geocoding/overview#ReverseGeocoding
.LINK
    https://developers.google.com/maps/faq#languagesupport
.LINK
    https://cloud.google.com/maps-platform/terms/
.LINK
    https://www.google.com/policies/privacy/
#>
function Invoke-GMapGeoCode {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            ParameterSetName = 'Address',
            HelpMessage = 'The street address or plus code that you want to geocode')]
        [ValidateNotNullOrEmpty()]
        [string]$Address,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'Location',
            HelpMessage = 'Geographic coordinate that specifies the north–south position of a point on the Earths surface')]
        [ValidateNotNullOrEmpty()]
        [string]$Latitude,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'Location',
            HelpMessage = 'Geographic coordinate that specifies the east–west position of a point on the Earths surface')]
        [ValidateNotNullOrEmpty()]
        [string]$Longitude,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'PlaceID',
            HelpMessage = 'The place ID of the place for which you wish to obtain the human-readable address')]
        [ValidateNotNullOrEmpty()]
        [string]$PlaceID,

        [Parameter(Mandatory = $false,
            HelpMessage = 'The language in which to return results')]
        [languages]$Language,

        [Parameter(Mandatory = $false,
            HelpMessage = 'The region code, specified as a ccTLD')]
        [ccTLD]$RegionBias,

        [Parameter(Mandatory = $true,
            HelpMessage = 'Google API Key')]
        [ValidateNotNullOrEmpty()]
        [string]$GoogleAPIKey
    )

    $uri = '{0}{1}' -f $googleMapsBaseURI, 'geocode/json?'
    Write-Debug -Message ('Base function URI: {0}' -f $uri)

    switch ($PSCmdlet.ParameterSetName) {
        'Address' {
            Write-Debug -Message 'Address specified'
            $fAddress = 'address={0}' -f [uri]::EscapeDataString($address)
            $uri += $fAddress
        } #address
        'Location' {
            Write-Debug -Message 'Location specified'
            $combinedLatLong = '{0},{1}' -f $Latitude, $Longitude
            $fLatLong = 'latlng={0}' -f [uri]::EscapeDataString($combinedLatLong)
            $uri += $fLatLong
        } #location
        'PlaceID' {
            Write-Debug -Message 'PlaceID specified'
            $fPlaceID = 'place_id={0}' -f $PlaceID
            $uri += $fPlaceID
        } #placeID
    } #switch_parametersetname

    if ($Language) {
        Write-Debug -Message ('Language: {0}' -f $Language)
        $fLanguage = '&language={0}' -f $Language
        $uri += $fLanguage
    }
    if ($RegionBias) {
        Write-Debug -Message ('RegionBias: {0}' -f $RegionBias)
        $fRegion = '&region={0}' -f $RegionBias
        $uri += $fRegion
    }

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
        Write-Warning -Message 'Did not get a succcessful return from Google Geocode API endpoint'
        $finalResults = $results
    }
    else {
        $finalResults = ($results.results | Format-GMapGeoCode)
        # $finalResults = $results.results
        # $finalResults = (Format-GMapGeoCode -Results $Results.results)
    }

    return $finalResults

} #Invoke-GMapGeoCode
