<#
.SYNOPSIS
    Nearby Search lets you search for places within a specified area. You can refine your search request by supplying keywords, type of place you are searching for and other parameters.
.DESCRIPTION
    Performs a nearby search request with provided parameters.
    Nearby search is useful for finding places near a specific geographic location.
    By default 20 results are returned from a standard search.
    You can increase this to a maximum of 60 places results by providing the AllSearchResults switch.
.EXAMPLE
    Search-GMapNearbyPlace -Latitude '29.7049806' -Longitude '-98.068343' -Radius 5000

    Performs a nearby search and returns all places types near provided coordinates within a range of 5000 meters.
.EXAMPLE
    Search-GMapNearbyPlace -Latitude '29.7049806' -Longitude '-98.068343' -Radius 10000 -RankByProminence -Keyword 'butcher' -Type store

    Performs a nearby search and returns all store place types that match the keyword of butcher within the specified geographic range.
.EXAMPLE
    Search-GMapNearbyPlace -Latitude '38.9072' -Longitude '-77.0369' -Radius 10000 -RankByProminence -Type embassy -AllSearchResults

    Performs a nearby search and returns all embassy place types near provided coordinates within a range of 10000 meters. The maximum of 60 places results is returned.
.EXAMPLE
    Search-GMapNearbyPlace -Latitude '29.7013856' -Longitude '-98.1249258' -Radius 1000 -Type restaurant -MinPrice 1 -MaxPrice 3

    Performs a nearby search and returns only restaurants places near provided coordinates within a range of 1000 meters. Restaurant will be in the cheap to moderately expensive price range.
.EXAMPLE
    Search-GMapNearbyPlace -Latitude '29.7049806' -Longitude '-98.068343' -RankByDistance

    Performs a nearby search and returns all places types near provided coordinates ranked by distance from the coordinates.
.EXAMPLE
    Search-GMapNearbyPlace -Latitude '26.1202' -Longitude '127.7025' -Radius 10000 -RankByProminence -Type amusement_park -Language en

    Performs a nearby search and returns only amusement parks places near provided coordinates within a range of 10000 meters. Results are ranked by prominence and returned in Engish.
.EXAMPLE
    Search-GMapNearbyPlace -Latitude '29.7049806' -Longitude '-98.068343' -Radius 5000 -RankByProminence -Keyword 'pasta' -Type restaurant -Language en -OpenNow -MaxPrice 4 -MinPrice 2 -AllSearchResults

    Performs a nearby search and returns only restaurants places near provided coordinates that match the keyword of pasta within a range of 5000 meters. Restaurant will be in the moderately expensive to expensive price range. Only places that are currently opened are returned. Results will be returned in English.
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
    }
    Search-GMapNearbyPlace @searchGMapNearbyPlaceSplat

    Performs a nearby search and returns only restaurants places near provided coordinates that match the keyword of pasta within a range of 5000 meters. Restaurant will be in the moderately expensive to expensive price range. Only places that are currently opened are returned. Results will be returned in English.
.PARAMETER Latitude
    Geographic coordinate that specifies the north–south position of a point on the Earth's surface.
.PARAMETER Longitude
    Geographic coordinate that specifies the east–west position of a point on the Earths surface.
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
.OUTPUTS
    GMap.NearbyPlace
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

    Latitude and Longitude information can be easily retrieved using Invoke-GMapGeoCode

    Required parameters
        location
            This must be specified as latitude,longitude.
    Optional parameters
        keyword
        language
        maxprice
        minprice
        name
        opennow
        radius
        rankby
        type
        sessiontoken

    Example: 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522%2C151.1957362&radius=1500&type=restaurant&keyword=cruise&key=YOUR_API_KEY'

    Nearby Search and Text Search return all of the available data fields for the selected place (a subset of the supported fields), and you will be billed accordingly There is no way to constrain Nearby Search or Text Search to only return specific fields. To keep from requesting (and paying for) data that you don't need, use a Find Place request instead.

    Use of the AllSearchResults parameter does increase the number of API calls.

    This function includes Google Maps features and content; use of Google Maps features and content is subject to the terms of service and Google privacy (linked below).
.COMPONENT
    pwshPlaces
.LINK
    https://github.com/techthoughts2/pwshPlaces/blob/master/docs/Search-GMapNearbyPlace.md
.LINK
    https://developers.google.com/maps/documentation/places/web-service/search-nearby
.LINK
    https://maps.googleapis.com/maps/api/place/nearbysearch/output?parameters
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
        [switch]$AllSearchResults
    )

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
    $fAPIKey = '&key={0}' -f $env:GoogleAPIKey
    $uri += $fAPIKey
    Write-Debug -Message ('Final URI: {0}' -f $uri)

    $allresults = [System.Collections.ArrayList]::new()

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
            [void]$allresults.Add($_)
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
                [void]$allresults.Add($_)
            }
            $i++
            #_________________________________________________________________________
        }
        $finalResults = $allresults | Format-GMapNearbyPlace
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
