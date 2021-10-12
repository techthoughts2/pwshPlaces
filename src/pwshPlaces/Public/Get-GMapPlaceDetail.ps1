<#
.SYNOPSIS
    Request more details about a particular establishment or point of interest
.DESCRIPTION
    Place Details request returns more comprehensive information about the indicated place such as its complete address, phone number, website, user rating and reviews.
.EXAMPLE
    Get-GMapPlaceDetail -PlaceID 'ChIJE43gTHK9XIYRleSxiXqF6GU' -GoogleAPIKey $googleAPIKey

    Returns detailed place information about provided place ID.
.EXAMPLE
    Get-GMapPlaceDetail -PlaceID 'ChIJE43gTHK9XIYRleSxiXqF6GU' -Contact -GoogleAPIKey $googleAPIKey

    Returns detailed place information about provided place ID including detailed contact information.
.EXAMPLE
    Get-GMapPlaceDetail -PlaceID 'ChIJf9Yxhme9XIYRkXo-Bl62Q10' -Contact -Atmosphere -Language en -GoogleAPIKey $googleAPIKey

    Returns detailed place information about provided place ID including detailed contact, review, rating, and pricing information. Results are returned in English.
.EXAMPLE
    $getGMapPlaceDetailsSplat = @{
        PlaceID      = 'ChIJf9Yxhme9XIYRkXo-Bl62Q10'
        Contact      = $true
        Atmosphere   = $true
        Language     = 'en'
        GoogleAPIKey = $googleAPIKey
    }
    Get-GMapPlaceDetail @getGMapPlaceDetailsSplat

    Returns detailed place information about provided place ID including detailed contact, review, rating, and pricing information. Results are returned in English.
.PARAMETER PlaceID
    A textual identifier that uniquely identifies a place
.PARAMETER Contact
    Returns contact related information about the result - contact fields are billed at a higher rate.
.PARAMETER Atmosphere
    Returns atmosphere related information including reviews and pricing about the result - atmosphere fields are billed at a higher rate.
.PARAMETER Language
    The language in which to return results.
.PARAMETER RegionBias
    The region code, specified as a ccTLD ("top-level domain") two-character value.
.PARAMETER GoogleAPIKey
    Google API Key
.OUTPUTS
    GMap.PlaceDetail
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

    Latitude and Longitude information can be easily retrieved using Invoke-GMapGeoCode

    If you provide faulty lat/long info the API call will default back to IP based locationbias.

    Required parameters
        place_id
            A textual identifier that uniquely identifies a place
    Optional parameters
        fields
            Billing Categories
                Basic - no charge
                    address_component, adr_address, business_status, formatted_address, geometry, icon, icon_mask_base_uri, icon_background_color, name, permanently_closed (deprecated), photo, place_id, plus_code, type, url, utc_offset, vicinity
                Contact
                    formatted_phone_number, international_phone_number, opening_hours, website
                Atmosphere
                    price_level, rating, review, user_ratings_total.
        language
        region

    Example:
        https://maps.googleapis.com/maps/api/place/details/json?fields=name%2Crating%2Cformatted_phone_number&place_id=ChIJN1t_tDeuEmsRUsoyG83frY4&key=YOUR_API_KEY

    How to get a Google API Key:
        https://github.com/techthoughts2/pwshPlaces/blob/main/docs/GoogleMapsAPI.md#how-to-get-a-google-maps-api-key

    This function includes Google Maps features and content; use of Google Maps features and content is subject to the terms of service and Google privacy (linked below).
.COMPONENT
    pwshPlaces
.LINK
    https://github.com/techthoughts2/pwshPlaces/blob/master/docs/Get-GMapPlaceDetail.md
.LINK
    https://developers.google.com/maps/documentation/places/web-service/details
.LINK
    https://developers.google.com/maps/faq#languagesupport
.LINK
    https://cloud.google.com/maps-platform/terms/
.LINK
    https://www.google.com/policies/privacy/
#>
function Get-GMapPlaceDetail {
    [CmdletBinding(
        PositionalBinding = $false,
        DefaultParameterSetName = 'textquery')]
    param (
        [Parameter(Mandatory = $true,
            ParameterSetName = 'textquery',
            HelpMessage = 'A textual identifier that uniquely identifies a place')]
        [ValidateNotNullOrEmpty()]
        [string]$PlaceID,

        [Parameter(Mandatory = $false,
            HelpMessage = 'return additional contact information')]
        [switch]$Contact,

        [Parameter(Mandatory = $false,
            HelpMessage = 'return additional atmosphere information')]
        [switch]$Atmosphere,

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

    Write-Debug -Message ($PSCmdlet.ParameterSetName)

    $uri = '{0}{1}' -f $googleMapsBaseURI, 'place/details/json?'
    Write-Debug -Message ('Base function URI: {0}' -f $uri)

    $fPlaceID = 'place_id={0}' -f $PlaceID
    $uri += $fPlaceID

    if ($Language) {
        Write-Debug -Message ('Language: {0}' -f $Language)
        $fLanguage = '&language={0}' -f $Language
        $uri += $fLanguage
    }

    $fFields = '&fields='
    $basicFields = 'address_component,adr_address,business_status,formatted_address,geometry,icon,icon_mask_base_uri,icon_background_color,name,photo,place_id,plus_code,type,url,utc_offset,vicinity'
    $fFields += [uri]::EscapeDataString($basicFields)
    if ($Contact) {
        $contactFields = ',formatted_phone_number,international_phone_number,opening_hours,website'
        $fFields += [uri]::EscapeDataString($contactFields)
    }
    if ($Atmosphere) {
        $atmosphereFields = ',price_level,rating,review,user_ratings_total'
        $fFields += [uri]::EscapeDataString($atmosphereFields)
    }
    $uri += $fFields

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
        $finalResults = ($results.result | Format-GMapPlaceDetail)
    }

    return $finalResults

} #Get-GMapPlaceDetail
