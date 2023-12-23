---
external help file: pwshPlaces-help.xml
Module Name: pwshPlaces
online version: https://pwshplaces.readthedocs.io/en/latest/Get-GMapPlaceDetail
schema: 2.0.0
---

# Get-GMapPlaceDetail

## SYNOPSIS
Retrieves comprehensive details about a specified place or point of interest.

## SYNTAX

### textquery (Default)
```
Get-GMapPlaceDetail -PlaceID <String> [-Contact] [-Language <languages>] [-RegionBias <ccTLD>]
 -GoogleAPIKey <String> [<CommonParameters>]
```

### atmosphereDetail
```
Get-GMapPlaceDetail [-PlaceID <String>] [-Contact] [-Atmosphere] [-ReviewSort <String>] [-Language <languages>]
 [-RegionBias <ccTLD>] -GoogleAPIKey <String> [<CommonParameters>]
```

## DESCRIPTION
The Get-GMapPlaceDetail function interacts with the Google Maps API to fetch extensive information about a place,
identified by its PlaceID.
It provides details like the full address, phone number, website, user ratings, and reviews.
Additional information such as contact details and atmosphere data (reviews, ratings, pricing) can be requested but
are subject to higher billing rates.

## EXAMPLES

### EXAMPLE 1
```
Get-GMapPlaceDetail -PlaceID 'ChIJE43gTHK9XIYRleSxiXqF6GU' -GoogleAPIKey $googleAPIKey
```

Retrieves detailed information for the specified place ID.

### EXAMPLE 2
```
Get-GMapPlaceDetail -PlaceID 'ChIJE43gTHK9XIYRleSxiXqF6GU' -Contact -GoogleAPIKey $googleAPIKey
```

Retrieves detailed place information including contact details for the specified place ID.

### EXAMPLE 3
```
Get-GMapPlaceDetail -PlaceID 'ChIJf9Yxhme9XIYRkXo-Bl62Q10' -Contact -Atmosphere -ReviewSort Newest -Language en -GoogleAPIKey $googleAPIKey
```

Returns extensive place details including contact info, reviews, ratings, and pricing, in English, for the given place ID.
Reviews are sorted by newest.

### EXAMPLE 4
```
$getGMapPlaceDetailsSplat = @{
    PlaceID      = 'ChIJf9Yxhme9XIYRkXo-Bl62Q10'
    Contact      = $true
    Atmosphere   = $true
    ReviewSort   = 'Newest'
    Language     = 'en'
    GoogleAPIKey = $googleAPIKey
}
Get-GMapPlaceDetail @getGMapPlaceDetailsSplat
```

Returns extensive place details including contact info, reviews, ratings, and pricing, in English, for the given place ID.
Reviews are sorted by newest.

## PARAMETERS

### -PlaceID
The unique identifier of a place in Google Maps.

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
Parameter Sets: atmosphereDetail
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Contact
Includes contact information such as phone numbers and addresses (higher billing rate applies).

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
Includes atmosphere data like reviews, ratings, and pricing (higher billing rate applies).

```yaml
Type: SwitchParameter
Parameter Sets: atmosphereDetail
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReviewSort
The sorting method to use when returning reviews.
Can be set to most_relevant (default) or newest.

```yaml
Type: String
Parameter Sets: atmosphereDetail
Aliases:

Required: False
Position: Named
Default value: MostRelevant
Accept pipeline input: False
Accept wildcard characters: False
```

### -Language
Specifies the language for returned results.

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

### GMap.PlaceDetail
## NOTES
Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

- Use Invoke-GMapGeoCode if you need to retrieve latitude and longitude information.
- If you provide faulty lat/long info the API call will default back to IP based locationbias.

Direct API Example:
    https://maps.googleapis.com/maps/api/place/details/json?fields=name%2Crating%2Cformatted_phone_number&place_id=ChIJN1t_tDeuEmsRUsoyG83frY4&key=YOUR_API_KEY

Ensure you have a valid Google API Key.
    How to get a Google API Key:
        https://pwshplaces.readthedocs.io/en/latest/GoogleMapsAPI/#how-to-get-a-google-maps-api-key

This function includes Google Maps features and content; use of Google Maps features and content is subject to the terms of service and Google privacy (linked below).

## RELATED LINKS

[https://pwshplaces.readthedocs.io/en/latest/Get-GMapPlaceDetail](https://pwshplaces.readthedocs.io/en/latest/Get-GMapPlaceDetail)

[https://pwshplaces.readthedocs.io/en/latest/pwshPlaces-Google-Maps-Examples/](https://pwshplaces.readthedocs.io/en/latest/pwshPlaces-Google-Maps-Examples/)

[https://developers.google.com/maps/documentation/places/web-service/details](https://developers.google.com/maps/documentation/places/web-service/details)

[https://developers.google.com/maps/faq#languagesupport](https://developers.google.com/maps/faq#languagesupport)

[https://cloud.google.com/maps-platform/terms/](https://cloud.google.com/maps-platform/terms/)

[https://www.google.com/policies/privacy/](https://www.google.com/policies/privacy/)

