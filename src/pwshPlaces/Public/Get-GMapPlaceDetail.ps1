<#
.SYNOPSIS
    Retrieves comprehensive details about a specified place or point of interest.
.DESCRIPTION
    The Get-GMapPlaceDetail function interacts with the Google Maps API to fetch extensive information about a place,
    identified by its PlaceID. It provides details like the full address, phone number, website, user ratings, and reviews.
    Additional information such as contact details and atmosphere data (reviews, ratings, pricing) can be requested but
    are subject to higher billing rates.
.EXAMPLE
    Get-GMapPlaceDetail -PlaceID 'ChIJE43gTHK9XIYRleSxiXqF6GU' -GoogleAPIKey $googleAPIKey

    Retrieves detailed information for the specified place ID.
.EXAMPLE
    Get-GMapPlaceDetail -PlaceID 'ChIJE43gTHK9XIYRleSxiXqF6GU' -Contact -GoogleAPIKey $googleAPIKey

    Retrieves detailed place information including contact details for the specified place ID.
.EXAMPLE
    Get-GMapPlaceDetail -PlaceID 'ChIJf9Yxhme9XIYRkXo-Bl62Q10' -Contact -Atmosphere -ReviewSort Newest -Language en -GoogleAPIKey $googleAPIKey

    Returns extensive place details including contact info, reviews, ratings, and pricing, in English, for the given place ID. Reviews are sorted by newest.
.EXAMPLE
    $getGMapPlaceDetailsSplat = @{
        PlaceID      = 'ChIJf9Yxhme9XIYRkXo-Bl62Q10'
        Contact      = $true
        Atmosphere   = $true
        ReviewSort   = 'Newest'
        Language     = 'en'
        GoogleAPIKey = $googleAPIKey
    }
    Get-GMapPlaceDetail @getGMapPlaceDetailsSplat

    Returns extensive place details including contact info, reviews, ratings, and pricing, in English, for the given place ID. Reviews are sorted by newest.
.PARAMETER PlaceID
    The unique identifier of a place in Google Maps.
.PARAMETER Contact
    Includes contact information such as phone numbers and addresses (higher billing rate applies).
.PARAMETER Atmosphere
    Includes atmosphere data like reviews, ratings, and pricing (higher billing rate applies).
.PARAMETER ReviewSort
    The sorting method to use when returning reviews. Can be set to most_relevant (default) or newest.
.PARAMETER Language
    Specifies the language for returned results.
.PARAMETER RegionBias
    The region code, specified as a ccTLD ("top-level domain") two-character value.
.PARAMETER GoogleAPIKey
    Google API Key
.OUTPUTS
    GMap.PlaceDetail
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

    - Use Invoke-GMapGeoCode if you need to retrieve latitude and longitude information.
    - If you provide faulty lat/long info the API call will default back to IP based locationbias.

    Direct API Example:
        https://maps.googleapis.com/maps/api/place/details/json?fields=name%2Crating%2Cformatted_phone_number&place_id=ChIJN1t_tDeuEmsRUsoyG83frY4&key=YOUR_API_KEY

    Ensure you have a valid Google API Key.
        How to get a Google API Key:
            https://pwshplaces.readthedocs.io/en/latest/GoogleMapsAPI/#how-to-get-a-google-maps-api-key

    This function includes Google Maps features and content; use of Google Maps features and content is subject to the terms of service and Google privacy (linked below).
.COMPONENT
    pwshPlaces
.LINK
    https://pwshplaces.readthedocs.io/en/latest/Get-GMapPlaceDetail
.LINK
    https://pwshplaces.readthedocs.io/en/latest/pwshPlaces-Google-Maps-Examples/
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
            HelpMessage = 'The unique identifier of a place in Google Maps')]
        [Parameter(ParameterSetName = 'atmosphereDetail', Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$PlaceID,

        [Parameter(Mandatory = $false,
            HelpMessage = 'return additional contact information')]
        [switch]$Contact,

        [Parameter(Mandatory = $false,
            ParameterSetName = 'atmosphereDetail',
            HelpMessage = 'return additional atmosphere information')]
        [switch]$Atmosphere,

        [Parameter(Mandatory = $false,
            ParameterSetName = 'atmosphereDetail',
            HelpMessage = 'The sorting method to use when returning reviews')]
        [ValidateSet('MostRelevant', 'Newest')]
        [string]$ReviewSort = 'MostRelevant',

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
                            reviews_sort
                                The sorting method to use when returning reviews. Can be set to most_relevant (default) or newest.
            language
            region
    #>

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

    switch ($ReviewSort) {
        'MostRelevant' {
            $sortSelection = 'most_relevant'
        }
        'Newest' {
            $sortSelection = 'newest'
        }
    }
    Write-Debug -Message ('ReviewSort: {0}' -f $sortSelection)
    $uri += '&reviews_sort={0}' -f $sortSelection

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
        $finalResults = ($results.result | Format-GMapPlaceDetail)
    }

    return $finalResults

} #Get-GMapPlaceDetail
