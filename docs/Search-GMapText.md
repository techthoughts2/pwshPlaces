---
external help file: pwshPlaces-help.xml
Module Name: pwshPlaces
online version: https://pwshplaces.readthedocs.io/en/latest/Search-GMapText
schema: 2.0.0
---

# Search-GMapText

## SYNOPSIS
Conducts a text-based search that returns information about a set of places using Google Maps.

## SYNTAX

### textquery (Default)
```
Search-GMapText -Query <String> [-Type <placeTypes>] [-Language <languages>] [-RegionBias <ccTLD>] [-OpenNow]
 [-MaxPrice <String>] [-MinPrice <String>] [-AllSearchResults] -GoogleAPIKey <String> [<CommonParameters>]
```

### Distance
```
Search-GMapText [-Query <String>] [-Latitude <String>] [-Longitude <String>] [-RankByDistance]
 [-Type <placeTypes>] [-Language <languages>] [-RegionBias <ccTLD>] [-OpenNow] [-MaxPrice <String>]
 [-MinPrice <String>] [-AllSearchResults] -GoogleAPIKey <String> [<CommonParameters>]
```

### Area
```
Search-GMapText [-Query <String>] [-Latitude <String>] [-Longitude <String>] -Radius <String>
 [-RankByProminence] [-Type <placeTypes>] [-Language <languages>] [-RegionBias <ccTLD>] [-OpenNow]
 [-MaxPrice <String>] [-MinPrice <String>] [-AllSearchResults] -GoogleAPIKey <String> [<CommonParameters>]
```

### Location
```
Search-GMapText [-Query <String>] -Latitude <String> -Longitude <String> [-Type <placeTypes>]
 [-Language <languages>] [-RegionBias <ccTLD>] [-OpenNow] [-MaxPrice <String>] [-MinPrice <String>]
 [-AllSearchResults] -GoogleAPIKey <String> [<CommonParameters>]
```

## DESCRIPTION
The Search-GMapText function uses a text query to search for places using Google's Places API.
It is especially useful for ambiguous or general searches.
Returned results can be heavily biased based
on factors such as including a location in the query itself or by providing direct location information in
optional parameters.
By default, up to 20 results are returned, which can be expanded to a maximum
of 60 by using the AllSearchResults switch.

## EXAMPLES

### EXAMPLE 1
```
Search-GMapText -Query "Krause's Cafe" -GoogleAPIKey $googleAPIKey
```

Searches for "Krause's Cafe" with results biased by the user's IP location.

### EXAMPLE 2
```
Search-GMapText -Query "Cupcakes" -Type bakery -AllSearchResults -GoogleAPIKey $googleAPIKey
```

Searches for bakeries related to "Cupcakes," returning up to 60 results biased by the user's IP location.

### EXAMPLE 3
```
Search-GMapText -Query "pizza restaurants in New York" -GoogleAPIKey $googleAPIKey
```

Searches for pizza restaurants in New York, with results biased by the location mentioned in the query.

### EXAMPLE 4
```
Search-GMapText -Query "Airport" -RegionBias es -GoogleAPIKey $googleAPIKey
```

Searches for airports with results regionally biased to Spain.

### EXAMPLE 5
```
Search-GMapText -Query "italian restaurants in New York" -MinPrice 4 -GoogleAPIKey $googleAPIKey
```

Searches for high-end Italian restaurants in New York.

### EXAMPLE 6
```
Search-GMapText -Query "main plaza New Braunfels" -Type restaurant -GoogleAPIKey $googleAPIKey
```

Conducts a text search for 'main plaza New Braunfels' focusing specifically on restaurants.
The query includes a specific location, which biases the search results towards places in and around Main Plaza in New Braunfels.
As a result, the function returns a list of restaurants that are geographically relevant to the specified area, offering a targeted selection based on the user's input location.

### EXAMPLE 7
```
Search-GMapText -Query 'Cafe' -Latitude '26.1202' -Longitude '127.7025' -Radius 5000 -Language en -GoogleAPIKey $googleAPIKey
```

Searches for cafes near specified coordinates within 5000 meters, results in English.

### EXAMPLE 8
```
Search-GMapText -Query 'Coco' -Latitude '26.1202' -Longitude '127.7025' -Radius 5000 -Language en -Type restaurant -GoogleAPIKey $googleAPIKey
```

Searches for 'Coco' restaurants near specified coordinates, results ranked by distance and returned in English.

### EXAMPLE 9
```
Search-GMapText -Query 'Coco' -Latitude '26.1202' -Longitude '127.7025' -Radius 500 -RankByProminence -GoogleAPIKey $googleAPIKey
```

Searches for 'Coco' restaurants near specified coordinates within a 500 meter range.
Places results are ranked by their prominence.

### EXAMPLE 10
```
Search-GMapText -Query 'Coco' -Latitude '26.1202' -Longitude '127.7025' -RankByDistance -Type restaurant -GoogleAPIKey $googleAPIKey
```

Searches for 'Coco' restaurants near specified coordinates, results ranked by distance.

### EXAMPLE 11
```
Search-GMapText -Query 'Coco' -Latitude '26.1202' -Longitude '127.7025' -RankByDistance -Type restaurant -Language en -OpenNow -MinPrice 1 -MaxPrice 2 -AllSearchResults -GoogleAPIKey $googleAPIKey
```

Performs an advanced search specifically for restaurants related to 'Coco' near the given coordinates.
The function filters the results to include only restaurants, ranking them based on their proximity to the provided coordinates.
Additionally, the search is refined to show only those restaurants that are currently open and fall within a cheap to moderate price range.
All search results are presented in English.
Maximum limit of 60 place results is utilized in this search.

### EXAMPLE 12
```
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
```

Performs an advanced search specifically for restaurants related to 'Coco' near the given coordinates.
The function filters the results to include only restaurants, ranking them based on their proximity to the provided coordinates.
Additionally, the search is refined to show only those restaurants that are currently open and fall within a cheap to moderate price range.
All search results are presented in English.
Maximum limit of 60 place results is utilized in this search.

## PARAMETERS

### -Query
Text string on which to search

```yaml
Type: String
Parameter Sets: textquery
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: Distance, Area, Location
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Latitude
Geographic coordinate that specifies the north-south position of a point on the Earth's surface.

```yaml
Type: String
Parameter Sets: Distance, Area
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: Location
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
Parameter Sets: Distance, Area
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: Location
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
Parameter Sets: Area
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

### -RegionBias
The region code, specified as a ccTLD ("top-level domain") two-character value.
This parameter will only influence, not fully restrict, results from the geocoder.

```yaml
Type: ccTLD
Parameter Sets: (All)
Aliases:
Accepted values: ac, ad, ae, af, ag, ai, al, am, ao, aq, ar, as, at, au, aw, ax, az, ba, bb, bd, be, bf, bg, bh, bi, bj, bm, bn, bo, br, bs, bt, bv, bw, by, bz, ca, cc, cd, cf, cg, ch, ci, ck, cl, cm, cn, co, cr, cu, cv, cw, cx, cy, cz, de, dj, dk, dm, do, dz, ec, ee, eg, er, es, et, eu, fi, fj, fk, fm, fo, fr, ga, gb, gd, ge, gf, gg, gh, gi, gl, gm, gn, gp, gq, gr, gs, gt, gu, gw, gy, hk, hm, hn, hr, ht, hu, id, ie, il, im, in, io, iq, ir, is, it, je, jm, jo, jp, ke, kg, kh, ki, km, kn, kp, kr, kw, ky, kz, la, lb, lc, li, lk, lr, ls, lt, lu, lv, ly, ma, mc, md, me, mg, mh, mk, ml, mm, mn, mo, mp, mq, mr, ms, mt, mu, mv, mw, mx, my, mz, na, nc, ne, nf, ng, ni, nl, no, np, nr, nu, nz, om, pa, pe, pf, pg, ph, pk, pl, pm, pn, pr, ps, pt, pw, py, qa, re, ro, rs, ru, rw, sa, sb, sc, sd, se, sg, sh, si, sj, sk, sl, sm, sn, so, sr, ss, st, su, sv, sx, sy, sz, tc, td, tf, tg, th, tj, tk, tl, tm, tn, to, tr, tt, tv, tw, tz, ua, ug, uk, us, uy, uz, va, vc, ve, vg, vi, vn, vu, wf, ws, ye, yt, za, zm, zw

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

### GMap.PlaceText
## NOTES
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

## RELATED LINKS

[https://pwshplaces.readthedocs.io/en/latest/Search-GMapText](https://pwshplaces.readthedocs.io/en/latest/Search-GMapText)

[https://developers.google.com/maps/documentation/places/web-service/search-text](https://developers.google.com/maps/documentation/places/web-service/search-text)

[https://maps.googleapis.com/maps/api/place/textsearch/output?parameters](https://maps.googleapis.com/maps/api/place/textsearch/output?parameters)

[https://developers.google.com/maps/faq#languagesupport](https://developers.google.com/maps/faq#languagesupport)

[https://cloud.google.com/maps-platform/terms/](https://cloud.google.com/maps-platform/terms/)

[https://www.google.com/policies/privacy/](https://www.google.com/policies/privacy/)

