# pwshPlaces - Google Maps Advanced

*Consider exploring the [pwshPlaces Google Maps Basics](pwshPlaces-Google-Maps-Basics.md) page first to gain a comprehensive understanding of the tool and its features before proceeding to the advanced page.*

## Advanced Usage

### Reading Place Reviews

Example: `Get-GMapPlaceDetail`

Description: Retrieve detailed reviews for a specific place.

```powershell
$place = Find-GMapPlace -Query 'Moriyama Sushi' -GoogleAPIKey $googleAPIKey
$placeResults = Get-GMapPlaceDetail -PlaceID $place.place_id -Contact -Atmosphere -GoogleAPIKey $googleAPIKey
$placeResults.reviews

author_name               : Pandi Mengri
author_url                : https://www.google.com/maps/contrib/103155997216156600311/reviews
language                  : en
original_language         : en
profile_photo_url         : https://lh3.googleusercontent.com/a-/ALV-UjXBSQKNln5qS4BIbWYlobh0YIgouKCKQXmh
                            biG_cj9q6w=s128-c0x00000000-cc-rp-mo
rating                    : 5
relative_time_description : a week ago
text                      : They deserve their 5 stars. Great sushi in a cozy and homey environment!
                            Must try the sushi candy and the magma roll
time                      : 1702104096
translated                : False
```

### Finding the highest rated restaurant for what you are in the mood for

Example: `Search-GMapText`

Description: Finding the highest-rated BBQ restaurants biased by your IP location.

```powershell
$results = Search-GMapText -Query 'bbq' -Type restaurant -GoogleAPIKey $googleAPIKey
$results | Sort-Object reviews -Descending | Select-Object -First 2

place_id           : ChIJI8USrKC9XIYRawtsrW0XdBM
name               : Coronado's Sweet Heat BBQ
Address            : 1920 S Seguin Ave, New Braunfels, TX 78130, United States
Latitude           : 29.6793179
Longitude          : -98.1068249
types              : {restaurant, food, point_of_interest, establishment}
rating             : 4.9
user_ratings_total : 263
price_level        :
Open               : False

place_id           : ChIJ_1fR2iS4XIYRBxcM1GpanN0
name               : Davila's BBQ
Address            : 418 W Kingsbury St, Seguin, TX 78155, United States
Latitude           : 29.580967
Longitude          : -97.9690274
types              : {restaurant, food, point_of_interest, establishment}
rating             : 4.2
user_ratings_total : 1032
price_level        : 2
Open               : False
```

### Find the closest locations for an upcoming vacation stay

Description: Find the closest locations of specific types for an upcoming vacation stay in Wailea, Hawaii. The goal is to identify the nearest park, cafe, and restaurant to the vacation address.

```powershell
$geoInfo = Invoke-GMapGeoCode -Address '3550 Wailea Alanui Drive Wailea, Hawaii, United States, 96753' -GoogleAPIKey $googleAPIKey
$types = @(
    'park'
    'cafe'
    'restaurant'
)
$types | ForEach-Object {
    $searchGMapNearbyPlaceSplat = @{
        Type           = $_
        Latitude       = $geoInfo.Latitude
        Longitude      = $geoInfo.Longitude
        GoogleAPIKey   = $googleAPIKey
        RankByDistance = $true
    }
    Search-GMapNearbyPlace @searchGMapNearbyPlaceSplat | Select-Object -First 1
}

place_id           : ChIJW3MvscTaVHkR5K_xOy1t-TM
name               : Mokapu Beach Park
Address            : Bathroom, Wailea
Latitude           : 20.6920982
Longitude          : -156.4440763
types              : {park, tourist_attraction, point_of_interest, establishment}
rating             : 4.7
user_ratings_total : 231
price_level        :
Open               : True

place_id           : ChIJqUvqIsXaVHkRjvnTQbAHy_8
name               : Starbucks
Address            : 3700 Wailea Alanui Drive, Kihei
Latitude           : 20.6878148
Longitude          : -156.442985
types              : {cafe, store, food, point_of_interest…}
rating             : 4.2
user_ratings_total : 136
price_level        : 2
Open               : True

place_id           : ChIJS_t43cTaVHkRUwxt2oNE-DE
name               : Ka'ana Kitchen
Address            : 3550 Wailea Alanui Drive, Wailea
Latitude           : 20.6925496
Longitude          : -156.4425465
types              : {restaurant, food, point_of_interest, establishment}
rating             : 4.4
user_ratings_total : 586
price_level        : 3
Open               : True
```

## API Caching

IAW with the [terms of service](https://cloud.google.com/maps-platform/terms/):

> Pre-Fetching, Caching, or Storage of Content
Applications using the Places API are bound by the Google Maps Platform Terms of Service. Section 3.2.3(a) and (b) of the terms states that you must not pre-fetch, index, store, or cache any Content except under the limited conditions stated in the terms.
Note that the place ID, used to uniquely identify a place, is exempt from the caching restriction. You can therefore store place ID values indefinitely. The place ID is returned in the place_id field in Places API responses.

This means that doing something like the following is not permitted:

Create a locally cached copy of restaurants nearby. Then use `Get-Random` to source the local cache and pick a random place to eat each day!

```powershell
#--------------------------------------------------------------
# scrape and locally cache up to 60 local restaurants
Import-Module Convert
Import-Module pwshPlaces

$scrapePath = $env:Temp

$locale = Invoke-GMapGeoCode -Address 'New Braunfels' -GoogleAPIKey $env:GoogleAPIKey

$searchGMapNearbyPlaceSplat = @{
    Latitude         = $locale.Latitude
    Longitude        = $locale.Longitude
    Radius           = 10000
    RankByProminence = $true
    Type             = 'restaurant'
    AllSearchResults = $true
    GoogleAPIKey     = $env:GoogleAPIKey
}
$areaRestaurants = Search-GMapNearbyPlace @searchGMapNearbyPlaceSplat

ConvertTo-Clixml -InputObject $areaRestaurants -Depth 100 | Out-File "$scrapePath\localRestaurants.xml"
#--------------------------------------------------------------
# where should we eat today?
$myLocalRestaurants = Get-Content -Path "$scrapePath\localRestaurants.xml" -Raw | ConvertFrom-Clixml

Get-Random $myLocalRestaurants
```
