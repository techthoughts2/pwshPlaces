<#
.SYNOPSIS
    Conducts a text-based search that returns information about a set of places using Google Maps.
.DESCRIPTION
    The Search-GMapText function uses a text query to search for places using Google's Places API.
    It is especially useful for ambiguous or general searches. Returned results can be heavily biased based
    on factors such as including a location in the query itself or by providing direct location information in
    optional parameters. By default, up to 20 results are returned, which can be expanded to a maximum
    of 60 by using the AllSearchResults switch.
.EXAMPLE
    Search-GMapText -Query "Krause's Cafe" -GoogleAPIKey $googleAPIKey

    Searches for "Krause's Cafe" with results biased by the user's IP location.
.EXAMPLE
    Search-GMapText -Query "Cupcakes" -Type bakery -AllSearchResults -GoogleAPIKey $googleAPIKey

    Searches for bakeries related to "Cupcakes," returning up to 60 results biased by the user's IP location.
.EXAMPLE
    Search-GMapText -Query "pizza restaurants in New York" -GoogleAPIKey $googleAPIKey

    Searches for pizza restaurants in New York, with results biased by the location mentioned in the query.
.EXAMPLE
    Search-GMapText -Query "Airport" -RegionBias es -GoogleAPIKey $googleAPIKey

    Searches for airports with results regionally biased to Spain.
.EXAMPLE
    Search-GMapText -Query "italian restaurants in New York" -MinPrice 4 -GoogleAPIKey $googleAPIKey

    Searches for high-end Italian restaurants in New York.
.EXAMPLE
    Search-GMapText -Query "main plaza New Braunfels" -Type restaurant -GoogleAPIKey $googleAPIKey

    Conducts a text search for 'main plaza New Braunfels' focusing specifically on restaurants. The query includes a specific location, which biases the search results towards places in and around Main Plaza in New Braunfels. As a result, the function returns a list of restaurants that are geographically relevant to the specified area, offering a targeted selection based on the user's input location.
.EXAMPLE
    Search-GMapText -Query 'Cafe' -Latitude '26.1202' -Longitude '127.7025' -Radius 5000 -Language en -GoogleAPIKey $googleAPIKey

    Searches for cafes near specified coordinates within 5000 meters, results in English.
.EXAMPLE
    Search-GMapText -Query 'Coco' -Latitude '26.1202' -Longitude '127.7025' -Radius 5000 -Language en -Type restaurant -GoogleAPIKey $googleAPIKey

    Searches for 'Coco' restaurants near specified coordinates, results ranked by distance and returned in English.
.EXAMPLE
    Search-GMapText -Query 'Coco' -Latitude '26.1202' -Longitude '127.7025' -Radius 500 -RankByProminence -GoogleAPIKey $googleAPIKey

    Searches for 'Coco' restaurants near specified coordinates within a 500 meter range. Places results are ranked by their prominence.
.EXAMPLE
    Search-GMapText -Query 'Coco' -Latitude '26.1202' -Longitude '127.7025' -RankByDistance -Type restaurant -GoogleAPIKey $googleAPIKey

    Searches for 'Coco' restaurants near specified coordinates, results ranked by distance.
.EXAMPLE
    Search-GMapText -Query 'Coco' -Latitude '26.1202' -Longitude '127.7025' -RankByDistance -Type restaurant -Language en -OpenNow -MinPrice 1 -MaxPrice 2 -AllSearchResults -GoogleAPIKey $googleAPIKey

    Performs an advanced search specifically for restaurants related to 'Coco' near the given coordinates. The function filters the results to include only restaurants, ranking them based on their proximity to the provided coordinates. Additionally, the search is refined to show only those restaurants that are currently open and fall within a cheap to moderate price range. All search results are presented in English. Maximum limit of 60 place results is utilized in this search.
.EXAMPLE
    $searchGMapTextSplat = @{
        Query            = 'Coco'
        Latitude         = '26.1202'
        Longitude        = '127.7025'
        RankByDistance   = $true
        Type             = 'restaurant'
        Language         = 'en'
        OpenNow          = $true
        MinPrice         = 1
        MaxPrice         = 2
        AllSearchResults = $true
        GoogleAPIKey     = $googleAPIKey
    }
    Search-GMapText @searchGMapTextSplat

    Performs an advanced search specifically for restaurants related to 'Coco' near the given coordinates. The function filters the results to include only restaurants, ranking them based on their proximity to the provided coordinates. Additionally, the search is refined to show only those restaurants that are currently open and fall within a cheap to moderate price range. All search results are presented in English. Maximum limit of 60 place results is utilized in this search.
.PARAMETER Query
    Text string on which to search
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
.PARAMETER Type
    Restricts the results to places matching the specified type.
.PARAMETER Language
    The language in which to return results.
.PARAMETER RegionBias
    The region code, specified as a ccTLD ("top-level domain") two-character value. This parameter will only influence, not fully restrict, results from the geocoder.
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
    GMap.PlaceText
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

    - Use Invoke-GMapGeoCode if you need to retrieve latitude and longitude information.
    - Nearby Search and Text Search return all of the available data fields for the selected place
        (a subset of the supported fields), and you will be billed accordingly.
        There is no way to constrain Nearby Search or Text Search to only return specific fields.
        To keep from requesting (and paying for) data that you don't need, use a Find Place request instead.
    -  Use of the AllSearchResults parameter does increase the number of API calls.

    Direct API Example:
        https://maps.googleapis.com/maps/api/place/textsearch/json?query=restaurants%20in%20Sydney&key=YOUR_API_KEY

    Ensure you have a valid Google API Key.
        How to get a Google API Key:
            https://pwshplaces.readthedocs.io/en/latest/GoogleMapsAPI/#how-to-get-a-google-maps-api-key

    This function includes Google Maps features and content; use of Google Maps features and content is subject to the terms of service and Google privacy (linked below).
.COMPONENT
    pwshPlaces
.LINK
    https://pwshplaces.readthedocs.io/en/latest/Search-GMapText
.LINK
    https://developers.google.com/maps/documentation/places/web-service/search-text
.LINK
    https://maps.googleapis.com/maps/api/place/textsearch/output?parameters
.LINK
    https://developers.google.com/maps/faq#languagesupport
.LINK
    https://cloud.google.com/maps-platform/terms/
.LINK
    https://www.google.com/policies/privacy/
#>
function Search-GMapText {
    [CmdletBinding(
        DefaultParameterSetName = 'textquery')]
    param (
        [Parameter(Mandatory = $true,
            ParameterSetName = 'textquery',
            HelpMessage = 'Text string on which to search')]
        [Parameter(ParameterSetName = 'Location', Mandatory = $false)]
        [Parameter(ParameterSetName = 'Area', Mandatory = $false)]
        [Parameter(ParameterSetName = 'Distance', Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$Query,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'Location',
            HelpMessage = 'Geographic coordinate that specifies the north–south position of a point on the Earths surface')]
        [Parameter(ParameterSetName = 'Area', Mandatory = $false)]
        [Parameter(ParameterSetName = 'Distance', Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$Latitude,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'Location',
            HelpMessage = 'Geographic coordinate that specifies the east–west position of a point on the Earths surface')]
        [Parameter(ParameterSetName = 'Area', Mandatory = $false)]
        [Parameter(ParameterSetName = 'Distance', Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$Longitude,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'Area',
            HelpMessage = 'Distance (in meters) within which to return place results')]
        [ValidateNotNullOrEmpty()]
        [string]$Radius,

        [Parameter(Mandatory = $false,
            ParameterSetName = 'Area',
            HelpMessage = 'This option sorts results based on their importance')]
        [switch]$RankByProminence,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'Distance',
            HelpMessage = 'This option biases search results in ascending order by their distance from the specified location')]
        [switch]$RankByDistance,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Restricts the results to places matching the specified type')]
        [placeTypes]$Type,

        [Parameter(Mandatory = $false,
            HelpMessage = 'The language in which to return results')]
        [languages]$Language,

        [Parameter(Mandatory = $false,
            HelpMessage = 'The region code, specified as a ccTLD')]
        [ccTLD]$RegionBias,

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
            HelpMessage = 'By default 20 results are returned from a standard search. Using this switch increases the search results from 20 to the maximum of 60')]
        [switch]$AllSearchResults,

        [Parameter(Mandatory = $true,
            HelpMessage = 'Google API Key')]
        [ValidateNotNullOrEmpty()]
        [string]$GoogleAPIKey
    )

    <#
        API Notes:
            Required parameters
                query
            Optional parameters
                language
                location
                maxprice
                minprice
                opennow
                radius
                region
                type
    #>

    $uri = '{0}{1}' -f $googleMapsBaseURI, 'place/textsearch/json?'
    Write-Debug -Message ('Base function URI: {0}' -f $uri)

    $fQuery = 'query={0}' -f [uri]::EscapeDataString($Query)
    $uri += $fQuery

    if ($Latitude -and $Longitude) {
        $combinedPoint = '{0},{1}' -f $Latitude, $Longitude
        $fLocation = '&location={0}' -f [uri]::EscapeDataString($combinedPoint)
        $uri += $fLocation
    }

    if ($Radius) {
        Write-Debug -Message ('Radius: {0}' -f $Radius)
        $fRadius = '&radius={0}' -f $Radius
        $uri += $fRadius
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

    if ($RegionBias) {
        Write-Debug -Message ('RegionBias: {0}' -f $RegionBias)
        $fRegion = '&region={0}' -f $RegionBias
        $uri += $fRegion
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

    $allResults = [System.Collections.ArrayList]::new()

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
            $loopURI = 'https://maps.googleapis.com/maps/api/place/textsearch/json?'
            $loopURI += 'pagetoken={0}' -f $pageToken
            $loopURI += $fAPIKey
            #_________________________________________________________________________
            <#
            There is a short delay between when a next_page_token is issued, and when it will become valid.
            Requesting the next page before it is available will return an INVALID_REQUEST response.
            This sleep is necessary. the api backend needs time to catch up.
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
        $finalResults = $allResults | Format-GMapPlaceText
    }
    elseif ($results.status -ne 'OK' ) {
        Write-Warning -Message 'Did not get a succcessful return from Google Geocode API endpoint'
        $finalResults = $results
    }
    else {
        $finalResults = ($results.results | Format-GMapPlaceText)
    }

    return $finalResults

} #Search-GMapText
