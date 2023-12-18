---
external help file: pwshPlaces-help.xml
Module Name: pwshPlaces
online version: https://pwshplaces.readthedocs.io/en/latest/Search-GMapNearbyPlace
schema: 2.0.0
---

# Search-GMapNearbyPlace

## SYNOPSIS
Searches for places within a specified area using Google Maps Nearby Search.

## SYNTAX

### Location (Default)
```
Search-GMapNearbyPlace -Latitude <String> -Longitude <String> -Radius <String> [-Keyword <String>]
 [-Type <placeTypes>] [-Language <languages>] [-OpenNow] [-MaxPrice <String>] [-MinPrice <String>]
 [-AllSearchResults] -GoogleAPIKey <String> [<CommonParameters>]
```

### Distance
```
Search-GMapNearbyPlace -Latitude <String> -Longitude <String> [-RankByDistance] [-Keyword <String>]
 [-Type <placeTypes>] [-Language <languages>] [-OpenNow] [-MaxPrice <String>] [-MinPrice <String>]
 [-AllSearchResults] -GoogleAPIKey <String> [<CommonParameters>]
```

### Area
```
Search-GMapNearbyPlace -Latitude <String> -Longitude <String> -Radius <String> [-RankByProminence]
 [-Keyword <String>] [-Type <placeTypes>] [-Language <languages>] [-OpenNow] [-MaxPrice <String>]
 [-MinPrice <String>] [-AllSearchResults] -GoogleAPIKey <String> [<CommonParameters>]
```

## DESCRIPTION
The Search-GMapNearbyPlace function utilizes Google's Places API to perform nearby searches for places
around a specified geographic location.
By default, it returns 20 results, which can be increased to a
maximum of 60 using the AllSearchResults switch.
The function allows refining the search based on keywords,
place types, and other criteria.

## EXAMPLES

### EXAMPLE 1
```
Search-GMapNearbyPlace -Latitude '29.7049806' -Longitude '-98.068343' -Radius 5000 -GoogleAPIKey $googleAPIKey
```

Searches for places within a 5000-meter radius of the specified coordinates.

### EXAMPLE 2
```
Search-GMapNearbyPlace -Latitude '29.7049806' -Longitude '-98.068343' -Radius 10000 -RankByProminence -Keyword 'butcher' -Type store -GoogleAPIKey $googleAPIKey
```

Searches for stores related to the keyword 'butcher' within a 10000-meter radius, sorted by prominence.

### EXAMPLE 3
```
Search-GMapNearbyPlace -Latitude '38.9072' -Longitude '-77.0369' -Radius 10000 -RankByProminence -Type embassy -AllSearchResults -GoogleAPIKey $googleAPIKey
```

Searches for embassies within a 10000-meter radius, returning up to 60 results.

### EXAMPLE 4
```
Search-GMapNearbyPlace -Latitude '29.7013856' -Longitude '-98.1249258' -Radius 1000 -Type restaurant -MinPrice 1 -MaxPrice 3 -GoogleAPIKey $googleAPIKey
```

Searches for restaurants within 1000 meters in the affordable to moderately expensive price range.

### EXAMPLE 5
```
Search-GMapNearbyPlace -Latitude '29.7049806' -Longitude '-98.068343' -RankByDistance -GoogleAPIKey $googleAPIKey
```

Searches for places near the specified coordinates, ranked by distance.

### EXAMPLE 6
```
Search-GMapNearbyPlace -Latitude '26.1202' -Longitude '127.7025' -Radius 10000 -RankByProminence -Type amusement_park -Language en -GoogleAPIKey $googleAPIKey
```

Searches for amusement parks within a 10000-meter radius, results in English, sorted by prominence.

### EXAMPLE 7
```
Search-GMapNearbyPlace -Latitude '29.7049806' -Longitude '-98.068343' -Radius 5000 -RankByProminence -Keyword 'pasta' -Type restaurant -Language en -OpenNow -MaxPrice 4 -MinPrice 2 -AllSearchResults -GoogleAPIKey $googleAPIKey
```

Searches for pasta restaurants within 5000 meters, open now, priced mid to high, returning all results in English.

### EXAMPLE 8
```
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
```

Searches for pasta restaurants within 5000 meters, open now, priced mid to high, returning all results in English.

## PARAMETERS

### -Latitude
Geographic coordinate that specifies the north-south position of a point on the Earth's surface.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Longitude
Geographic coordinate that specifies the east-west position of a point on the Earth's surface.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Radius
Distance (in meters) within which to return place results.
Instructs the Places service to prefer showing results within that circle; results outside of the defined area may still be displayed.

```yaml
Type: String
Parameter Sets: Location, Area
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RankByProminence
This option sorts results based on their importance.

```yaml
Type: SwitchParameter
Parameter Sets: Area
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -RankByDistance
This option biases search results in ascending order by their distance from the specified location.

```yaml
Type: SwitchParameter
Parameter Sets: Distance
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Keyword
A term to be matched against all content that Google has indexed for this place, including but not limited to name and type, as well as customer reviews and other third-party content.
Note that explicitly including location information using this parameter may conflict with the location, radius, and rankby parameters, causing unexpected results.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type
Restricts the results to places matching the specified type.

```yaml
Type: placeTypes
Parameter Sets: (All)
Aliases:
Accepted values: accounting, airport, amusement_park, aquarium, art_gallery, atm, bakery, bank, bar, beauty_salon, bicycle_store, book_store, bowling_alley, bus_station, cafe, campground, car_dealer, car_rental, car_repair, car_wash, casino, cemetery, church, city_hall, clothing_store, convenience_store, courthouse, dentist, department_store, doctor, drugstore, electrician, electronics_store, embassy, fire_station, florist, funeral_home, furniture_store, gas_station, gym, hair_care, hardware_store, hindu_temple, home_goods_store, hospital, insurance_agency, jewelry_store, laundry, lawyer, library, light_rail_station, liquor_store, local_government_office, locksmith, lodging, meal_delivery, meal_takeaway, mosque, movie_rental, movie_theater, moving_company, museum, night_club, painter, park, parking, pet_store, pharmacy, physiotherapist, plumber, police, post_office, primary_school, real_estate_agency, restaurant, roofing_contractor, rv_park, school, secondary_school, shoe_store, shopping_mall, spa, stadium, storage, store, subway_station, supermarket, synagogue, taxi_stand, tourist_attraction, train_station, transit_station, travel_agency, university, veterinary_care, zoo

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Language
The language in which to return results.

```yaml
Type: languages
Parameter Sets: (All)
Aliases:
Accepted values: af, sq, am, ar, hy, az, eu, be, bn, bs, bg, my, ca, zh, hr, cs, da, nl, en, et, fa, fi, fil, fr, ka, de, el, iw, hi, hu, is, id, it, ja, kn, kk, km, ko, ky, lo, lv, lt, mk, ms, ml, mr, mn, ne, no, pl, pt, pa, ro, ru, sr, sk, es, sw, ta, te, th, uk, ur, uz, vi, zu

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OpenNow
Returns only those places that are open for business at the time the query is sent.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxPrice
Restricts results to only those places within the specified range.
Valid values range between 0 (most affordable) to 4 (most expensive), inclusive.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MinPrice
Restricts results to only those places within the specified range.
Valid values range between 0 (most affordable) to 4 (most expensive), inclusive.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllSearchResults
By default 20 results are returned from a standard search.
Using this switch increases the search results from 20 to the maximum of 60.
This does increase the number of API calls.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -GoogleAPIKey
Google API Key

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### GMap.NearbyPlace
## NOTES
Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

- Use Invoke-GMapGeoCode if you need to retrieve latitude and longitude information.

Direct API Example:
    https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522%2C151.1957362&radius=1500&type=restaurant&keyword=cruise&key=YOUR_API_KEY

Ensure you have a valid Google API Key.
    How to get a Google API Key:
        https://pwshplaces.readthedocs.io/en/latest/GoogleMapsAPI/#how-to-get-a-google-maps-api-key

Nearby Search and Text Search return all of the available data fields for the selected place (a subset of the supported fields), and you will be billed accordingly There is no way to constrain Nearby Search or Text Search to only return specific fields.
To keep from requesting (and paying for) data that you don't need, use a Find Place request instead.

Use of the AllSearchResults parameter does increase the number of API calls.

This function includes Google Maps features and content; use of Google Maps features and content is subject to the terms of service and Google privacy (linked below).

## RELATED LINKS

[https://pwshplaces.readthedocs.io/en/latest/Search-GMapNearbyPlace](https://pwshplaces.readthedocs.io/en/latest/Search-GMapNearbyPlace)

[https://pwshplaces.readthedocs.io/en/latest/pwshPlaces-Google-Maps-Examples/](https://pwshplaces.readthedocs.io/en/latest/pwshPlaces-Google-Maps-Examples/)

[https://developers.google.com/maps/documentation/places/web-service/search-nearby](https://developers.google.com/maps/documentation/places/web-service/search-nearby)

[https://developers.google.com/maps/faq#languagesupport](https://developers.google.com/maps/faq#languagesupport)

[https://cloud.google.com/maps-platform/terms/](https://cloud.google.com/maps-platform/terms/)

[https://www.google.com/policies/privacy/](https://www.google.com/policies/privacy/)

