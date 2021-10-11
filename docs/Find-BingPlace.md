---
external help file: pwshPlaces-help.xml
Module Name: pwshPlaces
online version: https://github.com/techthoughts2/pwshPlaces/blob/master/docs/Find-BingPlace.md
schema: 2.0.0
---

# Find-BingPlace

## SYNOPSIS
Returns a list of business entities centered around a location or a geographic region

## SYNTAX

### textquery (Default)
```
Find-BingPlace -Query <String> [-RegionBias <ccTLD>] [-Language <languages>] [-MaxResults <Int32>]
 [<CommonParameters>]
```

### Rectangle
```
Find-BingPlace [-Query <String>] -SouthLatitude <String> -WestLongitude <String> -NorthLatitude <String>
 -EastLongitude <String> [-RegionBias <ccTLD>] [-Language <languages>] [-MaxResults <Int32>]
 [<CommonParameters>]
```

### Circle
```
Find-BingPlace [-Query <String>] [-CircleLatitude <String>] [-CircleLongitude <String>]
 [-CircleRadius <String>] [-RegionBias <ccTLD>] [-Language <languages>] [-MaxResults <Int32>]
 [<CommonParameters>]
```

### Point
```
Find-BingPlace [-Query <String>] [-PointLatitude <String>] [-PointLongitude <String>] [-RegionBias <ccTLD>]
 [-Language <languages>] [-MaxResults <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Performs a find place request with provided parameters.
A text search is performed that returns a list of business entities.
By default, the location bias is IP based.
Location bias and language can be controlled via parameters.

## EXAMPLES

### EXAMPLE 1
```
Find-BingPlace -Query "Krause's cafe"
```

Returns place information for the query location biased by IP.

### EXAMPLE 2
```
Find-BingPlace -Query "Krause's cafe" -Language es
```

Returns place information for the query location biased by IP and returns a few portions of the results in Spanish.

### EXAMPLE 3
```
Find-BingPlace -Query 'cafe' -PointLatitude '29.7049806' -PointLongitude '-98.068343'
```

Returns place information for the query location biased by provided lat/long point.

### EXAMPLE 4
```
Find-BingPlace -Query 'cafe' -CircleLatitude '29.7049806' -CircleLongitude '-98.068343' -CircleRadius '5000'
```

Returns place information for the query location biased by circle lat/long/radius.

### EXAMPLE 5
```
Find-BingPlace -Query 'cafe' -SouthLatitude '39.8592387' -WestLongitude '-75.295486' -NorthLatitude '40.0381942' -EastLongitude '-75.0064087'
```

Returns place information for the query location biased by rectangular two lat/lng pairs in decimal degrees, representing the south/west and north/east points of a rectangle.

### EXAMPLE 6
```
Find-BingPlace -Query 'cafe' -PointLatitude '29.7049806' -PointLongitude '-98.068343' -Language en -MaxResults 20
```

Returns place information for the query location biased by provided lat/long point with a maximum of 20 results in English.

### EXAMPLE 7
```
$findBingPlaceSplat = @{
    Query          = 'cafe'
    PointLatitude  = '29.7049806'
    PointLongitude = '-98.068343'
    Language       = 'en'
    MaxResults     = 20
}
Find-BingPlace @findBingPlaceSplat
```

Returns place information for the query location biased by provided lat/long point with a maximum of 20 results in English.

## PARAMETERS

### -Query
A string that contains information about a location, such as an address or landmark name.

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

### -RegionBias
The region code, specified as a ccTLD ("top-level domain") two-character value.

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

### -MaxResults
Specifies the maximum number of locations to return in the response

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Bing.Place
## NOTES
Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

Example:
    https://dev.virtualearth.net/REST/v1/LocalSearch/?query={query}&userLocation={point}&key={BingMapsAPIKey}

## RELATED LINKS

[https://github.com/techthoughts2/pwshPlaces/blob/master/docs/Find-BingPlace.md](https://github.com/techthoughts2/pwshPlaces/blob/master/docs/Find-BingPlace.md)

[https://docs.microsoft.com/bingmaps/rest-services/locations/local-search](https://docs.microsoft.com/bingmaps/rest-services/locations/local-search)

[https://docs.microsoft.com/bingmaps/rest-services/common-parameters-and-types/user-context-parameters](https://docs.microsoft.com/bingmaps/rest-services/common-parameters-and-types/user-context-parameters)

[https://docs.microsoft.com/bingmaps/rest-services/common-parameters-and-types/supported-culture-codes](https://docs.microsoft.com/bingmaps/rest-services/common-parameters-and-types/supported-culture-codes)

[https://www.microsoft.com/maps/product/terms.html](https://www.microsoft.com/maps/product/terms.html)

[https://privacy.microsoft.com/en-us/privacystatement](https://privacy.microsoft.com/en-us/privacystatement)

