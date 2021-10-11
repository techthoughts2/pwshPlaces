# pwshPlaces

[![Minimum Supported PowerShell Version](https://img.shields.io/badge/PowerShell-5.1+-purple.svg)](https://github.com/PowerShell/PowerShell) [![PowerShell Gallery][psgallery-img]][psgallery-site] ![Cross Platform](https://img.shields.io/badge/platform-windows%20%7C%20macos%20%7C%20linux-lightgrey) [![License][license-badge]](LICENSE)

[psgallery-img]:   https://img.shields.io/powershellgallery/dt/pwshPlaces?label=Powershell%20Gallery&logo=powershell
[psgallery-site]:  https://www.powershellgallery.com/packages/pwshPlaces
[psgallery-v1]:    https://www.powershellgallery.com/packages/pwshPlaces/0.8.1
[license-badge]:   https://img.shields.io/github/license/techthoughts2/pwshPlaces

Branch | Windows - PowerShell | Windows - pwsh | Linux | MacOS
--- | --- | --- | --- | --- |
main | [![Build Status Windows PowerShell main](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_Windows.yml/badge.svg?branch=main)](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_Windows.yml) | [![Build Status Windows pwsh main](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_Windows_Core.yml/badge.svg?branch=main)](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_Windows_Core.yml) | [![Build Status Linux main](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_Linux.yml/badge.svg?branch=main)](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_Linux.yml) | [![Build Status MacOS main](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_MacOS.yml/badge.svg?branch=main)](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_MacOS.yml)
dev | [![Build Status Windows PowerShell dev](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_Windows.yml/badge.svg?branch=dev)](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_Windows.yml) | [![Build Status Windows pwsh dev](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_Windows_Core.yml/badge.svg?branch=dev)](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_Windows_Core.yml) | [![Build Status Linux dev](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_Linux.yml/badge.svg?branch=dev)](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_Linux.yml) | [![Build Status MacOS dev](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_MacOS.yml/badge.svg?branch=dev)](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_MacOS.yml)

## Synopsis

pwshPlaces is a PowerShell module that can help you discover places and search for points of interest around the globe.

## Description

pwshPlaces enables you to leverage the Google Maps and/or Bing Maps API(s) to perform a variety of maps related tasks using PowerShell:

* Search for places, entities, addresses, and other points of interest
* Discover locations near your or near a specified place
* Easily perform Geocoding and reverse Geocoding actions
* Get detailed place information including opening hours, website information, and contact information

[pwshPlaces](docs/pwshPlaces.md) provides the following functions:

* [Find-BingPlace](docs/Find-BingPlace.md)
* [Find-BingTimeZone](docs/Find-BingTimeZone.md)
* [Find-GMapPlace](docs/Find-GMapPlace.md)
* [Get-GMapPlaceDetail](docs/Get-GMapPlaceDetail)
* [Invoke-BingGeoCode](docs/Invoke-BingGeoCode)
* [Invoke-GMapGeoCode](docs/Invoke-GMapGeoCode.md)
* [Search-BingNearbyPlace](docs/Search-BingNearbyPlace)
* [Search-GMapNearbyPlace](docs/Search-GMapNearbyPlace.md)
* [Search-GMapText](docs/Search-GMapText.md)

## Why

The Google Maps and Bing Maps API require very specific formatting and criteria for API map interaction. The goal of this project is to abstract that complexity away in favor of simple and direct PowerShell commands.

## Installation

### Prerequisites

To use pwshPlaces you will require a Google Maps or Bing Maps API key. To use all of the functions you will require both. The API key(s) will need to be loaded into environment variables in your current session.

> 🙄 Not another module that requires an API Key!

Both of these APIs are *easy to create* and have *no cost* pricing tiers which should meet your needs. I have provided detailed guides on how to get your API keys:

* [How to get a Google Maps API Key](docs/GoogleMapsAPI.md#how-to-get-a-google-maps-api-key)
* [How to get a Bing Maps API Key](docs/BingMapsAPI.md#how-to-get-a-bing-maps-api-key)

```powershell
# Set your API Keys in the pwshPlaces.psm1 file
# using the approriate variable names:

$env:GoogleAPIKey = 'yourGoogleAPIKey'
$env:BingAPIKey = 'yourBingAPIKey'
```

If you don't want to adjust the ```.psm1``` then simply ensure that these environment variables are populated in your current session.

### Install pwshPlaces

```powershell
# Install pwshPlaces from the PowerShell Gallery
Install-Module -Name pwshPlaces -Repository PSGallery -Scope CurrentUser
```

## Quick start

```powershell
######################################################################################
# Google Maps
$env:GoogleAPIKey = 'yourGoogleAPIKey'
######################################################################################
# I want to find a specific place
Find-GMapPlace -Query "Krause's cafe"
Find-GMapPlace -Query '+18306252807'
Find-GMapPlace -Query 'cafe' -PointLatitude '29.7049806' -PointLongitude '-98.068343'
#-------------------------------------------------------------------------------------
# I want to search for a type of place
Search-GMapText -Query "Cupcakes" -Type bakery -AllSearchResults
Search-GMapText -Query "italian restaurants in New York" -MinPrice 4
#-------------------------------------------------------------------------------------
# I want to search for nearby places
Search-GMapNearbyPlace -Latitude '29.7049806' -Longitude '-98.068343' -Radius 5000
Search-GMapNearbyPlace -Latitude '29.7049806' -Longitude '-98.068343' -Radius 10000 -RankByProminence -Keyword 'butcher' -Type store
#-------------------------------------------------------------------------------------
# I want to get very detailed information about a place - place ID retrieved from other commands
Get-GMapPlaceDetail -PlaceID 'ChIJf9Yxhme9XIYRkXo-Bl62Q10' -Contact -Atmosphere
#-------------------------------------------------------------------------------------
# I want to GeoCode an address
Invoke-GMapGeoCode -Address '148 S Castell Ave, New Braunfels, TX 78130, United States'
#-------------------------------------------------------------------------------------
# I want to reverse GeoCode a location
Invoke-GMapGeoCode -Latitude '29.7012853' -Longitude '-98.1250235'
######################################################################################
# Bing Maps
$env:BingAPIKey = 'yourBingAPIKey'
######################################################################################
# I want to find a specific place
Find-BingPlace -Query "Krause's cafe"
Find-BingPlace -Query 'cafe' -PointLatitude '29.7049806' -PointLongitude '-98.068343'
#-------------------------------------------------------------------------------------
# I want to search for nearby places
Search-BingNearbyPlace -Type Attractions
Search-BingNearbyPlace -Type CafeRestaurants -PointLatitude '29.7049806' -PointLongitude '-98.068343'
#-------------------------------------------------------------------------------------
# I want to GeoCode an address
Invoke-BingGeoCode -AddressLine '148 S Castell Ave' -City 'New Braunfels' -State TX -PostalCode 78130
#-------------------------------------------------------------------------------------
# I want to reverse GeoCode a location
Invoke-BingGeoCode -Latitude '29.7030' -Longitude '-98.1245'
#-------------------------------------------------------------------------------------
# I want to determine the Time Zone of a specific place
Find-BingTimeZone -Query 'New Braunfels, TX'
Find-BingTimeZone -PointLatitude 29.70 -PointLongitude -98.11
#-------------------------------------------------------------------------------------
```

## FAQ

**[pwshPlaces - FAQ](docs/pwshPlaces-FAQ.md)**

## Author

[Jake Morrison](https://twitter.com/JakeMorrison) - [https://www.techthoughts.info/](https://www.techthoughts.info/)

## Notes

This PowerShell project was created with [Catesta](https://github.com/techthoughts2/Catesta).

## Changelog

Reference the [Changelog](.github/CHANGELOG.md)
