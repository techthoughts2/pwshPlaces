﻿<#
.SYNOPSIS
    Converts addresses to geographic coordinates and vice versa using Bing Maps API.
.DESCRIPTION
    Invoke-BingGeoCode performs geocoding by converting addresses into geographic coordinates
    (latitude and longitude) and reverse geocoding by turning coordinates into human-readable addresses.
    This function is ideal for applications needing to translate address data into geographic locations
    or retrieve address information from coordinate points.
.EXAMPLE
    Invoke-BingGeoCode -AddressLine '148 S Castell Ave' -City 'New Braunfels' -State TX -PostalCode 78130 -BingMapsAPIKey $bingAPIKey

    Geocodes the provided address, returning its latitude and longitude.
.EXAMPLE
    Invoke-BingGeoCode -Latitude '29.7030' -Longitude '-98.1245' -BingMapsAPIKey $bingAPIKey

    Performs reverse geocoding on the provided coordinates to find nearby addresses.
.EXAMPLE
    Invoke-BingGeoCode -Query 'The Alamo' -BingMapsAPIKey $bingAPIKey

    Searches for 'The Alamo' and returns geocoded latitude and longitude if found.
.EXAMPLE
    Invoke-BingGeoCode -AddressLine '148 S Castell Ave' -City 'New Braunfels' -State TX -PostalCode 78130 -Country us -Language en -MaxResults 20 -BingMapsAPIKey $bingAPIKey

    Geocodes the address with a bias towards the United States, returning up to 20 results in English.
.EXAMPLE
    $invokeBingGeoCodeSplat = @{
        AddressLine    = '148 S Castell Ave'
        City           = 'New Braunfels'
        State          = 'TX'
        PostalCode     = 78130
        Country        = 'us'
        Language       = 'en'
        MaxResults     = 20
        BingMapsAPIKey = $bingAPIKey
    }
    Invoke-BingGeoCode @invokeBingGeoCodeSplat

    Geocodes the address with a bias towards the United States, returning up to 20 results in English.
.PARAMETER AddressLine
    A string specifying the street line of an address.
.PARAMETER City
    The locality, such as the city or neighborhood, that corresponds to an address.
.PARAMETER State
    The subdivision name in the country or region for an address. This element is typically treated as the first order administrative subdivision, but in some cases it is the second, third, or fourth order subdivision in a country, dependency, or region. A string that contains a subdivision, such as the abbreviation of a US state.
.PARAMETER PostalCode
    The post code, postal code, or ZIP Code of an address.
.PARAMETER Country
    The ISO country code for the country.
.PARAMETER Latitude
    Geographic coordinate that specifies the north–south position of a point on the Earth's surface.
.PARAMETER Longitude
    Geographic coordinate that specifies the east–west position of a point on the Earth's surface.
.PARAMETER Query
    Specifies the search term string, such as an address, business name, or landmark name.
.PARAMETER Language
    The language in which to return results.
.PARAMETER MaxResults
    Specifies the maximum number of locations to return in the response. If not specified, the default is 5.
.PARAMETER BingMapsAPIKey
    Bing Maps API Key
.OUTPUTS
    Bing.GeoCode
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

    Direct API Example:
        http://dev.virtualearth.net/REST/v1/Locations?countryRegion={countryRegion}&adminDistrict={adminDistrict}&locality={locality}&postalCode={postalCode}&addressLine={addressLine}&userLocation={userLocation}&userIp={userIp}&usermapView={usermapView}&includeNeighborhood={includeNeighborhood}&maxResults={maxResults}&key={BingMapsKey}

    Ensure you have a valid Bing Maps API Key.
        How to get a Bing Maps API Key:
            https://pwshplaces.readthedocs.io/en/latest/BingMapsAPI/#how-to-get-a-bing-maps-api-key

    While the Bing Location API does support a text query option, I have found it to be unreliable.
    For GeoCode info stick to Addresses and Lat/Long for reverse Geocoding.
    For Text Queries use other Bing Maps functions.
.COMPONENT
    pwshPlaces
.LINK
    https://pwshplaces.readthedocs.io/en/latest/Invoke-BingGeoCode
.LINK
    https://pwshplaces.readthedocs.io/en/latest/pwshPlaces-Bing-Maps-Examples/
.LINK
    https://docs.microsoft.com/bingmaps/rest-services/locations/find-a-location-by-address
.LINK
    https://docs.microsoft.com/bingmaps/rest-services/locations/find-a-location-by-point
.LINK
    https://docs.microsoft.com/bingmaps/rest-services/locations/find-a-location-by-query
.LINK
    https://docs.microsoft.com/bingmaps/rest-services/common-parameters-and-types/supported-culture-codes
.LINK
    https://www.microsoft.com/maps/product/terms.html
.LINK
    https://privacy.microsoft.com/en-us/privacystatement
#>
function Invoke-BingGeoCode {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            ParameterSetName = 'Address',
            HelpMessage = 'A string specifying the street line of an address')]
        [ValidateNotNullOrEmpty()]
        [string]$AddressLine,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'Address',
            HelpMessage = 'The locality, such as the city or neighborhood, that corresponds to an address')]
        [ValidateNotNullOrEmpty()]
        [string]$City,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'Address',
            HelpMessage = 'adminDistrict - A string that contains a subdivision, such as the abbreviation of a US state')]
        [ValidateNotNullOrEmpty()]
        [string]$State,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'Address',
            HelpMessage = 'The post code, postal code, or ZIP Code of an address')]
        [ValidateNotNullOrEmpty()]
        [string]$PostalCode,

        [Parameter(Mandatory = $false,
            ParameterSetName = 'Address',
            HelpMessage = 'ISO Country code')]
        [ccTLD]$Country,

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
            ParameterSetName = 'textquery',
            HelpMessage = 'A string that contains information about a location, such as an address or landmark name')]
        [ValidateNotNullOrEmpty()]
        [string]$Query,

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

    switch ($PSCmdlet.ParameterSetName) {
        'Address' {
            Write-Debug -Message 'Address specified'

            $uri = '{0}{1}' -f $bingMapsBaseURI, 'v1/Locations?output=json'
            Write-Debug -Message ('Base function URI: {0}' -f $uri)

            $fAddressLine = '&addressLine={0}' -f [uri]::EscapeDataString($AddressLine)
            $uri += $fAddressLine
            $fCity = '&locality={0}' -f [uri]::EscapeDataString($City)
            $uri += $fCity
            $fState = '&adminDistrict={0}' -f [uri]::EscapeDataString($State)
            $uri += $fState
            $fPostalCode = '&postalCode={0}' -f [uri]::EscapeDataString($PostalCode)
            $uri += $fPostalCode
            $fCountry = '&countryRegion={0}' -f [uri]::EscapeDataString($Country)
            $uri += $fCountry
        } #address
        'Location' {
            Write-Debug -Message 'Location specified'
            $latLong = 'v1/Locations/{0},{1}?output=json' -f $Latitude, $Longitude
            $uri = '{0}{1}' -f $bingMapsBaseURI, $latLong
            Write-Debug -Message ('Base function URI: {0}' -f $uri)
        } #location
        'textquery' {
            Write-Debug -Message 'Query specified'
            $uri = '{0}{1}' -f $bingMapsBaseURI, 'v1/Locations?output=json'
            Write-Debug -Message ('Base function URI: {0}' -f $uri)
            $fQuery = '&query={0}' -f [uri]::EscapeDataString($Query)
            $uri += $fQuery
        } #textquery
    } #switch_ParameterSetName

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

    if ($results.statusDescription -ne 'OK') {
        Write-Warning -Message 'Did not get a successful return from Bing Location API endpoint'
        $finalResults = $results
    }
    elseif (-not ($results.resourceSets.estimatedTotal -ge 1)) {
        Write-Warning -Message 'No results returned from query'
        $finalResults = $results
    }
    else {
        $finalResults = ($results.resourceSets.resources | Format-BingGeoCode)
    }

    return $finalResults

} #Invoke-BingGeoCode
