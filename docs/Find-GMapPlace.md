---
external help file: pwshPlaces-help.xml
Module Name: pwshPlaces
online version: https://pwshplaces.readthedocs.io/en/latest/Find-GMapPlace
schema: 2.0.0
---

# Find-GMapPlace

## SYNOPSIS
Searches for a place using text input, returning key details about the location.

## SYNTAX

### textquery (Default)
```
Find-GMapPlace -Query <String> [-Contact] [-Atmosphere] [-Language <languages>] -GoogleAPIKey <String>
 [<CommonParameters>]
```

### Rectangle
```
Find-GMapPlace [-Query <String>] -SouthLatitude <String> -WestLongitude <String> -NorthLatitude <String>
 -EastLongitude <String> [-Contact] [-Atmosphere] [-Language <languages>] -GoogleAPIKey <String>
 [<CommonParameters>]
```

### Circle
```
Find-GMapPlace [-Query <String>] [-CircleLatitude <String>] [-CircleLongitude <String>]
 [-CircleRadius <String>] [-Contact] [-Atmosphere] [-Language <languages>] -GoogleAPIKey <String>
 [<CommonParameters>]
```

### Point
```
Find-GMapPlace [-Query <String>] [-PointLatitude <String>] [-PointLongitude <String>] [-Contact] [-Atmosphere]
 [-Language <languages>] -GoogleAPIKey <String> [<CommonParameters>]
```

## DESCRIPTION
The Find-GMapPlace function uses Google Maps API to perform text-based searches for places,
such as businesses, landmarks, or addresses.
It supports searches by name, address, or phone number
(in international format).
The function defaults to using the user's IP address for location bias,
but this can be adjusted with additional parameters.
Basic search results are provided without
extra cost, while Contact and Atmosphere information are available at a higher rate.
Note: For more detailed information at reduced cost, consider using Get-GMapPlaceDetail.

## EXAMPLES

### EXAMPLE 1
```
Find-GMapPlace -Query "Krause's cafe" -GoogleAPIKey $googleAPIKey
```

Searches for "Krause's cafe," returning results biased by the user's IP location.

### EXAMPLE 2
```
Find-GMapPlace -Query "Krause's cafe" -Language es -GoogleAPIKey $googleAPIKey
```

Searches for "Krause's cafe" and returns results in Spanish, biased by IP location.

### EXAMPLE 3
```
Find-GMapPlace -Query '+18306252807' -GoogleAPIKey $googleAPIKey
```

Searches using a phone number, returning place information with an IP location bias.

### EXAMPLE 4
```
Find-GMapPlace -Query 'cafe' -PointLatitude '29.7049806' -PointLongitude '-98.068343' -GoogleAPIKey $googleAPIKey
```

Searches for cafes near specified coordinates.

### EXAMPLE 5
```
Find-GMapPlace -Query 'cafe' -PointLatitude '29.7049806' -PointLongitude '-98.068343' -Language en -GoogleAPIKey $googleAPIKey
```

Searches for cafes near specified coordinates and returns results in English.

### EXAMPLE 6
```
Find-GMapPlace -Query 'cafe' -CircleLatitude '29.7049806' -CircleLongitude '-98.068343' -CircleRadius '8046' -GoogleAPIKey $googleAPIKey
```

Searches for cafes within a specified radius around given coordinates.

### EXAMPLE 7
```
Find-GMapPlace -Query 'cafe' -SouthLatitude '39.8592387' -WestLongitude '-75.295486' -NorthLatitude '40.0381942' -EastLongitude '-75.0064087' -GoogleAPIKey $googleAPIKey
```

Searches for cafes within a defined rectangular area.

### EXAMPLE 8
```
Find-GMapPlace -Query '+18306252807' -PointLatitude '29.7049806' -PointLongitude '-98.068343' -Contact -Atmosphere -Language en -GoogleAPIKey $googleAPIKey
```

Searches using a phone number near specified coordinates, requesting additional Contact and Atmosphere information in English.

### EXAMPLE 9
```
$findGMapPlaceSplat = @{
    Query          = '+18306252807'
    PointLatitude  = '29.7049806'
    PointLongitude = '-98.068343'
    Contact        = $true
    Atmosphere     = $true
    Language       = 'en'
    GoogleAPIKey   = $googleAPIKey
}
Find-GMapPlace @findGMapPlaceSplat
```

Searches using a phone number near specified coordinates, requesting additional Contact and Atmosphere information in English.

## PARAMETERS

### -Query
The search input, such as a place name, address, or phone number in international format.

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
Parameter Sets: Rectangle, Circle, Point
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PointLatitude
Specifies the latitude for location-based searches.
Single coordinate for the north-south position of a point on the Earth's surface.

```yaml
Type: String
Parameter Sets: Point
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PointLongitude
Specifies the longitude for location-based searches.
Single coordinate for the east-west position of a point on the Earth's surface.

```yaml
Type: String
Parameter Sets: Point
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CircleLatitude
Prefer results in a specified area by specifying a radius plus lat/long - north-south position of a point on the Earth's surface.

```yaml
Type: String
Parameter Sets: Circle
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CircleLongitude
Prefer results in a specified area by specifying a radius plus lat/long - east-west position of a point on the Earth's surface.

```yaml
Type: String
Parameter Sets: Circle
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CircleRadius
Prefer results in a specified area by specifying a radius plus lat/long - radius in meters

```yaml
Type: String
Parameter Sets: Circle
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SouthLatitude
Prefer results in a specified area by specifying two lat/lng pairs representing the south/west and north/east points of a rectangle - south latitude

```yaml
Type: String
Parameter Sets: Rectangle
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WestLongitude
Prefer results in a specified area by specifying two lat/lng pairs representing the south/west and north/east points of a rectangle - west longitude

```yaml
Type: String
Parameter Sets: Rectangle
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NorthLatitude
Prefer results in a specified area by specifying two lat/lng pairs representing the south/west and north/east points of a rectangle - north latitude

```yaml
Type: String
Parameter Sets: Rectangle
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EastLongitude
Prefer results in a specified area by specifying two lat/lng pairs representing the south/west and north/east points of a rectangle - east longitude

```yaml
Type: String
Parameter Sets: Rectangle
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Contact
Returns contact related information about the result - contact fields are billed at a higher rate.

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

### -Atmosphere
Returns atmosphere related information including reviews and pricing about the result - atmosphere fields are billed at a higher rate.

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

### -Language
Specifies the language for the search results.

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

### GMap.Place
## NOTES
Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

- Use Invoke-GMapGeoCode if you need to retrieve latitude and longitude information.
- Basic field types are included without additional cost.
Contact and Atmosphere fields incur extra charges.
    - Don't use the Contact or Atmosphere parameters of this function.
They aren't worth it.
        - For more detailed place information, consider Get-GMapPlaceDetail.
- Phone numbers must be in international format (prefixed by a plus sign ("+"), followed by the country code, then the phone number itself)
- If you provide faulty lat/long info the API call will default back to IP based locationbias.

Direct API Example:
    https://maps.googleapis.com/maps/api/place/findplacefromtext/json?fields=formatted_address%2Cname%2Crating%2Copening_hours%2Cgeometry&input=Museum%20of%20Contemporary%20Art%20Australia&inputtype=textquery&key=YOUR_API_KEY

Ensure you have a valid Google API Key.
    How to get a Google API Key:
        https://pwshplaces.readthedocs.io/en/latest/GoogleMapsAPI/#how-to-get-a-google-maps-api-key

For basic place information, Find-GMapPlace is sufficient.
However, if you need more detailed data
about a place, use Get-GMapPlaceDetail with the Place ID obtained from \`Find-GMapPlace\`.
For a detailed guide on using these functions effectively, please refer to the examples documentation:
    https://pwshplaces.readthedocs.io/en/latest/pwshPlaces-Google-Maps-Examples/

This function includes Google Maps features and content; use of Google Maps features and content is subject to the terms of service and Google privacy (linked below).

## RELATED LINKS

[https://pwshplaces.readthedocs.io/en/latest/Find-GMapPlace](https://pwshplaces.readthedocs.io/en/latest/Find-GMapPlace)

[https://pwshplaces.readthedocs.io/en/latest/pwshPlaces-Google-Maps-Examples/](https://pwshplaces.readthedocs.io/en/latest/pwshPlaces-Google-Maps-Examples/)

[https://developers.google.com/maps/documentation/places/web-service/search-find-place](https://developers.google.com/maps/documentation/places/web-service/search-find-place)

[https://maps.googleapis.com/maps/api/place/findplacefromtext/output?parameters](https://maps.googleapis.com/maps/api/place/findplacefromtext/output?parameters)

[https://developers.google.com/maps/faq#languagesupport](https://developers.google.com/maps/faq#languagesupport)

[https://cloud.google.com/maps-platform/terms/](https://cloud.google.com/maps-platform/terms/)

[https://www.google.com/policies/privacy/](https://www.google.com/policies/privacy/)

