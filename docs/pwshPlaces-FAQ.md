# pwshPlaces - FAQ

## FAQs

### API Keys

#### Do I need an API key us to use pwshPlaces

Yes. pwshPlaces requires an API key in order to make calls to the various map services.

#### Do I need both a Google Maps API key and a Bing Maps API key

No. If you prefer one Map provider over another you can just get that API key. For example, if you prefer Google Maps you can just get a Google Maps API key and load that into the `$GoogleAPIKey` variable. This enables only the `GMap` functions in pwshPlaces. You will be unable to use the `Bing` functions. To unlock all functions inside pwshPlaces you will require both API keys.

#### How do I get a Maps API key

- [How to get a Google Maps API Key](GoogleMapsAPI.md)
- [How to get a Bing Maps API Key](BingMapsAPI.md)

#### Does the Google Maps API key cost money

The Google Maps API has $200 free monthly usage for all users. This should be more than sufficient for most people.

You can dive into more details by [Understanding Google Maps API pricing](GoogleMapsAPI.md#understanding-google-maps-api-pricing)

#### Does the Bing Maps API key cost money

The Basic API key gives you up to 125,000 billable transactions per calendar year and less than 50,000 cumulative billable transactions with any 24-hour period. This should be more than sufficient for most people.

You can dive into more details by [Understanding Bing Maps API pricing](BingMapsAPI.md#understanding-bing-maps-api-pricing)
