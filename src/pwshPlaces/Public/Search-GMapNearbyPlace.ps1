﻿<#
.SYNOPSIS
    Searches for places within a specified area using Google Maps Nearby Search.
.DESCRIPTION
    The Search-GMapNearbyPlace function utilizes Google's Places API to perform nearby searches for places
    around a specified geographic location. By default, it returns 20 results, which can be increased to a
    maximum of 60 using the AllSearchResults switch. The function allows refining the search based on keywords,
    place types, and other criteria.
.EXAMPLE
    Search-GMapNearbyPlace -Latitude '29.7049806' -Longitude '-98.068343' -Radius 5000 -GoogleAPIKey $googleAPIKey

    Searches for places within a 5000-meter radius of the specified coordinates.
.EXAMPLE
    Search-GMapNearbyPlace -Latitude '29.7049806' -Longitude '-98.068343' -Radius 10000 -RankByProminence -Keyword 'butcher' -Type store -GoogleAPIKey $googleAPIKey

    Searches for stores related to the keyword 'butcher' within a 10000-meter radius, sorted by prominence.
.EXAMPLE
    Search-GMapNearbyPlace -Latitude '38.9072' -Longitude '-77.0369' -Radius 10000 -RankByProminence -Type embassy -AllSearchResults -GoogleAPIKey $googleAPIKey

    Searches for embassies within a 10000-meter radius, returning up to 60 results.
.EXAMPLE
    Search-GMapNearbyPlace -Latitude '29.7013856' -Longitude '-98.1249258' -Radius 1000 -Type restaurant -MinPrice 1 -MaxPrice 3 -GoogleAPIKey $googleAPIKey

    Searches for restaurants within 1000 meters in the affordable to moderately expensive price range.
.EXAMPLE
    Search-GMapNearbyPlace -Latitude '29.7049806' -Longitude '-98.068343' -RankByDistance -GoogleAPIKey $googleAPIKey

    Searches for places near the specified coordinates, ranked by distance.
.EXAMPLE
    Search-GMapNearbyPlace -Latitude '26.1202' -Longitude '127.7025' -Radius 10000 -RankByProminence -Type amusement_park -Language en -GoogleAPIKey $googleAPIKey

    Searches for amusement parks within a 10000-meter radius, results in English, sorted by prominence.
.EXAMPLE
    Search-GMapNearbyPlace -Latitude '29.7049806' -Longitude '-98.068343' -Radius 5000 -RankByProminence -Keyword 'pasta' -Type restaurant -Language en -OpenNow -MaxPrice 4 -MinPrice 2 -AllSearchResults -GoogleAPIKey $googleAPIKey

    Searches for pasta restaurants within 5000 meters, open now, priced mid to high, returning all results in English.
.EXAMPLE
    $searchGMapNearbyPlaceSplat = @{
        Latitude         = '29.7049806'
        Longitude        = '-98.068343'
        Radius           = 5000
        RankByProminence = $true
        Keyword          = 'pasta'
        Type             = 'restaurant'
        Language         = 'en'
        OpenNow          = $true
        MaxPrice         = 4
        MinPrice         = 2
        AllSearchResults = $true
        GoogleAPIKey     = $googleAPIKey
    }
    Search-GMapNearbyPlace @searchGMapNearbyPlaceSplat

    Searches for pasta restaurants within 5000 meters, open now, priced mid to high, returning all results in English.
.PARAMETER Latitude
    Geographic coordinate that specifies the north–south position of a point on the Earth's surface.
.PARAMETER Longitude
    Geographic coordinate that specifies the east–west position of a point on the Earth's surface.
.PARAMETER Radius
    Distance (in meters) within which to return place results. Instructs the Places service to prefer showing results within that circle; results outside of the defined area may still be displayed.
.PARAMETER RankByProminence
    This option sorts results based on their importance.
.PARAMETER RankByDistance
    This option biases search results in ascending order by their distance from the specified location.
.PARAMETER Keyword
    A term to be matched against all content that Google has indexed for this place, including but not limited to name and type, as well as customer reviews and other third-party content. Note that explicitly including location information using this parameter may conflict with the location, radius, and rankby parameters, causing unexpected results.
.PARAMETER Type
    Restricts the results to places matching the specified type.
.PARAMETER Language
    The language in which to return results.
.PARAMETER OpenNow
    Returns only those places that are open for business at the time the query is sent.
.PARAMETER MaxPrice
    Restricts results to only those places within the specified range. Valid values range between 0 (most affordable) to 4 (most expensive), inclusive.
.PARAMETER MinPrice
    Restricts results to only those places within the specified range. Valid values range between 0 (most affordable) to 4 (most expensive), inclusive.
.PARAMETER AllSearchResults
    By default 20 results are returned from a standard search. Using this switch increases the search results from 20 to the maximum of 60. This does increase the number of API calls.
.PARAMETER GoogleAPIKey
    Google API Key
.OUTPUTS
    GMap.NearbyPlace
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

    - Use Invoke-GMapGeoCode if you need to retrieve latitude and longitude information.

    Direct API Example:
        https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522%2C151.1957362&radius=1500&type=restaurant&keyword=cruise&key=YOUR_API_KEY

    Ensure you have a valid Google API Key.
        How to get a Google API Key:
            https://pwshplaces.readthedocs.io/en/latest/GoogleMapsAPI/#how-to-get-a-google-maps-api-key

    Nearby Search and Text Search return all of the available data fields for the selected place (a subset of the supported fields), and you will be billed accordingly There is no way to constrain Nearby Search or Text Search to only return specific fields. To keep from requesting (and paying for) data that you don't need, use a Find Place request instead.

    Use of the AllSearchResults parameter does increase the number of API calls.

    This function includes Google Maps features and content; use of Google Maps features and content is subject to the terms of service and Google privacy (linked below).
.COMPONENT
    pwshPlaces
.LINK
    https://pwshplaces.readthedocs.io/en/latest/Search-GMapNearbyPlace
.LINK
    https://pwshplaces.readthedocs.io/en/latest/pwshPlaces-Google-Maps-Examples/
.LINK
    https://developers.google.com/maps/documentation/places/web-service/search-nearby
.LINK
    https://developers.google.com/maps/faq#languagesupport
.LINK
    https://cloud.google.com/maps-platform/terms/
.LINK
    https://www.google.com/policies/privacy/
#>
function Search-GMapNearbyPlace {
    [CmdLetBinding(
        DefaultParameterSetName = 'Location')]
    param (
        [Parameter(Mandatory = $true,
            ParameterSetName = 'Location',
            HelpMessage = 'Geographic coordinate that specifies the north–south position of a point on the Earths surface')]
        [Parameter(ParameterSetName = 'Area', Mandatory = $true)]
        [Parameter(ParameterSetName = 'Distance', Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Latitude,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'Location',
            HelpMessage = 'Geographic coordinate that specifies the east–west position of a point on the Earths surface')]
        [Parameter(ParameterSetName = 'Area', Mandatory = $true)]
        [Parameter(ParameterSetName = 'Distance', Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Longitude,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'Area',
            HelpMessage = 'Distance (in meters) within which to return place results')]
        [Parameter(ParameterSetName = 'Location', Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Radius,

        [Parameter(Mandatory = $false,
            ParameterSetName = 'Area',
            HelpMessage = 'This option sorts results based on their importance')]
        # [Parameter(ParameterSetName = 'Location', Mandatory = $false)]
        [switch]$RankByProminence,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'Distance',
            HelpMessage = 'This option biases search results in ascending order by their distance from the specified location')]
        # [Parameter(ParameterSetName = 'Location', Mandatory = $false)]
        [switch]$RankByDistance,

        [Parameter(Mandatory = $false,
            HelpMessage = 'A term to be matched against all content that Google has indexed for this place')]
        [ValidateNotNullOrEmpty()]
        [string]$Keyword,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Restricts the results to places matching the specified type')]
        [placeTypes]$Type,

        [Parameter(Mandatory = $false,
            HelpMessage = 'The language in which to return results')]
        [languages]$Language,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Returns only those places that are open for business at the time the query is sent')]
        [switch]$OpenNow,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Restricts results to only those places within the specified range')]
        [ValidateNotNullOrEmpty()]
        [string]$MaxPrice,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Restricts results to only those places within the specified range')]
        [ValidateNotNullOrEmpty()]
        [string]$MinPrice,

        [Parameter(Mandatory = $false,
            HelpMessage = 'TBD')]
        [switch]$AllSearchResults,

        [Parameter(Mandatory = $true,
            HelpMessage = 'Google API Key')]
        [ValidateNotNullOrEmpty()]
        [string]$GoogleAPIKey
    )

    <#
        API Notes:
            Required parameters
                location
                    This must be specified as latitude,longitude.
                radius
                    Defines the distance (in meters) within which to return place results. You may bias results to a specified circle by passing a location and a radius parameter.
                    Doing so instructs the Places service to prefer showing results within that circle; results outside of the defined area may still be displayed.
                    The radius will automatically be clamped to a maximum value depending on the type of search and other parameters.
                    Query Autocomplete: 50,000 meters
                    Text Search: 50,000 meters
            Optional parameters
                keyword
                language
                maxprice
                minprice
                opennow
                pagetoken
                radius
                rankby
                type
    #>

    $uri = '{0}{1}' -f $googleMapsBaseURI, 'place/nearbysearch/json?'
    Write-Debug -Message ('Base function URI: {0}' -f $uri)

    $combinedPoint = '{0},{1}' -f $Latitude, $Longitude
    $fLocation = 'location={0}' -f [uri]::EscapeDataString($combinedPoint)
    $uri += $fLocation

    if ($Radius) {
        Write-Debug -Message ('Radius: {0}' -f $Radius)
        $fRadius = '&radius={0}' -f $Radius
        $uri += $fRadius
    }

    if ($Keyword) {
        Write-Debug -Message ('Keyword: {0}' -f $Keyword)
        $fKeyword = '&keyword={0}' -f $Keyword
        $uri += $fKeyword
    }

    if ($Type) {
        Write-Debug -Message ('Type: {0}' -f $Type)
        $fType = '&type={0}' -f $Type
        $uri += $fType
    }

    if ($Language) {
        Write-Debug -Message ('Language: {0}' -f $Language)
        $fLanguage = '&language={0}' -f $Language
        $uri += $fLanguage
    }

    if ($OpenNow) {
        $cOpenNow = 'openNow:true'
        $fOpenNow = '&{0}' -f [uri]::EscapeDataString($cOpenNow)
        $uri += $fOpenNow
    }

    if ($RankByProminence) {
        $fRankBy = '&rankby=prominence'
        $uri += $fRankBy
    }

    if ($RankByDistance) {
        $fRankBy = '&rankby=distance'
        $uri += $fRankBy
    }

    if ($MaxPrice) {
        Write-Debug -Message ('MaxPrice: {0}' -f $MaxPrice)
        $fMaxPrice = '&maxprice={0}' -f $MaxPrice
        $uri += $fMaxPrice
    }

    if ($MinPrice) {
        Write-Debug -Message ('MinPrice: {0}' -f $MinPrice)
        $fMinPrice = '&minprice={0}' -f $MinPrice
        $uri += $fMinPrice
    }

    Write-Verbose -Message ('Querying Google API: {0}' -f $uri)

    Write-Debug -Message 'Adding API key'
    $fAPIKey = '&key={0}' -f $GoogleAPIKey
    $uri += $fAPIKey
    Write-Debug -Message ('Final URI: {0}' -f $uri)

    $allResults = New-Object System.Collections.Generic.List[object]

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

    if ($results.status -eq 'OK' -and $AllSearchResults) {
        $results.results | ForEach-Object {
            [void]$allResults.Add($_)
        }
        $i = 0
        $pageToken = $results.next_page_token
        while ($null -ne $pageToken) {
            Write-Debug -Message ('Run # - {0}' -f $i)
            #_________________________________________________________________________
            # reconstruct URI for pagetoken use
            $loopURI = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
            $loopURI += 'pagetoken={0}' -f $pageToken
            $loopURI += $fAPIKey
            #_________________________________________________________________________
            <#
            There is a short delay between when a next_page_token is issued, and when it will become valid.
            Requesting the next page before it is available will return an INVALID_REQUEST response.
            This sleep is necessary. the api backend needs time to catch up.
            TODO: add logic to check for INVALID_REQUEST and retry
            #>
            Start-Sleep -Seconds 4
            #_________________________________________________________________________
            # resets
            $results = $null
            $pageToken = $null
            #_________________________________________________________________________
            $invokeRestMethodSplat = @{
                Uri         = $loopURI
                ErrorAction = 'Stop'
            }
            try {
                $results = Invoke-RestMethod @invokeRestMethodSplat
            }
            catch {
                throw $_
            }
            #_________________________________________________________________________
            $pageToken = $results.next_page_token
            $results.results | ForEach-Object {
                [void]$allResults.Add($_)
            }
            $i++
            #_________________________________________________________________________
        }
        $finalResults = $allResults | Format-GMapNearbyPlace
    }
    elseif ($results.status -ne 'OK' ) {
        Write-Warning -Message 'Did not get a succcessful return from Google Geocode API endpoint'
        $finalResults = $results
    }
    else {
        $finalResults = ($results.results | Format-GMapNearbyPlace)
    }

    return $finalResults

} #Search-GMapNearbyPlace
