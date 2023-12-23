# pwshPlaces - Google Maps Basics

## Getting Started with Google Maps

To use pwshPlaces, you first need to install it from the PowerShell Gallery using the following command:

```powershell
Install-Module -Name 'pwshPlaces' -Repository PSGallery -Scope CurrentUser
```

Second, you'll need a Google Maps API Key. This key is *easy to create* and has a *no cost* pricing tier.

Here is a detailed guide on how to get your API key: [How to get a Google Maps API Key](GoogleMapsAPI.md)

## Places

When using pwshPlaces with Google Maps, you have four primary functions at your disposal, each serving a specific purpose in your search for place information. Understanding when to use each function will help you effectively navigate and utilize the module.

### Initial Searches - Finding Places

1. `Find-GMapPlace`:

    - **Use When**: You need basic information about a place, such as its name, location, and Place ID. Ideal for pinpoint searches.
    - **Typical Scenario**: Looking for a specific place by name or address.

2. `Search-GMapNearbyPlace`:

    - **Use When**: You want to find places within a specific radius of a given location. Perfect for exploring nearby points of interest.
    - **Typical Scenario**: Finding all types of a certain place (like cafes or museums) around your current location.

3. `Search-GMapText`:

    - **Use When**: Your search is more exploratory, based on text queries that might include place names, addresses, or general descriptions.
    - **Typical Scenario**: Searching for “best Italian restaurants in downtown Boston” or “public libraries in San Francisco.”

### Getting In-Depth Place Information

4. `Get-GMapPlaceDetail`:

    - **Use When**: You have a Place ID (obtained from any of the initial search functions) and need detailed information about that place.
    - **Typical Scenario**: You’ve found a place of interest with `Find-GMapPlace`, `Search-GMapNearbyPlace`, or `Search-GMapText` and now want detailed information like contact details, reviews, and ratings.

### Best Practice Workflow

1. Start with an Initial Search: Depending on your need, use `Find-GMapPlace` for specific queries, `Search-GMapNearbyPlace` for nearby searches, or `Search-GMapText` for more general, text-based queries.
2. Dive Deeper with Detailed Information: Once you have a Place ID from your initial search, use `Get-GMapPlaceDetail` to get comprehensive details about that place.

### Finding a Place

Example: `Find-GMapPlace`

Description: This command searches for "Krause's cafe", returning place information including location, contact details, and more, biased by the user's IP location.

```powershell
Find-GMapPlace -Query 'Moriyama Sushi' -GoogleAPIKey $googleAPIKey

place_id           : ChIJBc1IJTAVkFQRL8t6ZyWVxig
name               : Moriyama Sushi
Address            : 1823 Eastlake Ave E #153, Seattle, WA 98102, United States
Open               :
rating             :
user_ratings_total :
price_level        :
Latitude           : 47.6357452
Longitude          : -122.3257623
types              : {restaurant, food, point_of_interest, establishment}
```

### Search a Nearby Place

Example: `Search-GMapNearbyPlace`

Description: Used to perform a location-based search for businesses related to the keyword 'butcher' within a 10,000-meter radius of the specified coordinates (latitude 29.7049806, longitude -98.068343). The search is tailored to find stores (`-Type store`) and is ranked by prominence (`-RankByProminence`), which prioritizes well-known or highly rated locations.

```powershell
Search-GMapNearbyPlace -Latitude '29.7049806' -Longitude '-98.068343' -Radius 10000 -RankByProminence -Keyword 'butcher' -Type store -GoogleAPIKey $googleAPIKey


place_id           : ChIJE43gTHK9XIYRleSxiXqF6GU
name               : Granzin's Meat Market
Address            : 1644 McQueeney Rd, New Braunfels
Latitude           : 29.6877338
Longitude          : -98.1154552
types              : {grocery_or_supermarket, liquor_store, store, point_of_interest…}
rating             : 4.8
user_ratings_total : 1026
price_level        :
Open               : True
```

### General Place Search

Example: `Search-GMapText`

Description: Conduct a targeted search for high-end Italian restaurants in New York. By specifying the query "italian restaurants in New York" and setting the MinPrice parameter to 4 (indicating expensive establishments), the function efficiently narrows down the search to upscale Italian dining options in the city.

```powershell
Search-GMapText -Query "italian restaurants in New York" -MinPrice 4 -GoogleAPIKey $googleAPIKey

place_id           : ChIJlbtXLfpYwokR7uNWBCLt7hI
name               : Il Gattopardo
Address            : 13-15 W 54th St, New York, NY 10019, United States
Latitude           : 40.761674
Longitude          : -73.9763707
types              : {restaurant, food, point_of_interest, establishment}
rating             : 4.5
user_ratings_total : 651
price_level        : 4
Open               : True
```

### Getting Place Details

Example: `Get-GMapPlaceDetail`

Description: Retrieves detailed information about a place, such as its complete address, phone number, user ratings, and reviews, using its Place ID.

*Note: Not using the `Contact` and `Atmosphere` switches doesn't get you much more than a normal `Find-GMapPlace` query.*

```powershell
Get-GMapPlaceDetail -PlaceID 'ChIJBc1IJTAVkFQRL8t6ZyWVxig' -Contact -Atmosphere -GoogleAPIKey $googleAPIKey

place_id           : ChIJBc1IJTAVkFQRL8t6ZyWVxig
name               : Moriyama Sushi
website            : http://moriyamasushi.com/
Address            : 1823 Eastlake Ave E #153, Seattle, WA 98102, USA
Phone              : (206) 259-9569
Open               : True
OpenHours          : {Monday: Closed, Tuesday: 11:30 AM – 2:00 PM, 5:00 – 9:30 PM, Wednesday:
                     11:30 AM – 2:00 PM, 5:00 – 9:30 PM, Thursday: 11:30 AM – 2:00 PM, 5:00 – 9:30 PM…}
GoogleMapsURL      : https://maps.google.com/?cid=2938199794788256559
rating             : 4.8
user_ratings_total : 104
price_level        : 2
Latitude           : 47.6357452
Longitude          : -122.3257623
types              : {restaurant, point_of_interest, food, establishment}
```

## Geocoding

### Geocoding an Address

Example: `Invoke-GMapGeoCode`

Description: Converts a physical address into geographic coordinates, enabling the mapping of address data.

```powershell
Invoke-GMapGeoCode -Address '148 S Castell Ave, New Braunfels, TX 78130, United States' -GoogleAPIKey $googleAPIKey

place_id          : ChIJK34phme9XIYRqstHW_gHr2w
formatted_address : 148 S Castell Ave, New Braunfels, TX 78130, USA
StreetNumber      : 148
Street            : South Castell Avenue
City              : New Braunfels
Country           : United States
PostalCode        : 78130
Latitude          : 29.7012853
Longitude         : -98.1250235
types             : {premise}
```

### Reverse Geocoding

Example: `Invoke-GMapGeoCode` for Reverse Geocoding

Description: This function turns latitude and longitude coordinates into a human-readable address, ideal for location-based analyses.

```powershell
Invoke-GMapGeoCode -Latitude '29.7012853' -Longitude '-98.1250235' -GoogleAPIKey $googleAPIKey

place_id          : ChIJK34phme9XIYRqstHW_gHr2w
formatted_address : 148 S Castell Ave, New Braunfels, TX 78130, USA
StreetNumber      : 148
Street            : South Castell Avenue
City              : New Braunfels
Country           : United States
PostalCode        : 78130
Latitude          : 29.7012853
Longitude         : -98.1250235
types             : {premise}
```
