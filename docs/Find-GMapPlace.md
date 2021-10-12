---
external help file: pwshPlaces-help.xml
Module Name: pwshPlaces
online version: https://github.com/techthoughts2/pwshPlaces/blob/master/docs/Find-GMapPlace.md
schema: 2.0.0
---

# Find-GMapPlace

## SYNOPSIS
Find Place request takes a text input and returns a place.
The input can be any kind of Places text data, such as a name, address, or phone number.

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
Performs a find place request with provided parameters.
A text search is performed unless a properly formatted phone number is provided in which case
a phonenumber search is completed.
By default, the location bias and language is IP based.
Location bias and language can be controlled via parameters.
The information returned in a normal
call contains all basic field types.
Additional field types including contact and atmosphere information
can be called for but these carry an additional cost.
The Find Place return does not return
all fields of these more expensive calls and has a limited return.
See notes for details.

## EXAMPLES

### EXAMPLE 1
```
Find-GMapPlace -Query "Krause's cafe" -GoogleAPIKey $googleAPIKey
```

Returns place information for the query location biased by IP.

### EXAMPLE 2
```
Find-GMapPlace -Query "Krause's cafe" -Language es -GoogleAPIKey $googleAPIKey
```

Returns place information for the query location biased by IP and returns results in Spanish.

### EXAMPLE 3
```
Find-GMapPlace -Query '+18306252807' -GoogleAPIKey $googleAPIKey
```

Returns place information for the query location biased by IP.

### EXAMPLE 4
```
Find-GMapPlace -Query 'cafe' -PointLatitude '29.7049806' -PointLongitude '-98.068343' -GoogleAPIKey $googleAPIKey
```

Returns place information for the query location biased by provided lat/long point.

### EXAMPLE 5
```
Find-GMapPlace -Query 'cafe' -PointLatitude '29.7049806' -PointLongitude '-98.068343' -Language en -GoogleAPIKey $googleAPIKey
```

Returns place information for the query location biased by provided lat/long point and returns results in English.

### EXAMPLE 6
```
Find-GMapPlace -Query 'cafe' -CircleLatitude '29.7049806' -CircleLongitude '-98.068343' -CircleRadius '8046' -GoogleAPIKey $googleAPIKey
```

Returns place information for the query location biased by circle lat/long/radius.

### EXAMPLE 7
```
Find-GMapPlace -Query 'cafe' -SouthLatitude '39.8592387' -WestLongitude '-75.295486' -NorthLatitude '40.0381942' -EastLongitude '-75.0064087' -GoogleAPIKey $googleAPIKey
```

Returns place information for the query location biased by rectangular two lat/lng pairs in decimal degrees, representing the south/west and north/east points of a rectangle.

### EXAMPLE 8
```
Find-GMapPlace -Query '+18306252807' -PointLatitude '29.7049806' -PointLongitude '-98.068343' -Contact -Atmosphere -Language en -GoogleAPIKey $googleAPIKey
```

Returns place information for the query location biased by provided lat/long point with additional Contact and Atmosphere fields with results in English.

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

Returns place information for the query location biased by provided lat/long point with additional Contact and Atmosphere fields with results in English.

## PARAMETERS

### -Query
Text input that identifies the search target, such as a name, address, or phone number.
Phone numbers must be in international format (prefixed by a plus sign ("+"), followed by the country code, then the phone number itself)

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
Prefer results in a specified area by specifying a single coordinate for the north-south position of a point on the Earth's surface.

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
Prefer results in a specified area by specifying a single coordinate for the east-west position of a point on the Earth's surface.

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

Latitude and Longitude information can be easily retrieved using Invoke-GMapGeoCode

If you provide faulty lat/long info the API call will default back to IP based locationbias.

Required parameters
    input
        Text input that identifies the search target, such as a name, address, or phone number.
The input must be a string.
    inputtype
        The type of input.
This can be one of either textquery or phonenumber.
            Phone numbers must be in international format (prefixed by a plus sign ("+"), followed by the country code, then the phone number itself)
Optional parameters
    fields
        Billing Categories
            Basic - no charge
            Contact
            Atmosphere
    language
    locationbias
        Prefer results in a specified area, by specifying either a radius plus lat/lng, or two lat/lng pairs representing the points of a rectangle.
If this parameter is not specified, the API uses IP address biasing by default.

IP bias: Instructs the API to use IP address biasing.
Pass the string ipbias (this option has no additional parameters).
Point: A single lat/lng coordinate.
Use the following format: point:lat,lng.
Circular: A string specifying radius in meters, plus lat/lng in decimal degrees.
Use the following format: circle:radius@lat,lng.
Rectangular: A string specifying two lat/lng pairs in decimal degrees

Example:
    https://maps.googleapis.com/maps/api/place/findplacefromtext/json?fields=formatted_address%2Cname%2Crating%2Copening_hours%2Cgeometry&input=Museum%20of%20Contemporary%20Art%20Australia&inputtype=textquery&key=YOUR_API_KEY

How to get a Google API Key:
    https://github.com/techthoughts2/pwshPlaces/blob/main/docs/GoogleMapsAPI.md#how-to-get-a-google-maps-api-key

Caution: Place Search requests and Place Details requests do not return the same fields.
Place Search requests return a subset of the fields that are returned by Place Details requests.
If the field you want is not returned by Place Search, you can use Place Search to get a place_id,
then use that Place ID to make a Place Details request.
^ this essentially means you are better served with the find by using basic fields only.
If you need additional information make a subsequent Place Details API call.

Don't use the Contact or Atmosphere parameters of this function.
They aren't worth it.
If you need more detail use Get-GMapPlaceDetail

This function includes Google Maps features and content; use of Google Maps features and content is subject to the terms of service and Google privacy (linked below).

## RELATED LINKS

[https://github.com/techthoughts2/pwshPlaces/blob/master/docs/Find-GMapPlace.md](https://github.com/techthoughts2/pwshPlaces/blob/master/docs/Find-GMapPlace.md)

[https://developers.google.com/maps/documentation/places/web-service/search-find-place](https://developers.google.com/maps/documentation/places/web-service/search-find-place)

[https://maps.googleapis.com/maps/api/place/findplacefromtext/output?parameters](https://maps.googleapis.com/maps/api/place/findplacefromtext/output?parameters)

[https://developers.google.com/maps/faq#languagesupport](https://developers.google.com/maps/faq#languagesupport)

[https://cloud.google.com/maps-platform/terms/](https://cloud.google.com/maps-platform/terms/)

[https://www.google.com/policies/privacy/](https://www.google.com/policies/privacy/)

