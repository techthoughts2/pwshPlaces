# Bing Maps Examples in pwshPlaces

Welcome to the practical examples section for Bing Maps in pwshPlaces. This document aims to showcase real-world applications and scenarios where the Bing Maps functions within pwshPlaces can be effectively utilized. Each example is designed to provide insights into the module's capabilities, helping you to apply these tools in your own projects.

## Examples

### Finding a Place

Example: `Find-BingPlace`

```powershell
Find-BingPlace -Query "Krause's cafe" -BingMapsAPIKey $bingAPIKey
```

Description: This command searches for "Krause's cafe", returning information about the place including its location, based on the user's IP location bias.

### Geocoding

#### Geocoding an Address

Example: `Invoke-BingGeoCode`

```powershell
Invoke-BingGeoCode -AddressLine '148 S Castell Ave' -City 'New Braunfels' -State TX -PostalCode 78130 -BingMapsAPIKey $bingAPIKey
```

Description: This example demonstrates how to convert a physical address into geographic coordinates (latitude and longitude).

#### Reverse Geocoding

Example: `Invoke-BingGeoCode` for Reverse Geocoding

```powershell
Invoke-BingGeoCode -Latitude '29.7030' -Longitude '-98.1245' -BingMapsAPIKey $bingAPIKey
```

Description: Converts latitude and longitude coordinates into a readable address, useful for understanding the location context of geographic data.

### Discovering Nearby Places

Example: `Search-BingNearbyPlace`

```powershell
Search-BingNearbyPlace -Type CafeRestaurants -PointLatitude '29.7049806' -PointLongitude '-98.068343' -BingMapsAPIKey $bingAPIKey
```

Description: Finds nearby café restaurants around the specified latitude and longitude, showcasing the ability to discover places of a specific type in a given area.

### Determining Time Zones

Example: `Find-BingTimeZone`

```powershell
Find-BingTimeZone -Query 'New Braunfels, TX' -BingMapsAPIKey $bingAPIKey
```

Description: Retrieves time zone information for 'New Braunfels, TX', including local time zone and
daylight saving details.

### Conclusion

These examples are just the beginning of what you can accomplish with Bing Maps in pwshPlaces. Experiment with these functions, mix and match parameters, and explore the vast possibilities of integrating Bing Maps into your PowerShell scripts.

For more detailed information on each function, refer to the main documentation or use the Get-Help command in PowerShell.
