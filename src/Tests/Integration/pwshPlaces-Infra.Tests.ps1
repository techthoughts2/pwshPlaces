#-------------------------------------------------------------------------
Set-Location -Path $PSScriptRoot
#-------------------------------------------------------------------------
$ModuleName = 'pwshPlaces'
#-------------------------------------------------------------------------
#if the module is already in memory, remove it
Get-Module $ModuleName | Remove-Module -Force
$PathToManifest = [System.IO.Path]::Combine('..', '..', 'Artifacts', "$ModuleName.psd1")
#-------------------------------------------------------------------------
Import-Module $PathToManifest -Force
#-------------------------------------------------------------------------
Describe 'Integration Tests' -Tag Infrastructure {
    # for local dev testing only
    # BeforeEach {
    #     $env:GoogleAPIKey = ''
    #     $env:BingAPIKey = ''
    # }
    Context 'Google Maps Function Tests' {

        Context 'Find-GMapPlace' {

            It 'should return the expected results' {
                $findGMapPlaceSplat = @{
                    Query          = '+18306252807'
                    PointLatitude  = '29.7049806'
                    PointLongitude = '-98.068343'
                    Contact        = $true
                    Atmosphere     = $true
                    Language       = 'en'
                    GoogleAPIKey   = $env:GoogleAPIKey
                }
                $eval = Find-GMapPlace @findGMapPlaceSplat
                $eval.place_id  | Should -BeExactly 'ChIJf9Yxhme9XIYRkXo-Bl62Q10'
                $eval.name      | Should -BeExactly "Krause's Cafe"
                $eval.Open      | Should -Not -BeNullOrEmpty
                $eval.rating    | Should -Not -BeNullOrEmpty
                Start-Sleep -Milliseconds (Get-Random -Minimum 250 -Maximum 1000)
            } #it

        } #context_Find-GMapPlace

        Context 'Get-GMapPlaceDetail' {

            It 'should return the expected results' {
                $getGMapPlaceDetailsSplat = @{
                    PlaceID      = 'ChIJf9Yxhme9XIYRkXo-Bl62Q10'
                    Contact      = $true
                    Atmosphere   = $true
                    ReviewSort   = 'Newest'
                    Language     = 'en'
                    RegionBias   = 'us'
                    GoogleAPIKey = $env:GoogleAPIKey
                }
                $eval = Get-GMapPlaceDetail @getGMapPlaceDetailsSplat
                $eval.place_id              | Should -BeExactly 'ChIJf9Yxhme9XIYRkXo-Bl62Q10'
                $eval.name                  | Should -BeExactly "Krause's Cafe"
                $eval.website               | Should -BeExactly 'https://www.krausescafe.com/'
                $eval.Phone                 | Should -BeExactly '(830) 625-2807'
                $eval.Open                  | Should -Not -BeNullOrEmpty
                $eval.OpenHours             | Should -Not -BeNullOrEmpty
                $eval.GoogleMapsURL         | Should -Not -BeNullOrEmpty
                $eval.rating                | Should -Not -BeNullOrEmpty
                $eval.user_ratings_total    | Should -Not -BeNullOrEmpty
                $eval.price_level           | Should -Not -BeNullOrEmpty
                $eval.Latitude              | Should -Not -BeNullOrEmpty
                $eval.Longitude             | Should -Not -BeNullOrEmpty
                Start-Sleep -Milliseconds (Get-Random -Minimum 250 -Maximum 1000)
            } #it

        } #context_Get-GMapPlaceDetails

        Context 'Invoke-GMapGeoCode' {

            It 'should return the expected results for lat long lookup' {
                $invokeGMapGeoCodeSplat = @{
                    Address      = '148 S Castell Ave, New Braunfels, TX 78130, USA'
                    GoogleAPIKey = $env:GoogleAPIKey
                }
                $eval = Invoke-GMapGeoCode @invokeGMapGeoCodeSplat
                ($eval.place_id | Measure-Object).Count | Should -BeGreaterOrEqual 1
                Start-Sleep -Milliseconds (Get-Random -Minimum 250 -Maximum 1000)
            } #it

            It 'should return the expected results for reverse geocoding' {
                $invokeGMapGeoCodeSplat = @{
                    Latitude     = '29.7012853'
                    Longitude    = '-98.1250235'
                    GoogleAPIKey = $env:GoogleAPIKey
                }
                $eval = Invoke-GMapGeoCode @invokeGMapGeoCodeSplat
                ($eval.place_id | Measure-Object).Count | Should -BeGreaterOrEqual 1
                Start-Sleep -Milliseconds (Get-Random -Minimum 250 -Maximum 1000)
            } #it

            It 'should return expected results for place lookup' {
                $invokeGMapGeoCodeSplat = @{
                    PlaceID      = 'ChIJf9Yxhme9XIYRkXo-Bl62Q10'
                    GoogleAPIKey = $env:GoogleAPIKey
                }
                $eval = Invoke-GMapGeoCode @invokeGMapGeoCodeSplat
                $eval.place_id  | Should -BeExactly 'ChIJf9Yxhme9XIYRkXo-Bl62Q10'
                $eval.City      | Should -BeExactly 'New Braunfels'
                $eval.Latitude  | Should -Not -BeNullOrEmpty
                $eval.Longitude | Should -Not -BeNullOrEmpty
                Start-Sleep -Milliseconds (Get-Random -Minimum 250 -Maximum 1000)
            } #it

        } #context_Invoke-GMapGeoCode

        Context 'Search-GMapNearbyPlace' {

            It 'should return the expected results' {
                $searchGMapNearbyPlaceSplat = @{
                    Latitude         = '29.7049806'
                    Longitude        = '-98.068343'
                    Radius           = 5000
                    RankByProminence = $true
                    Keyword          = 'pasta'
                    Type             = 'restaurant'
                    Language         = 'en'
                    MaxPrice         = 4
                    MinPrice         = 2
                    AllSearchResults = $true
                    GoogleAPIKey     = $env:GoogleAPIKey
                }
                $eval = Search-GMapNearbyPlace @searchGMapNearbyPlaceSplat
                ($eval.place_id | Measure-Object).Count | Should -BeGreaterOrEqual 2
                Start-Sleep -Milliseconds (Get-Random -Minimum 250 -Maximum 1000)
            } #it

        } #context_Search-GMapNearbyPlace

        Context 'Search-GMapText' {

            It 'should return the expected results' {
                $searchGMapTextSplat = @{
                    Query            = 'Coco'
                    Latitude         = '26.1202'
                    Longitude        = '127.7025'
                    RankByDistance   = $true
                    Type             = 'restaurant'
                    Language         = 'en'
                    MinPrice         = 1
                    MaxPrice         = 2
                    AllSearchResults = $true
                    GoogleAPIKey     = $env:GoogleAPIKey
                }
                $eval = Search-GMapText @searchGMapTextSplat
                ($eval.place_id | Measure-Object).Count | Should -BeGreaterOrEqual 8
                Start-Sleep -Milliseconds (Get-Random -Minimum 250 -Maximum 1000)
            } #it

        } #context_Search-GMapText
    } #context_GoogleMaps

    Context 'Bing Maps Function Tests' {

        Context 'Invoke-BingGeoCode' {

            It 'should return the expected results for lat long lookup' {
                $invokeBingGeoCodeSplat = @{
                    AddressLine    = '148 S Castell Ave'
                    City           = 'New Braunfels'
                    State          = 'TX'
                    PostalCode     = 78130
                    BingMapsAPIKey = $env:BingAPIKey
                }
                $eval = Invoke-BingGeoCode @invokeBingGeoCodeSplat
                ($eval.name | Measure-Object).Count | Should -BeGreaterOrEqual 1
                Start-Sleep -Milliseconds (Get-Random -Minimum 250 -Maximum 1000)
            } #it

            It 'should return the expected results for reverse geocoding' {
                $invokeBingGeoCodeSplat = @{
                    Latitude       = '29.7030'
                    Longitude      = '-98.1245'
                    BingMapsAPIKey = $env:BingAPIKey
                }
                $eval = Invoke-BingGeoCode @invokeBingGeoCodeSplat
                ($eval.name | Measure-Object).Count | Should -BeGreaterOrEqual 1
                Start-Sleep -Milliseconds (Get-Random -Minimum 250 -Maximum 1000)
            } #it

        } #context_Invoke-GMapGeoCode

        Context 'Find-BingPlace' {

            It 'should return the expected results' {
                $findBingPlaceSplat = @{
                    Query          = 'cafe'
                    PointLatitude  = '29.7049806'
                    PointLongitude = '-98.068343'
                    Language       = 'en'
                    MaxResults     = 20
                    BingMapsAPIKey = $env:BingAPIKey
                }
                $eval = Find-BingPlace @findBingPlaceSplat
                ($eval.name | Measure-Object).Count | Should -BeGreaterOrEqual 1
                Start-Sleep -Milliseconds (Get-Random -Minimum 250 -Maximum 1000)
            } #it

        } #context_Find-BingPlace

        Context 'Search-BingNearbyPlace' {

            It 'should return the expected results' {
                $searchBingNearbyPlaceSplat = @{
                    Type           = 'Museums'
                    PointLatitude  = '29.7049806'
                    PointLongitude = '-98.068343'
                    Language       = 'en'
                    MaxResults     = 20
                    BingMapsAPIKey = $env:BingAPIKey
                }
                $eval = Search-BingNearbyPlace @searchBingNearbyPlaceSplat
                ($eval.name | Measure-Object).Count | Should -BeGreaterOrEqual 1
                Start-Sleep -Milliseconds (Get-Random -Minimum 250 -Maximum 1000)
            } #it

        } #context_Find-BingPlace

        Context 'Find-BingTimeZone' {

            It 'should return the expected results for queries' {
                $findBingTimeZoneSplat = @{
                    Query           = 'New Braunfels, TX'
                    BingMapsAPIKey  = $env:BingAPIKey
                    IncludeDSTRules = $true
                }
                $eval = Find-BingTimeZone @findBingTimeZoneSplat
                $eval.TimeZoneName  | Should -BeExactly 'Central Standard Time'
                $eval.TimeZoneShort | Should -BeExactly 'CST'
                $eval.dstRule.dstStartMonth | Should -BeExactly 'Mar'
                $eval.dstRule.dstEndMonth | Should -BeExactly 'Nov'
                Start-Sleep -Milliseconds (Get-Random -Minimum 250 -Maximum 1000)
            } #it

            It 'should return the expected results for point' {
                $findBingTimeZoneSplat = @{
                    PointLatitude   = '29.70'
                    PointLongitude  = '-98.11'
                    BingMapsAPIKey  = $env:BingAPIKey
                    IncludeDSTRules = $true
                }
                $eval = Find-BingTimeZone @findBingTimeZoneSplat
                $eval.TimeZoneName  | Should -BeExactly 'Central Standard Time'
                $eval.TimeZoneShort | Should -BeExactly 'CST'
                $eval.dstRule.dstStartMonth | Should -BeExactly 'Mar'
                $eval.dstRule.dstEndMonth | Should -BeExactly 'Nov'
                Start-Sleep -Milliseconds (Get-Random -Minimum 250 -Maximum 1000)
            } #it

        } #context_Find-BingPlace

    } #context_BingMaps

} #describe_integration_tests
