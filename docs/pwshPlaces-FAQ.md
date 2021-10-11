# pwshPlaces - FAQ

- [pwshPlaces - FAQ](#pwshplaces---faq)
  - [FAQs](#faqs)
    - [Do I need an API key us to use pwshPlaces](#do-i-need-an-api-key-us-to-use-pwshplaces)
    - [Do I need a Google Maps API key and a Bing Maps API key](#do-i-need-a-google-maps-api-key-and-a-bing-maps-api-key)
    - [How do I get a Maps API key](#how-do-i-get-a-maps-api-key)
    - [Does the Google Maps API key cost money](#does-the-google-maps-api-key-cost-money)
    - [Does the Bing Maps API key cost money](#does-the-bing-maps-api-key-cost-money)
    - [How do load my API keys into pwshPlaces](#how-do-load-my-api-keys-into-pwshplaces)

## FAQs

### Do I need an API key us to use pwshPlaces

Yes. pwshPlaces requires API keys in order to make calls to the various Map services.

### Do I need a Google Maps API key and a Bing Maps API key

No. If you prefer one Map provider over another you can just get that API key. For example, if you prefer Google Maps you can just get a Google Maps API key and load that into the ```$env:GoogleAPIKey``` variable. This enables only the ```GMap``` functions in pwshPlaces. You will be unable to use the ```Bing``` functions. To unlock all functions inside pwshPlaces you will require both API keys.

### How do I get a Maps API key

- [How to get a Google Maps API Key](docs/GoogleMapsAPI.md#how-to-get-a-google-maps-api-key)
- [How to get a Bing Maps API Key](docs/BingMapsAPI.md#how-to-get-a-bing-maps-api-key)

### Does the Google Maps API key cost money

The Google Maps API has $200 free monthly usage for all users. This should be more than sufficient for most people.

You can dive into more details by [Understanding Google Maps API pricing](docs/GoogleMapsAPI.md#understanding-google-maps-api-pricing)

### Does the Bing Maps API key cost money

The Basic API key gives you up to 125,000 billable transactions per calendar year and less than 50,000 cumulative billable transactions with any 24-hour period. This should be more than sufficient for most people.

You can dive into more details by [Understanding Bing Maps API pricing](docs/BingMapsAPI.md#understanding-bing-maps-api-pricing)

### How do load my API keys into pwshPlaces

```powershell
# Set your API Keys in the pwshPlaces.psm1 file
# using the approriate variable names:

$env:GoogleAPIKey = 'yourGoogleAPIKey'
$env:BingAPIKey = 'yourBingAPIKey'
```

If you don't want to adjust the ```.psm1``` then simply ensure that these environment variables are populated in your current session.
