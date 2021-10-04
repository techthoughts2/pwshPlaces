---
external help file: pwshPlaces-help.xml
Module Name: pwshPlaces
online version: https://github.com/techthoughts2/pwshPlaces/blob/master/docs/Get-GMapPlaceDetail.md
schema: 2.0.0
---

# Get-GMapPlaceDetail

## SYNOPSIS
Request more details about a particular establishment or point of interest

## SYNTAX

```
Get-GMapPlaceDetail -PlaceID <String> [-Contact] [-Atmosphere] [-Language <languages>] [-RegionBias <ccTLD>]
 [<CommonParameters>]
```

## DESCRIPTION
Place Details request returns more comprehensive information about the indicated place such as its complete address, phone number, website, user rating and reviews.

## EXAMPLES

### EXAMPLE 1
```
Get-GMapPlaceDetail -PlaceID 'ChIJE43gTHK9XIYRleSxiXqF6GU'
```

Returns detailed place information about provided place ID.

### EXAMPLE 2
```
Get-GMapPlaceDetail -PlaceID 'ChIJE43gTHK9XIYRleSxiXqF6GU' -Contact
```

Returns detailed place information about provided place ID including detailed contact information.

### EXAMPLE 3
```
Get-GMapPlaceDetail -PlaceID 'ChIJf9Yxhme9XIYRkXo-Bl62Q10' -Contact -Atmosphere -Language en
```

Returns detailed place information about provided place ID including detailed contact, review, rating, and pricing information.
Results are returned in English.

### EXAMPLE 4
```
$getGMapPlaceDetailsSplat = @{
    PlaceID    = 'ChIJf9Yxhme9XIYRkXo-Bl62Q10'
    Contact    = $true
    Atmosphere = $true
    Language   = 'en'
}
Get-GMapPlaceDetail @getGMapPlaceDetailsSplat
```

Returns detailed place information about provided place ID including detailed contact, review, rating, and pricing information.
Results are returned in English.

## PARAMETERS

### -PlaceID
A textual identifier that uniquely identifies a place

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Output from this cmdlet (if any)
## NOTES
Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

Latitude and Longitude information can be easily retrieved using Invoke-GMapGeoCode

If you provide faulty lat/long info the API call will default back to IP based locationbias.

Required parameters
    place_id
        A textual identifier that uniquely identifies a place
Optional parameters
    fields
        Billing Categories
            Basic - no charge
                address_component, adr_address, business_status, formatted_address, geometry, icon, icon_mask_base_uri, icon_background_color, name, permanently_closed (deprecated), photo, place_id, plus_code, type, url, utc_offset, vicinity
            Contact
                formatted_phone_number, international_phone_number, opening_hours, website
            Atmosphere
                price_level, rating, review, user_ratings_total.
    language
    region

Example:
    https://maps.googleapis.com/maps/api/place/details/json?fields=name%2Crating%2Cformatted_phone_number&place_id=ChIJN1t_tDeuEmsRUsoyG83frY4&key=YOUR_API_KEY

This function includes Google Maps features and content; use of Google Maps features and content is subject to the terms of service and Google privacy (linked below).

## RELATED LINKS

[https://github.com/techthoughts2/pwshPlaces/blob/master/docs/Get-GMapPlaceDetail.md](https://github.com/techthoughts2/pwshPlaces/blob/master/docs/Get-GMapPlaceDetail.md)

[https://developers.google.com/maps/documentation/places/web-service/details](https://developers.google.com/maps/documentation/places/web-service/details)

[https://developers.google.com/maps/faq#languagesupport](https://developers.google.com/maps/faq#languagesupport)

[https://cloud.google.com/maps-platform/terms/](https://cloud.google.com/maps-platform/terms/)

[https://www.google.com/policies/privacy/](https://www.google.com/policies/privacy/)

