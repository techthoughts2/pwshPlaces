---
external help file: pwshPlaces-help.xml
Module Name: pwshPlaces
online version: https://pwshplaces.readthedocs.io/en/latest/Invoke-BingGeoCode
schema: 2.0.0
---

# Invoke-BingGeoCode

## SYNOPSIS
Engages Bing Maps API to return address and geographic coordinates based on provided query parameters.

## SYNTAX

### Address
```
Invoke-BingGeoCode -AddressLine <String> -City <String> -State <String> -PostalCode <String> [-Country <ccTLD>]
 [-Language <languages>] [-MaxResults <Int32>] -BingMapsAPIKey <String> [<CommonParameters>]
```

### Location
```
Invoke-BingGeoCode -Latitude <String> -Longitude <String> [-Language <languages>] [-MaxResults <Int32>]
 -BingMapsAPIKey <String> [<CommonParameters>]
```

### textquery
```
Invoke-BingGeoCode -Query <String> [-Language <languages>] [-MaxResults <Int32>] -BingMapsAPIKey <String>
 [<CommonParameters>]
```

## DESCRIPTION
Geocoding is the process of converting addresses (like "1600 Amphitheatre Parkway, Mountain View, CA") into geographic coordinates.
This function can take in an address and return coordinate information.
You can also provide coordinates to return multiple nearby address results.

## EXAMPLES

### EXAMPLE 1
```
Invoke-BingGeoCode -AddressLine '148 S Castell Ave' -City 'New Braunfels' -State TX -PostalCode 78130 -BingMapsAPIKey $bingAPIKey
```

Performs Geocoding (latitude/longitude lookup) on provided address.

### EXAMPLE 2
```
Invoke-BingGeoCode -Latitude '29.7030' -Longitude '-98.1245' -BingMapsAPIKey $bingAPIKey
```

Performs Reverse geocoding (address lookup) on provided coordinates and can return multiple address results.

### EXAMPLE 3
```
Invoke-BingGeoCode -Query 'The Alamo' -BingMapsAPIKey $bingAPIKey
```

Searches for provided query and if a match is found will return Geocoding (latitude/longitude lookup) of the results.

### EXAMPLE 4
```
Invoke-BingGeoCode -AddressLine '148 S Castell Ave' -City 'New Braunfels' -State TX -PostalCode 78130 -Country us -Language en -MaxResults 20 -BingMapsAPIKey $bingAPIKey
```

Performs Geocoding (latitude/longitude lookup) on provided address.
Results are biased to the United States country.
Results are returned in English.
Up to 20 results are returned.

### EXAMPLE 5
```
$invokeBingGeoCodeSplat = @{
    AddressLine    = '148 S Castell Ave'
    City           = 'New Braunfels'
    State          = 'TX'
    PostalCode     = 78130
    Country        = 'us'
    Language       = 'en'
    MaxResults     = 20
    BingMapsAPIKey = $bingAPIKey
}
Invoke-BingGeoCode @invokeBingGeoCodeSplat
```

Performs Geocoding (latitude/longitude lookup) on provided address.
Results are biased to the United States country.
Results are returned in English.
Up to 20 results are returned.

## PARAMETERS

### -AddressLine
A string specifying the street line of an address.

```yaml
Type: String
Parameter Sets: Address
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -City
The locality, such as the city or neighborhood, that corresponds to an address.

```yaml
Type: String
Parameter Sets: Address
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -State
The subdivision name in the country or region for an address.
This element is typically treated as the first order administrative subdivision, but in some cases it is the second, third, or fourth order subdivision in a country, dependency, or region.
A string that contains a subdivision, such as the abbreviation of a US state.

```yaml
Type: String
Parameter Sets: Address
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PostalCode
The post code, postal code, or ZIP Code of an address.

```yaml
Type: String
Parameter Sets: Address
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Country
The ISO country code for the country.

```yaml
Type: ccTLD
Parameter Sets: Address
Aliases:
Accepted values: ac, ad, ae, af, ag, ai, al, am, ao, aq, ar, as, at, au, aw, ax, az, ba, bb, bd, be, bf, bg, bh, bi, bj, bm, bn, bo, br, bs, bt, bv, bw, by, bz, ca, cc, cd, cf, cg, ch, ci, ck, cl, cm, cn, co, cr, cu, cv, cw, cx, cy, cz, de, dj, dk, dm, do, dz, ec, ee, eg, er, es, et, eu, fi, fj, fk, fm, fo, fr, ga, gb, gd, ge, gf, gg, gh, gi, gl, gm, gn, gp, gq, gr, gs, gt, gu, gw, gy, hk, hm, hn, hr, ht, hu, id, ie, il, im, in, io, iq, ir, is, it, je, jm, jo, jp, ke, kg, kh, ki, km, kn, kp, kr, kw, ky, kz, la, lb, lc, li, lk, lr, ls, lt, lu, lv, ly, ma, mc, md, me, mg, mh, mk, ml, mm, mn, mo, mp, mq, mr, ms, mt, mu, mv, mw, mx, my, mz, na, nc, ne, nf, ng, ni, nl, no, np, nr, nu, nz, om, pa, pe, pf, pg, ph, pk, pl, pm, pn, pr, ps, pt, pw, py, qa, re, ro, rs, ru, rw, sa, sb, sc, sd, se, sg, sh, si, sj, sk, sl, sm, sn, so, sr, ss, st, su, sv, sx, sy, sz, tc, td, tf, tg, th, tj, tk, tl, tm, tn, to, tr, tt, tv, tw, tz, ua, ug, uk, us, uy, uz, va, vc, ve, vg, vi, vn, vu, wf, ws, ye, yt, za, zm, zw

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
Parameter Sets: Location
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Query
Specifies the search term string, such as an address, business name, or landmark name.

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
Specifies the maximum number of locations to return in the response.
If not specified, the default is 5.

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

### -BingMapsAPIKey
Bing Maps API Key

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

### Bing.GeoCode
## NOTES
Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

Direct API Example:
    http://dev.virtualearth.net/REST/v1/Locations?countryRegion={countryRegion}&adminDistrict={adminDistrict}&locality={locality}&postalCode={postalCode}&addressLine={addressLine}&userLocation={userLocation}&userIp={userIp}&usermapView={usermapView}&includeNeighborhood={includeNeighborhood}&maxResults={maxResults}&key={BingMapsKey}

Ensure you have a valid Bing Maps API Key.
    How to get a Bing Maps API Key:
        https://pwshplaces.readthedocs.io/en/latest/BingMapsAPI/#how-to-get-a-bing-maps-api-key

While the Bing Location API does support a text query option, I have found it to be unreliable.
For GeoCode info stick to Addresses and Lat/Long for reverse Geocoding.
For Text Queries use other Bing Maps functions.

## RELATED LINKS

[https://pwshplaces.readthedocs.io/en/latest/Invoke-BingGeoCode](https://pwshplaces.readthedocs.io/en/latest/Invoke-BingGeoCode)

[https://docs.microsoft.com/bingmaps/rest-services/locations/find-a-location-by-address](https://docs.microsoft.com/bingmaps/rest-services/locations/find-a-location-by-address)

[https://docs.microsoft.com/bingmaps/rest-services/locations/find-a-location-by-point](https://docs.microsoft.com/bingmaps/rest-services/locations/find-a-location-by-point)

[https://docs.microsoft.com/bingmaps/rest-services/locations/find-a-location-by-query](https://docs.microsoft.com/bingmaps/rest-services/locations/find-a-location-by-query)

[https://docs.microsoft.com/bingmaps/rest-services/common-parameters-and-types/supported-culture-codes](https://docs.microsoft.com/bingmaps/rest-services/common-parameters-and-types/supported-culture-codes)

[https://www.microsoft.com/maps/product/terms.html](https://www.microsoft.com/maps/product/terms.html)

[https://privacy.microsoft.com/en-us/privacystatement](https://privacy.microsoft.com/en-us/privacystatement)

