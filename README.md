# pwshPlaces

[![Minimum Supported PowerShell Version](https://img.shields.io/badge/PowerShell-5.1+-purple.svg)](https://github.com/PowerShell/PowerShell) [![PowerShell Gallery][psgallery-img]][psgallery-site] ![Cross Platform](https://img.shields.io/badge/platform-windows%20%7C%20macos%20%7C%20linux-lightgrey) [![License][license-badge]](LICENSE) [![Documentation Status](https://readthedocs.org/projects/pwshplaces/badge/?version=latest)](https://pwshplaces.readthedocs.io/en/latest/?badge=latest)

[psgallery-img]:   https://img.shields.io/powershellgallery/dt/pwshPlaces?label=Powershell%20Gallery&logo=powershell
[psgallery-site]:  https://www.powershellgallery.com/packages/pwshPlaces
[psgallery-v1]:    https://www.powershellgallery.com/packages/pwshPlaces/0.8.1
[license-badge]:   https://img.shields.io/github/license/techthoughts2/pwshPlaces

Branch | Windows - PowerShell | Windows - pwsh | Linux | MacOS
--- | --- | --- | --- | --- |
main | [![Build Status Windows PowerShell main](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_Windows.yml/badge.svg?branch=main)](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_Windows.yml) | [![Build Status Windows pwsh main](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_Windows_Core.yml/badge.svg?branch=main)](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_Windows_Core.yml) | [![Build Status Linux main](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_Linux.yml/badge.svg?branch=main)](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_Linux.yml) | [![Build Status MacOS main](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_MacOS.yml/badge.svg?branch=main)](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_MacOS.yml)
Enhancements | [![Build Status Windows PowerShell Enhancements](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_Windows.yml/badge.svg?branch=Enhancements)](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_Windows.yml) | [![Build Status Windows pwsh Enhancements](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_Windows_Core.yml/badge.svg?branch=Enhancements)](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_Windows_Core.yml) | [![Build Status Linux Enhancements](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_Linux.yml/badge.svg?branch=Enhancements)](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_Linux.yml) | [![Build Status MacOS Enhancements](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_MacOS.yml/badge.svg?branch=Enhancements)](https://github.com/techthoughts2/pwshPlaces/actions/workflows/wf_MacOS.yml)

## Synopsis

pwshPlaces is a PowerShell module that integrates with leading mapping services like Google Maps and Bing Maps. Offering a suite of commands for interacting with maps, it enables you to perform searches, read reviews, and retrieve detailed information about locations worldwide. From discovering nearby restaurants to geocoding addresses, pwshPlaces equips you with a wealth of geographical data, accessible through simple and intuitive PowerShell commands.

## Description

pwshPlaces enables you to leverage the Google Maps and/or Bing Maps APIs to perform a variety of map-related tasks using PowerShell. This module simplifies accessing and analyzing geographical data with user-friendly commands, empowering users to search for locations, read reviews, and perform geocoding effortlessly. Ideal for discovery, travel planning, or enhancing automation scripts, pwshPlaces transforms complex mapping data into actionable insights using PowerShell.

### Features

- Support for both Bing Maps and Google Maps
- *Find Places with Ease*: Use commands to locate any place, from restaurants to landmarks, using simple queries.
- *Open-Text Search Capabilities*: Harness the power of flexible, text-based searches. Whether it’s "coffee shops in Amsterdam" or "art galleries in New York", get targeted results swiftly.
- *Discover Nearby Points of Interest*: Explore what's around you, be it parks, eateries, or museums, based on your current or specified location.
- *Efficient Geocoding and Reverse Geocoding*: Convert addresses to coordinates and vice versa, integrating geographical context into your data.
- *In-depth Place Details*: Dive deeper into specific locations to access comprehensive information like contact details, ratings, reviews, and more.
- *Time Zone Information*: Stay informed about the time zones of different places, making scheduling and planning across time zones simpler.
- *Rapid Comparison and Decision Making*: Compare ratings, prices, and other key information quickly and make informed decisions without wading through dense web pages.
- *Customizable Search Parameters*: Tailor your searches with various parameters like radius, price level, and types to get precisely what you're looking for.

## Getting Started

### Documentation

Documentation for pwshPlaces is available at: [https://pwshPlaces.readthedocs.io](https://pwshPlaces.readthedocs.io)

### Prerequisites

To use pwshPlaces you will require a Google Maps or Bing Maps API key. To use all of the functions you will require both.

> 🙄 Not another module that requires an API Key!

Both of these Map API keys are *easy to create* and have *no cost* pricing tiers which should meet your needs. I have provided detailed guides on how to get your API keys:

- [How to get a Google Maps API Key](docs/GoogleMapsAPI.md#how-to-get-a-google-maps-api-key)
- [How to get a Bing Maps API Key](docs/BingMapsAPI.md#how-to-get-a-bing-maps-api-key)

### Installation

```powershell
Install-Module -Name 'pwshPlaces' -Repository PSGallery -Scope CurrentUser
```

## Quick start

```powershell
######################################################################################
# Google Maps
$googleAPIKey = 'yourGoogleAPIKey'
######################################################################################
# I want to find a specific place
Find-GMapPlace -Query "Krause's cafe" -GoogleAPIKey $googleAPIKey
Find-GMapPlace -Query '+18306252807' -GoogleAPIKey $googleAPIKey
Find-GMapPlace -Query 'cafe' -PointLatitude '29.7049806' -PointLongitude '-98.068343' -GoogleAPIKey $googleAPIKey
#-------------------------------------------------------------------------------------
# I want to search for a type of place
Search-GMapText -Query "Cupcakes" -Type bakery -AllSearchResults -GoogleAPIKey $googleAPIKey
Search-GMapText -Query "italian restaurants in New York" -MinPrice 4 -GoogleAPIKey $googleAPIKey
#-------------------------------------------------------------------------------------
# I want to search for nearby places
Search-GMapNearbyPlace -Latitude '29.7049806' -Longitude '-98.068343' -Radius 5000 -GoogleAPIKey $googleAPIKey
Search-GMapNearbyPlace -Latitude '29.7049806' -Longitude '-98.068343' -Radius 10000 -RankByProminence -Keyword 'butcher' -Type store -GoogleAPIKey $googleAPIKey
#-------------------------------------------------------------------------------------
# I want to get very detailed information about a place - place ID retrieved from other commands
Get-GMapPlaceDetail -PlaceID 'ChIJf9Yxhme9XIYRkXo-Bl62Q10' -Contact -Atmosphere -GoogleAPIKey $googleAPIKey
#-------------------------------------------------------------------------------------
# I want to GeoCode an address
Invoke-GMapGeoCode -Address '148 S Castell Ave, New Braunfels, TX 78130, United States' -GoogleAPIKey $googleAPIKey
#-------------------------------------------------------------------------------------
# I want to reverse GeoCode a location
Invoke-GMapGeoCode -Latitude '29.7012853' -Longitude '-98.1250235' -GoogleAPIKey $googleAPIKey
######################################################################################
# Bing Maps
$bingAPIKey = 'yourBingAPIKey'
######################################################################################
# I want to find a specific place
Find-BingPlace -Query "Krause's cafe" -BingMapsAPIKey $bingAPIKey
Find-BingPlace -Query 'cafe' -PointLatitude '29.7049806' -PointLongitude '-98.068343' -BingMapsAPIKey $bingAPIKey
#-------------------------------------------------------------------------------------
# I want to search for nearby places
Search-BingNearbyPlace -Type Attractions -BingMapsAPIKey $bingAPIKey
Search-BingNearbyPlace -Type CafeRestaurants -PointLatitude '29.7049806' -PointLongitude '-98.068343' -BingMapsAPIKey $bingAPIKey
#-------------------------------------------------------------------------------------
# I want to GeoCode an address
Invoke-BingGeoCode -AddressLine '148 S Castell Ave' -City 'New Braunfels' -State TX -PostalCode 78130 -BingMapsAPIKey $bingAPIKey
#-------------------------------------------------------------------------------------
# I want to reverse GeoCode a location
Invoke-BingGeoCode -Latitude '29.7030' -Longitude '-98.1245' -BingMapsAPIKey $bingAPIKey
#-------------------------------------------------------------------------------------
# I want to determine the Time Zone of a specific place
Find-BingTimeZone -Query 'New Braunfels, TX' -BingMapsAPIKey $bingAPIKey
Find-BingTimeZone -PointLatitude 29.70 -PointLongitude -98.11 -BingMapsAPIKey $bingAPIKey
#-------------------------------------------------------------------------------------
```

## Notes

This PowerShell project was created with [Catesta](https://github.com/techthoughts2/Catesta).

## Contributing

If you'd like to contribute to pwshPlaces, please see the [contribution guidelines](.github/CONTRIBUTING.md).

## License

This project is [licensed under the MIT License](LICENSE).
