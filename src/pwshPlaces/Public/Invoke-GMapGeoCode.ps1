<#
.SYNOPSIS
    Converts addresses to geographic coordinates and vice versa using Google's Geocoding API.
.DESCRIPTION
    The Invoke-GMapGeoCode function utilizes Google's Geocoding API to convert street addresses into geographic coordinates
    (latitude and longitude) and perform reverse geocoding, which converts coordinates back into readable addresses.
    This function can also use a Google Place ID to retrieve geocoding information about a specific location.
.EXAMPLE
    Invoke-GMapGeoCode -Address '148 S Castell Ave, New Braunfels, TX 78130, United States' -GoogleAPIKey $googleAPIKey

    Performs geocoding to find the latitude and longitude of the given address
.EXAMPLE
    Invoke-GMapGeoCode -Latitude '29.7012853' -Longitude '-98.1250235' -GoogleAPIKey $googleAPIKey

    Performs reverse geocoding on the provided coordinates, returning potential address matches.
.EXAMPLE
    Invoke-GMapGeoCode -Latitude '37.621313' -Longitude '-122.378955' -Language es -GoogleAPIKey $googleAPIKey

    Performs reverse geocoding on the provided coordinates, returning address results in Spanish.
.EXAMPLE
    Invoke-GMapGeoCode -PlaceID 'ChIJK34phme9XIYRqstHW_gHr2w' -GoogleAPIKey $googleAPIKey

    Retrieves geocoding information for the specified place ID.
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
    https://pwshplaces.readthedocs.io/en/latest/pwshPlaces-Google-Maps-Examples/
.LINK
    https://developers.google.com/maps/documentation/geocoding/overview
.LINK
    https://maps.googleapis.com/maps/api/geocode/outputFormat?parameters
.LINK
    https://developers.google.com/maps/documentation/geocoding/requests-geocoding
.LINK
    https://developers.google.com/maps/documentation/geocoding/requests-reverse-geocoding
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

    <#
        API Notes:
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
                    region
                    result_type
                    location_type
    #>

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
    } #switch_ParameterSetName

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
        Write-Warning -Message 'Did not get a successful return from Google Geocode API endpoint'
        $finalResults = $results
    }
    else {
        $finalResults = ($results.results | Format-GMapGeoCode)
        # $finalResults = $results.results
        # $finalResults = (Format-GMapGeoCode -Results $Results.results)
    }

    return $finalResults

} #Invoke-GMapGeoCode
