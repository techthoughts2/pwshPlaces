# Google Maps API

***[pwshPlaces](https://github.com/techthoughts2/pwshPlaces)** includes Google Maps features and content; use of Google Maps features and content is subject to the [terms of service](https://cloud.google.com/maps-platform/terms/) and [Google privacy policy](https://www.google.com/policies/privacy/).*

- [Google Maps API](#google-maps-api)
  - [Google Maps API Key](#google-maps-api-key)
    - [How to get a Google Maps API Key](#how-to-get-a-google-maps-api-key)
      - [1. Create a new GCP project](#1-create-a-new-gcp-project)
      - [2. Enable the Places API and the Geocoding API](#2-enable-the-places-api-and-the-geocoding-api)
      - [3. Create API Key](#3-create-api-key)
      - [4. Restrict to places API](#4-restrict-to-places-api)
      - [5. Enable Billing on the Google Cloud project](#5-enable-billing-on-the-google-cloud-project)
    - [Monitoring Google Maps API usage](#monitoring-google-maps-api-usage)
    - [Understanding Google Maps API pricing](#understanding-google-maps-api-pricing)
  - [API Caching](#api-caching)

## Google Maps API Key

**[pwshPlaces](https://github.com/techthoughts2/pwshPlaces)** requires a Google API key to run Google maps functions.

To utilize all of the functions of pwshPlaces you must:

- Create a Google Maps API with both the Places and Geocoding APIs enabled and enable billing on the project.

You can read more about the Google Maps API in the links below:

- [Google Maps Platform Documentation](https://developers.google.com/maps/documentation#places)
- [Places API](https://developers.google.com/maps/documentation/places/web-service/overview)
- [Places API Support](https://developers.google.com/maps/documentation/places/web-service/support)

### How to get a Google Maps API Key

Official documentation link for creating a Google Maps API Key:

- [Google Maps Creating API Keys](https://developers.google.com/maps/documentation/places/web-service/get-api-key#creating-api-keys)

Google Maps API Keys are created and managed through Google Cloud Platform (GCP). The GCP console is constantly changing so some of the steps below may look slightly different. Here is what you need to accomplish at a high level:

#### 1. Create a new GCP project

Log into your [GCP console](https://console.cloud.google.com/home/) and create a new project:
![Google Cloud (GCP) new project](../media/gcp_new_project.PNG 'New GCP Project')

#### 2. Enable the Places API and the Geocoding API

- Top left Navigation Menu
  - Other Google Solutions
    - Google Maps Platform
      - Maps APIs and Services
        - Places API - --Enable--
- Google Maps Platform
  - APIs
    - Additional APIs
      - Geocoding API - --Enable--

![Google Cloud (GCP) Top Left Navigation Menu](../media/google_cloud_top_left_navigation_menu.PNG 'GCP Navigation Menu')
![Google Cloud (GCP) Google Maps Platform](../media/gcp_google_maps_platform.PNG 'GCP Google Maps Platform')
![Google Cloud (GCP) Google Maps Platform Maps APIs and Services](../media/google_maps_platform_maps_api_and_services.PNG 'Google Maps Platform Maps APIs and Services')
![Google Maps Places API](../media/gcp_enable_places_api.PNG 'Google Maps Places API')
![Google Maps Geocoding API](../media/gcp_enable_geocoding_api.PNG 'Google Maps Geocoding API')

#### 3. Create API Key

- Google Maps Platform
  - Credentials
    - Create Credentials
      - API key

![GCP Google Maps Platform Credentials](../media/gcp_google_maps_create_credential_api.PNG 'Google Maps Platform Credentials')

#### 4. Restrict to places API

Restrict API access to just the two enabled

- Google Maps Platform
  - Credentials
    - Restrict API to secure account

![GCP API Restrict Access](../media/gcp_api_services_restrict_api_key.PNG 'API Restrict Access')

#### 5. Enable Billing on the Google Cloud project

You must [enable billing](https://console.cloud.google.com/project/_/billing/enable) on the Google Cloud Project.

-Note: Even though you need to enable billing keep in mind the following:-

> For most of our users, the $200 monthly credit is enough to support their needs. You can also set daily quotas to protect against unexpected increases.

### Monitoring Google Maps API usage

Visit the [GCP API dashboard](https://console.developers.google.com/apis/dashboard). From the ‘Select a Project’ drop-down menu, select or create the project.

Additional reading:

- [Monitoring API usage](https://cloud.google.com/apis/docs/monitoring)
- [Monitor Google API usage programmatically?](https://stackoverflow.com/questions/62511759/monitor-google-api-usage-programmatically)

### Understanding Google Maps API pricing

- [Google Maps Platform pricing](https://cloud.google.com/maps-platform/pricing)
- [Places product API pricing](https://developers.google.com/maps/billing/gmp-billing#places-product)
- [Places API Usage and Billing](https://developers.google.com/maps/documentation/places/web-service/usage-and-billing)
  - [Places SKU breakdown cost data](https://developers.google.com/maps/billing/gmp-billing#basic-data)

## API Caching

IAW with the [terms of service](https://cloud.google.com/maps-platform/terms/):

> Pre-Fetching, Caching, or Storage of Content
Applications using the Places API are bound by the Google Maps Platform Terms of Service. Section 3.2.3(a) and (b) of the terms states that you must not pre-fetch, index, store, or cache any Content except under the limited conditions stated in the terms.
Note that the place ID, used to uniquely identify a place, is exempt from the caching restriction. You can therefore store place ID values indefinitely. The place ID is returned in the place_id field in Places API responses.

This means that doing something like the following is not permitted:

```powershell
#--------------------------------------------------------------
# scrape and locally cache up to 60 local restaurants
Import-Module Convert
Import-Module pwshPlaces

$scrapePath = $env:Temp

$locale = Invoke-GMapGeoCode -Address 'New Braunfels'

$areaRestaurants = Search-GMapNearbyPlace -Latitude $locale.Latitude -Longitude $locale.Longitude -Radius 10000 -RankByProminence -Type restaurant -AllSearchResults

ConvertTo-Clixml -InputObject $areaRestaurants -Depth 100 | Out-File "$scrapePath\localRestaurants.xml"
#--------------------------------------------------------------
# where should we eat today?
$myLocalRestaurants = Get-Content -Path "$scrapePath\localRestaurants.xml" -Raw | ConvertFrom-Clixml

Get-Random $myLocalRestaurants
```
