# Bing Maps API

***[pwshPlaces](https://github.com/techthoughts2/pwshPlaces)** includes Bing Maps features and content; use of Bing Maps features and content is subject to the [terms of service](https://www.microsoft.com/maps/product/terms.html) and [Microsoft privacy policy](https://privacy.microsoft.com/en-us/privacystatement).*

- [Bing Maps API](#bing-maps-api)
  - [Bing Maps API Key](#bing-maps-api-key)
    - [How to get a Bing Maps API Key](#how-to-get-a-bing-maps-api-key)
      - [1. Create a new Bing maps dev account](#1-create-a-new-bing-maps-dev-account)
      - [2. Create a Bing Maps Basic API Key](#2-create-a-bing-maps-basic-api-key)
    - [Monitoring Bing Maps API usage](#monitoring-bing-maps-api-usage)
    - [Understanding Bing Maps API pricing](#understanding-bing-maps-api-pricing)
  - [API Caching](#api-caching)

## Bing Maps API Key

**[pwshPlaces](https://github.com/techthoughts2/pwshPlaces)** requires a Bing Maps API key to run Bing Maps functions.

To utilize all of the functions of pwshPlaces you must:

- Create a Bing Maps API key

You can read more about the Bing Maps API in the links below:

- [Getting Started with Bing Maps](https://docs.microsoft.com/bingmaps/getting-started/)

### How to get a Bing Maps API Key

Official documentation link for creating a Bing Maps API Key:

- [Create a Bing Maps Key](https://www.microsoft.com/en-us/maps/create-a-bing-maps-key)

> First, you will need a Bing Maps account and an API key. When you register for an account, you'll create a Bing Maps key

Here is what you need to accomplish at a high level:

#### 1. Create a new Bing maps dev account

Log into the [Bing Maps Dev Center Portal](https://www.bingmapsportal.com) - if you do not yet have an account go ahead and create one:
![Bing Maps Dev Center New Account](../media/bing_map_create_bing_maps_dev_account.PNG 'New Bing Maps Account')

#### 2. Create a Bing Maps Basic API Key

- Under My account tab click *My Keys*
  - Create a new API key

![Bing Maps API Key Choices](../media/create_bing_maps_api_key.PNG 'Bing Map API Key Choice')
![Bing Maps Dev Center New API Key](../media/bing_map_create_api_key.PNG 'New Bing Maps API Key')

### Monitoring Bing Maps API usage

Visit the [Bing Maps Dev Center Portal Summary Report](https://www.bingmapsportal.com/Report).

### Understanding Bing Maps API pricing

- [Bing Maps Licensing](https://www.microsoft.com/maps/licensing/licensing.aspx)
- [Bing Maps Licensing Options](https://www.microsoft.com/en-us/maps/licensing/licensing-options)

## API Caching

There doesn't seem to be anything in the [terms of service](https://www.microsoft.com/maps/product/terms.html) the explicitly forbids local caching of Bing Maps data.

This means that doing something like this should be fine:

```powershell
#--------------------------------------------------------------
# scrape and locally cache local restaurants
Import-Module Convert
Import-Module pwshPlaces

$scrapePath = $env:Temp

$locale = Invoke-BingGeoCode -Query 'New Braunfels, TX' -BingMapsAPIKey $env:BingAPIKey

$searchBingNearbyPlaceSplat = @{
    Type           = 'Restaurants'
    PointLatitude  = $locale.Latitude
    PointLongitude = $locale.Longitude
    MaxResults     = 20
    BingMapsAPIKey = $env:BingAPIKey
}
$areaRestaurants = Search-BingNearbyPlace @searchBingNearbyPlaceSplat

ConvertTo-Clixml -InputObject $areaRestaurants -Depth 100 | Out-File "$scrapePath\localRestaurants.xml"
#--------------------------------------------------------------
# where should we eat today?
$myLocalRestaurants = Get-Content -Path "$scrapePath\localRestaurants.xml" -Raw | ConvertFrom-Clixml

Get-Random $myLocalRestaurants
```
