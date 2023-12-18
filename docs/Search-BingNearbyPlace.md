---
external help file: pwshPlaces-help.xml
Module Name: pwshPlaces
online version: https://pwshplaces.readthedocs.io/en/latest/Search-BingNearbyPlace
schema: 2.0.0
---

# Search-BingNearbyPlace

## SYNOPSIS
Nearby Search lets you search for places of interest within a specified area using Bing Maps API.

## SYNTAX

### PlaceType (Default)
```
Search-BingNearbyPlace -Type <typeIdentifier> [-RegionBias <ccTLD>] [-Language <languages>]
 [-MaxResults <Int32>] -BingMapsAPIKey <String> [<CommonParameters>]
```

### Rectangle
```
Search-BingNearbyPlace [-Type <typeIdentifier>] -SouthLatitude <String> -WestLongitude <String>
 -NorthLatitude <String> -EastLongitude <String> [-RegionBias <ccTLD>] [-Language <languages>]
 [-MaxResults <Int32>] -BingMapsAPIKey <String> [<CommonParameters>]
```

### Circle
```
Search-BingNearbyPlace [-Type <typeIdentifier>] [-CircleLatitude <String>] [-CircleLongitude <String>]
 [-CircleRadius <String>] [-RegionBias <ccTLD>] [-Language <languages>] [-MaxResults <Int32>]
 -BingMapsAPIKey <String> [<CommonParameters>]
```

### Point
```
Search-BingNearbyPlace [-Type <typeIdentifier>] [-PointLatitude <String>] [-PointLongitude <String>]
 [-RegionBias <ccTLD>] [-Language <languages>] [-MaxResults <Int32>] -BingMapsAPIKey <String>
 [<CommonParameters>]
```

## DESCRIPTION
The Search-BingNearbyPlace function conducts a nearby search for various place types, such as attractions,
restaurants, or parks, within a specified geographic area.
Users can define the search area using coordinates,
radius, or a rectangular area.
By default, search results are biased based on the user's IP location,
but this can be customized using various geographic parameters.
Location bias and language can also be controlled via parameters.

## EXAMPLES

### EXAMPLE 1
```
Search-BingNearbyPlace -Type Attractions -BingMapsAPIKey $bingAPIKey
```

Searches for attractions near the user's IP location.

### EXAMPLE 2
```
Search-BingNearbyPlace -Type Restaurants -MaxResults 20 -BingMapsAPIKey $bingAPIKey
```

Finds up to 20 restaurants near the user's IP location.

### EXAMPLE 3
```
Search-BingNearbyPlace -Type CafeRestaurants -PointLatitude '29.7049806' -PointLongitude '-98.068343' -BingMapsAPIKey $bingAPIKey
```

Searches for cafe restaurants near the specified coordinates.

### EXAMPLE 4
```
Search-BingNearbyPlace -Type BreweriesAndBrewPubs -CircleLatitude '29.7049806' -CircleLongitude '-98.068343' -CircleRadius '5000' -BingMapsAPIKey $bingAPIKey
```

Searches for breweries and brewpubs within a 5000-meter radius of the specified circle coordinates.

### EXAMPLE 5
```
Search-BingNearbyPlace -Type Parks -SouthLatitude '39.8592387' -WestLongitude '-75.295486' -NorthLatitude '40.0381942' -EastLongitude '-75.0064087' -BingMapsAPIKey $bingAPIKey
```

Searches for parks within a rectangular area defined by two sets of latitude and longitude coordinates.

### EXAMPLE 6
```
Search-BingNearbyPlace -Type Museums -PointLatitude '29.7049806' -PointLongitude '-98.068343' -Language en -MaxResults 20 -BingMapsAPIKey $bingAPIKey
```

Finds up to 20 museums near the specified coordinates, with results in English.

### EXAMPLE 7
```
$searchBingNearbyPlaceSplat = @{
    Type           = 'Museums'
    PointLatitude  = '29.7049806'
    PointLongitude = '-98.068343'
    Language       = 'en'
    MaxResults     = 20
    BingMapsAPIKey = $bingAPIKey
}
Search-BingNearbyPlace @searchBingNearbyPlaceSplat
```

Finds up to 20 museums near the specified coordinates, with results in English.

## PARAMETERS

### -Type
Restricts the results to places matching the specified type

```yaml
Type: typeIdentifier
Parameter Sets: PlaceType
Aliases:
Accepted values: AmusementParks, AntiqueStores, Attractions, BanksAndCreditUnions, Bars, BarsGrillsAndPubs, BelgianRestaurants, Bookstores, BreweriesAndBrewPubs, BritishRestaurants, BuffetRestaurants, CDAndRecordStores, CafeRestaurants, CaribbeanRestaurants, Carnivals, Casinos, ChildrensClothingStores, ChineseRestaurants, CigarAndTobaccoShops, CocktailLounges, CoffeeAndTea, ComicBookStores, Delicatessens, DeliveryService, DepartmentStores, Diners, DiscountStores, Donuts, FastFood, FleaMarketsAndBazaars, FrenchRestaurants, FrozenYogurt, FurnitureStores, GermanRestaurants, GreekRestaurants, Grocers, Grocery, HawaiianRestaurants, HomeImprovementStores, Hospitals, HotelsAndMotels, HungarianRestaurants, IceCreamAndFrozenDesserts, IndianRestaurants, ItalianRestaurants, JapaneseRestaurants, JewelryAndWatchesStores, Juices, KitchenwareStores, KoreanRestaurants, LandmarksAndHistoricalSites, LiquorStores, MallsAndShoppingCenters, MensClothingStores, MexicanRestaurants, MiddleEasternRestaurants, MiniatureGolfCourses, MovieTheaters, Museums, MusicStores, OutletStores, Parking, Parks, PetShops, PetSupplyStores, Pizza, PolishRestaurants, PortugueseRestaurants, Pretzels, Restaurants, RussianAndUkrainianRestaurants, Sandwiches, SchoolAndOfficeSupplyStores, SeafoodRestaurants, ShoeStores, SightseeingTours, SpanishRestaurants, SportingGoodsStores, SportsBars, SteakHouseRestaurants, Supermarkets, SushiRestaurants, TakeAway, Taverns, ThaiRestaurants, TouristInformation, ToyAndGameStores, TurkishRestaurants, VegetarianAndVeganRestaurants, VietnameseRestaurants, VitaminAndSupplementStores, WomensClothingStores, Zoos

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: typeIdentifier
Parameter Sets: Rectangle, Circle, Point
Aliases:
Accepted values: AmusementParks, AntiqueStores, Attractions, BanksAndCreditUnions, Bars, BarsGrillsAndPubs, BelgianRestaurants, Bookstores, BreweriesAndBrewPubs, BritishRestaurants, BuffetRestaurants, CDAndRecordStores, CafeRestaurants, CaribbeanRestaurants, Carnivals, Casinos, ChildrensClothingStores, ChineseRestaurants, CigarAndTobaccoShops, CocktailLounges, CoffeeAndTea, ComicBookStores, Delicatessens, DeliveryService, DepartmentStores, Diners, DiscountStores, Donuts, FastFood, FleaMarketsAndBazaars, FrenchRestaurants, FrozenYogurt, FurnitureStores, GermanRestaurants, GreekRestaurants, Grocers, Grocery, HawaiianRestaurants, HomeImprovementStores, Hospitals, HotelsAndMotels, HungarianRestaurants, IceCreamAndFrozenDesserts, IndianRestaurants, ItalianRestaurants, JapaneseRestaurants, JewelryAndWatchesStores, Juices, KitchenwareStores, KoreanRestaurants, LandmarksAndHistoricalSites, LiquorStores, MallsAndShoppingCenters, MensClothingStores, MexicanRestaurants, MiddleEasternRestaurants, MiniatureGolfCourses, MovieTheaters, Museums, MusicStores, OutletStores, Parking, Parks, PetShops, PetSupplyStores, Pizza, PolishRestaurants, PortugueseRestaurants, Pretzels, Restaurants, RussianAndUkrainianRestaurants, Sandwiches, SchoolAndOfficeSupplyStores, SeafoodRestaurants, ShoeStores, SightseeingTours, SpanishRestaurants, SportingGoodsStores, SportsBars, SteakHouseRestaurants, Supermarkets, SushiRestaurants, TakeAway, Taverns, ThaiRestaurants, TouristInformation, ToyAndGameStores, TurkishRestaurants, VegetarianAndVeganRestaurants, VietnameseRestaurants, VitaminAndSupplementStores, WomensClothingStores, Zoos

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

### Bing.Place
## NOTES
Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

Direct API Example:
    https://dev.virtualearth.net/REST/v1/LocalSearch/?type={type_string_id_list}&userLocation={point}&key={BingMapsAPIKey}

Ensure you have a valid Bing Maps API Key.
    How to get a Bing Maps API Key:
        https://pwshplaces.readthedocs.io/en/latest/BingMapsAPI/#how-to-get-a-bing-maps-api-key

## RELATED LINKS

[https://pwshplaces.readthedocs.io/en/latest/Search-BingNearbyPlace](https://pwshplaces.readthedocs.io/en/latest/Search-BingNearbyPlace)

[https://pwshplaces.readthedocs.io/en/latest/pwshPlaces-Bing-Maps-Examples/](https://pwshplaces.readthedocs.io/en/latest/pwshPlaces-Bing-Maps-Examples/)

[https://docs.microsoft.com/bingmaps/rest-services/locations/local-search](https://docs.microsoft.com/bingmaps/rest-services/locations/local-search)

[https://docs.microsoft.com/bingmaps/rest-services/common-parameters-and-types/user-context-parameters](https://docs.microsoft.com/bingmaps/rest-services/common-parameters-and-types/user-context-parameters)

[https://docs.microsoft.com/bingmaps/rest-services/common-parameters-and-types/supported-culture-codes](https://docs.microsoft.com/bingmaps/rest-services/common-parameters-and-types/supported-culture-codes)

[https://www.microsoft.com/maps/product/terms.html](https://www.microsoft.com/maps/product/terms.html)

[https://privacy.microsoft.com/en-us/privacystatement](https://privacy.microsoft.com/en-us/privacystatement)

