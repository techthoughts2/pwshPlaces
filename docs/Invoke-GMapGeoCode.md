---
external help file: pwshPlaces-help.xml
Module Name: pwshPlaces
online version: https://pwshplaces.readthedocs.io/en/latest/Invoke-GMapGeoCode
schema: 2.0.0
---

# Invoke-GMapGeoCode

## SYNOPSIS
Converts addresses to geographic coordinates and vice versa using Google's Geocoding API.

## SYNTAX

### Address
```
Invoke-GMapGeoCode -Address <String> [-Language <languages>] [-RegionBias <ccTLD>] -GoogleAPIKey <String>
 [<CommonParameters>]
```

### Location
```
Invoke-GMapGeoCode -Latitude <String> -Longitude <String> [-Language <languages>] [-RegionBias <ccTLD>]
 -GoogleAPIKey <String> [<CommonParameters>]
```

### PlaceID
```
Invoke-GMapGeoCode -PlaceID <String> [-Language <languages>] [-RegionBias <ccTLD>] -GoogleAPIKey <String>
 [<CommonParameters>]
```

## DESCRIPTION
The Invoke-GMapGeoCode function utilizes Google's Geocoding API to convert street addresses into geographic coordinates
(latitude and longitude) and perform reverse geocoding, which converts coordinates back into readable addresses.
This function can also use a Google Place ID to retrieve geocoding information about a specific location.

## EXAMPLES

### EXAMPLE 1
```
Invoke-GMapGeoCode -Address '148 S Castell Ave, New Braunfels, TX 78130, United States' -GoogleAPIKey $googleAPIKey
```

Performs geocoding to find the latitude and longitude of the given address

### EXAMPLE 2
```
Invoke-GMapGeoCode -Latitude '29.7012853' -Longitude '-98.1250235' -GoogleAPIKey $googleAPIKey
```

Performs reverse geocoding on the provided coordinates, returning potential address matches.

### EXAMPLE 3
```
Invoke-GMapGeoCode -Latitude '37.621313' -Longitude '-122.378955' -Language es -GoogleAPIKey $googleAPIKey
```

Performs reverse geocoding on the provided coordinates, returning address results in Spanish.

### EXAMPLE 4
```
Invoke-GMapGeoCode -PlaceID 'ChIJK34phme9XIYRqstHW_gHr2w' -GoogleAPIKey $googleAPIKey
```

Retrieves geocoding information for the specified place ID.

## PARAMETERS

### -Address
The street address or plus code that you want to geocode.
Specify addresses in accordance with the format used by the national postal service of the country concerned.
Additional address elements such as business names and unit, suite or floor numbers should be avoided.

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

### -PlaceID
The place ID of the place for which you wish to obtain the human-readable address.
The place ID is a unique identifier that can be used with other Google APIs.

```yaml
Type: String
Parameter Sets: PlaceID
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

### GMap.GeoCode
## NOTES
Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

This function does not support pipeline input because of this issue:
    https://github.com/PowerShell/PowerShell/issues/10188

Direct API Example:
    https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&key=YOUR_API_KEY

Ensure you have a valid Google API Key.
    How to get a Google API Key:
        https://pwshplaces.readthedocs.io/en/latest/GoogleMapsAPI/#how-to-get-a-google-maps-api-key

This function includes Google Maps features and content; use of Google Maps features and content is subject to the terms of service and Google privacy (linked below).

## RELATED LINKS

[https://pwshplaces.readthedocs.io/en/latest/Invoke-GMapGeoCode](https://pwshplaces.readthedocs.io/en/latest/Invoke-GMapGeoCode)

[https://pwshplaces.readthedocs.io/en/latest/pwshPlaces-Google-Maps-Examples/](https://pwshplaces.readthedocs.io/en/latest/pwshPlaces-Google-Maps-Examples/)

[https://developers.google.com/maps/documentation/geocoding/overview](https://developers.google.com/maps/documentation/geocoding/overview)

[https://developers.google.com/maps/documentation/geocoding/requests-geocoding](https://developers.google.com/maps/documentation/geocoding/requests-geocoding)

[https://developers.google.com/maps/documentation/geocoding/requests-reverse-geocoding](https://developers.google.com/maps/documentation/geocoding/requests-reverse-geocoding)

[https://developers.google.com/maps/faq#languagesupport](https://developers.google.com/maps/faq#languagesupport)

[https://cloud.google.com/maps-platform/terms/](https://cloud.google.com/maps-platform/terms/)

[https://www.google.com/policies/privacy/](https://www.google.com/policies/privacy/)

