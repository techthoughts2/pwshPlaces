# pwshPlaces - Bing Maps Advanced

*Consider exploring the [pwshPlaces Bing Maps Basics](pwshPlaces-Bing-Maps-Basics.md) page first to gain a comprehensive understanding of the tool and its features before proceeding to the advanced page.*

## API Caching

There doesn't seem to be anything in the [terms of service](https://www.microsoft.com/maps/product/terms.html) the explicitly forbids local caching of Bing Maps data.

This means that doing something like this should be fine:.

Create a locally cached copy of restaurants nearby. Then use `Get-Random` to source the local cache and pick a random place to eat each day!

```powershell
#--------------------------------------------------------------
# scrape and locally cache local restaurants
Import-Module Convert
Import-Module pwshPlaces

$scrapePath = $env:Temp

$locale = Invoke-BingGeoCode -Query 'New Braunfels, TX' -BingMapsAPIKey $env:BingAPIKey

$searchBingNearbyPlaceSplat = @{
    Type           = 'Restaurants'
    PointLatitude  = $locale.Latitude
    PointLongitude = $locale.Longitude
    MaxResults     = 20
    BingMapsAPIKey = $env:BingAPIKey
}
$areaRestaurants = Search-BingNearbyPlace @searchBingNearbyPlaceSplat

ConvertTo-Clixml -InputObject $areaRestaurants -Depth 100 | Out-File "$scrapePath\localRestaurants.xml"
#--------------------------------------------------------------
# where should we eat today?
$myLocalRestaurants = Get-Content -Path "$scrapePath\localRestaurants.xml" -Raw | ConvertFrom-Clixml

Get-Random $myLocalRestaurants
```
