# pwshPlaces - Bing Maps Basics

## Getting Started with Bing Maps

To use pwshPlaces, you first need to install it from the PowerShell Gallery using the following command:

```powershell
Install-Module -Name 'pwshPlaces' -Repository PSGallery -Scope CurrentUser
```

Second, you'll need a Bing Maps API Key. This key is *easy to create* and has a *no cost* pricing tier.

Here is a detailed guide on how to get your API key: [How to get a Bing Maps API Key](BingMapsAPI.md)

## Places

### Finding a Place - IP bias

Example: `Find-BingPlace`

Description: This command searches for "Krause's cafe", returning information about the place including its location, based on the user's IP location bias.

```powershell
Find-BingPlace -Query 'Moriyama Sushi' -BingMapsAPIKey $bingAPIKey

name             : Moriyama Sushi
FormattedAddress : 1823 Eastlake Ave E Ste 153, Seattle, Wa, 98102
PhoneNumber      : (206) 259-9569
Website          : https://moriyamasushi.com/
Latitude         : 47.63484955
Longitude        : -122.32572937
entityType       : Restaurant
```

### Discovering Nearby Places - IP bias

Example: `Search-BingNearbyPlace`

Description: Searches for restaurants near the user's IP location.

```powershell
Search-BingNearbyPlace -Type Restaurants -BingMapsAPIKey $bingAPIKey -MaxResults 2

name             : Gristmill River Restaurant & Bar
FormattedAddress : 1287 Gruene Rd, New Braunfels, TX, 78130
PhoneNumber      : (830) 625-0684
Website          : https://gristmillrestaurant.com/
Latitude         : 29.73823166
Longitude        : -98.10523987
entityType       : Restaurant

name             : Buttermilk Cafe
FormattedAddress : 1324 E Common St, New Braunfels, TX, 78130
PhoneNumber      : (830) 625-8700
Website          : https://thebuttermilkcafe.com/
Latitude         : 29.72138786
Longitude        : -98.10136414
entityType       : Restaurant
```

### Finding a Place - Exact location

Example: `Find-BingPlace`

Description: Two-step process to find detailed information about a specific place. Uses geocoding to convert a location name into geographic coordinates and then uses those coordinates to find a specific place. In this example searches for the restaurant 'Tavern on the Green' in New York City.

```powershell
$geo = Invoke-BingGeoCode -Query 'New York, NY' -MaxResults 1 -BingMapsAPIKey $bingAPIKey
Find-BingPlace -Query 'Tavern on the Green' -PointLatitude $geo.Latitude -PointLongitude $geo.Longitude -BingMapsAPIKey $bingAPIKey

name             : Tavern on the Green
FormattedAddress : 67th Street & Central Park West, New York, NY, 10023
PhoneNumber      : (212) 877-8684
Website          : https://www.tavernonthegreen.com/
Latitude         : 40.77265167
Longitude        : -73.97856903
entityType       : Restaurant
```

### Discovering Nearby Places - Exact location

Example: `Search-BingNearbyPlace`

Description: Two-step process to find detailed information about a specific place. Uses geocoding to convert a location name into geographic coordinates and then uses those coordinates to find a specific place. In this example searches for restaurants in New York City.

```powershell
$geo = Invoke-BingGeoCode -Query 'New York, NY' -MaxResults 1 -BingMapsAPIKey $bingAPIKey
Search-BingNearbyPlace -Type Restaurants -MaxResults 2 -PointLatitude $geo.Latitude -PointLongitude $geo.Longitude -BingMapsAPIKey $bingAPIKey

name             : Wolfgang's Steakhouse
FormattedAddress : 409 Greenwich St, New York, NY, 10013
PhoneNumber      : (212) 925-0350
Website          : https://wolfgangssteakhouse.net/
Latitude         : 40.72123337
Longitude        : -74.00980377
entityType       : Restaurant

name             : La Mela Ristorante
FormattedAddress : 167 Mulberry St, New York, NY, 10013
PhoneNumber      : (212) 431-9493
Website          : https://www.lamelarestaurant.com/
Latitude         : 40.7199173
Longitude        : -73.99729156
entityType       : Restaurant
```

## Geocoding

### Geocoding an Address

Example: `Invoke-BingGeoCode`

Description: This example demonstrates how to convert a physical address into geographic coordinates (latitude and longitude).

```powershell
Invoke-BingGeoCode -AddressLine '148 S Castell Ave' -City 'New Braunfels' -State TX -PostalCode 78130 -BingMapsAPIKey $bingAPIKey

name             : 148 S Castell Ave, New Braunfels, TX 78130
FormattedAddress : 148 S Castell Ave, New Braunfels, TX 78130
Street           : 148 S Castell Ave
City             : New Braunfels
Country          : United States
PostalCode       : 78130
Latitude         : 29.701293
Longitude        : -98.12502
entityType       : Address
```

### Reverse Geocoding

Example: `Invoke-BingGeoCode` for Reverse Geocoding

Description: Converts latitude and longitude coordinates into a readable address, useful for understanding the location context of geographic data.

```powershell
Invoke-BingGeoCode -Latitude '29.7030' -Longitude '-98.1245' -BingMapsAPIKey $bingAPIKey

name             : 555 Main Plaza, New Braunfels, TX 78130, United States
FormattedAddress : 555 Main Plaza, New Braunfels, TX 78130, United States
Street           : 555 Main Plaza
City             : New Braunfels
Country          : United States
PostalCode       : 78130
Latitude         : 29.7028653
Longitude        : -98.1242605
entityType       : Address
```

## Determining Time Zones

Example: `Find-BingTimeZone`

Description: Retrieves time zone information for 'New Braunfels, TX', including local time zone and daylight saving details.

```powershell
Find-BingTimeZone -Query 'New Braunfels, TX' -IncludeDSTRules -BingMapsAPIKey $bingAPIKey

TimeZoneName         : Central Standard Time
TimeZoneShort        : CST
UTCOffSet            : -6:00
TimeZoneID           : America/Chicago
LocalTime            : 12/20/2023 1:03:54 PM
TimeZoneCurrentName  : Central Standard Time
TimeZoneCurrentShort : CST
UTCOffSetDST         : -6:00
dstRule              : @{dstStartMonth=Mar; dstStartDateRule=Sun>=8; dstStartTime=2:00; dstAdjust1=1:00;
                       dstEndMonth=Nov; dstEndDateRule=Sun>=1; dstEndTime=2:00; dstAdjust2=0}
```
