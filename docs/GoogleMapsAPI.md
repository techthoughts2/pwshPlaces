# Google Maps API

***[pwshPlaces](https://github.com/techthoughts2/pwshPlaces)** includes Google Maps features and content; use of Google Maps features and content is subject to the [terms of service](https://cloud.google.com/maps-platform/terms/) and [Google privacy policy](https://www.google.com/policies/privacy/).*

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
![Google Cloud (GCP) new project](assets/gcp_new_project.PNG 'New GCP Project')

#### 2. Enable the Places API and the Geocoding API

- Top left Navigation Menu
    - Products & solutions
        - All products
            - Other Google products
                - Google Maps Platform
                    - Maps APIs and Services
                        - Places API - --Enable--
- Google Maps Platform
    - APIs & Services
        - Additional APIs
            - Places API - --Enable--
            - Geocoding API - --Enable--

![Google Cloud (GCP) Top Left Navigation Menu](assets/google_cloud_top_left_navigation_menu.PNG 'GCP Navigation Menu')

![Google Cloud (GCP) Google Maps Platform](assets/gcp_google_maps_platform.PNG 'GCP Google Maps Platform')
![Google Cloud (GCP) Google Maps Platform Maps APIs and Services](assets/google_maps_platform_maps_api_and_services.PNG 'Google Maps Platform Maps APIs and Services')
![Google Maps Places API](assets/gcp_enable_places_api.PNG 'Google Maps Places API')
![Google Maps Geocoding API](assets/gcp_enable_geocoding_api.PNG 'Google Maps Geocoding API')

#### 3. Create API Key

- Google Maps Platform
    - Keys & Credentials
        - Create Credentials
            - API key

![GCP Google Maps Platform Credentials](assets/gcp_google_maps_create_credential_api.PNG 'Google Maps Platform Credentials')

#### 4. Restrict to places API

Restrict API access to just the two enabled

- Google Maps Platform
    - Keys & Credentials
        - Click on your created API key
            - Restrict API to just the two APIs to better secure it

![GCP API Restrict Access](assets/gcp_api_services_restrict_api_key.PNG 'API Restrict Access')

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
