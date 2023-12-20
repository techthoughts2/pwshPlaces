# Google Maps Examples in pwshPlaces

This document provides practical, real-world examples for using the Google Maps functions in the pwshPlaces module. It's designed to showcase how these functions can be applied in various scenarios, helping you to integrate Google Maps features into your PowerShell projects effectively.

## Examples

### Finding a Place

Example: `Find-GMapPlace`

```powershell
Find-GMapPlace -Query "Krause's cafe" -GoogleAPIKey $googleAPIKey
```

Description: This command searches for "Krause's cafe", returning place information including location, contact details, and more, biased by the user's IP location.

### Getting Place Details

Example: `Get-GMapPlaceDetail`

```powershell
Get-GMapPlaceDetail -PlaceID 'ChIJE43gTHK9XIYRleSxiXqF6GU' -GoogleAPIKey $googleAPIKey
```

Description: Retrieves detailed information about a place, such as its complete address, phone number, user ratings, and reviews, using its Place ID.

### Geocoding

#### Geocoding an Address

Example: `Invoke-GMapGeoCode`

```powershell
Invoke-GMapGeoCode -Address '148 S Castell Ave, New Braunfels, TX 78130, United States' -GoogleAPIKey $googleAPIKey
```

Description: Converts a physical address into geographic coordinates, enabling the mapping of address data.

#### Reverse Geocoding

Example: `Invoke-GMapGeoCode` for Reverse Geocoding

```powershell
Invoke-GMapGeoCode -Latitude '29.7012853' -Longitude '-98.1250235' -GoogleAPIKey $googleAPIKey
```

Description: This function turns latitude and longitude coordinates into a human-readable address, ideal for location-based analyses.

### Performing Text Searches

Example: `Search-GMapText`

```powershell
Search-GMapText -Query "Cupcakes near New York" -GoogleAPIKey $googleAPIKey
```

Description: Conducts a text search for places related to 'Cupcakes' near New York, demonstrating the ability to use general search terms for finding specific types of places.

## Conclusion

These examples represent just a snapshot of what you can achieve with the Google Maps functions in pwshPlaces. Feel free to experiment with these examples, modify parameters, and explore the extensive functionalities offered by Google Maps in your PowerShell scripting.
