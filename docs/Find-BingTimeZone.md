---
external help file: pwshPlaces-help.xml
Module Name: pwshPlaces
online version: https://pwshplaces.readthedocs.io/en/latest/Find-BingTimeZone
schema: 2.0.0
---

# Find-BingTimeZone

## SYNOPSIS
Retrieves time zone information for a specific location on Earth.

## SYNTAX

### textquery
```
Find-BingTimeZone -Query <String> [-RegionBias <ccTLD>] [-Language <languages>] -BingMapsAPIKey <String>
 [<CommonParameters>]
```

### Point
```
Find-BingTimeZone -PointLatitude <String> -PointLongitude <String> [-RegionBias <ccTLD>]
 [-Language <languages>] -BingMapsAPIKey <String> [<CommonParameters>]
```

## DESCRIPTION
The Find-BingTimeZone function queries the Bing Maps Time Zone API to obtain local
time zone and daylight saving time (DST) information based on either geographic coordinates
or a place name.
This function is useful for determining the time zone of any location,
including whether DST is observed and the current local time.

## EXAMPLES

### EXAMPLE 1
```
Find-BingTimeZone -Query 'New Braunfels, TX' -BingMapsAPIKey $bingAPIKey
```

Retrieves time zone information for the location matching the query 'New Braunfels, TX'.

### EXAMPLE 2
```
Find-BingTimeZone -PointLatitude 29.70 -PointLongitude -98.11 -BingMapsAPIKey $bingAPIKey
```

Returns time zone information for the specified latitude and longitude coordinates.

## PARAMETERS

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

### -PointLatitude
Specifies the latitude for location-based searches.
Single coordinate for the north-south position of a point on the Earth's surface.

```yaml
Type: String
Parameter Sets: Point
Aliases:

Required: True
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

### Bing.TimeZone
## NOTES
Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

Direct API Example:
    https://dev.virtualearth.net/REST/v1/TimeZone/{point}?datetime={datetime_utc}&key={BingMapsAPIKey}

Ensure you have a valid Bing Maps API Key.
    How to get a Bing Maps API Key:
        https://pwshplaces.readthedocs.io/en/latest/BingMapsAPI/#how-to-get-a-bing-maps-api-key

## RELATED LINKS

[https://pwshplaces.readthedocs.io/en/latest/Find-BingTimeZone](https://pwshplaces.readthedocs.io/en/latest/Find-BingTimeZone)

[https://docs.microsoft.com/bingmaps/rest-services/timezone/find-time-zone](https://docs.microsoft.com/bingmaps/rest-services/timezone/find-time-zone)

[https://docs.microsoft.com/bingmaps/rest-services/common-parameters-and-types/supported-culture-codes](https://docs.microsoft.com/bingmaps/rest-services/common-parameters-and-types/supported-culture-codes)

[https://www.microsoft.com/maps/product/terms.html](https://www.microsoft.com/maps/product/terms.html)

[https://privacy.microsoft.com/en-us/privacystatement](https://privacy.microsoft.com/en-us/privacystatement)

