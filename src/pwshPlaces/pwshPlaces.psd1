#
# Module manifest for module 'pwshPlaces'
#
# Generated by: Jake Morrison - @jakemorrison - https://www.techthoughts.info
#
# Generated on: 09/11/21
#

@{

    # Script module or binary module file associated with this manifest.
    RootModule        = 'pwshPlaces.psm1'

    # Version number of this module.
    ModuleVersion     = '0.7.3'

    # Supported PSEditions
    # CompatiblePSEditions = @()

    # ID used to uniquely identify this module
    GUID              = '9a9914bd-d115-4f42-bb5d-19c5e5561a3f'

    # Author of this module
    Author            = 'Jake Morrison'

    # Company or vendor of this module
    CompanyName       = 'TechThoughts'

    # Copyright statement for this module
    Copyright         = '(c) Jake Morrison. All rights reserved.'

    # Description of the functionality provided by this module
    Description       = 'Search for places, establishments, points of interest, and other detailed information about points around the globe using the Google Maps and/or Bing Maps API(s)'

    # Minimum version of the PowerShell engine required by this module
    # PowerShellVersion = ''

    # Name of the PowerShell host required by this module
    # PowerShellHostName = ''

    # Minimum version of the PowerShell host required by this module
    # PowerShellHostVersion = ''

    # Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # DotNetFrameworkVersion = ''

    # Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # ClrVersion = ''

    # Processor architecture (None, X86, Amd64) required by this module
    # ProcessorArchitecture = ''

    # Modules that must be imported into the global environment prior to importing this module
    # RequiredModules = @()

    # Assemblies that must be loaded prior to importing this module
    # RequiredAssemblies = @()

    # Script files (.ps1) that are run in the caller's environment prior to importing this module.
    # ScriptsToProcess = @()

    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @()

    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = @()

    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    # NestedModules = @()

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport = @(
        'Find-BingPlace'
        'Find-BingTimeZone'
        'Find-GMapPlace'
        'Get-GMapPlaceDetail'
        'Invoke-BingGeoCode'
        'Invoke-GMapGeoCode'
        'Search-BingNearbyPlace'
        'Search-GMapNearbyPlace'
        'Search-GMapText'
    )

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    # CmdletsToExport = '*'

    # Variables to export from this module
    # VariablesToExport = '*'

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    # AliasesToExport = '*'

    # DSC resources to export from this module
    # DscResourcesToExport = @()

    # List of all modules packaged with this module
    # ModuleList = @()

    # List of all files packaged with this module
    # FileList = @()

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData       = @{

        PSData = @{

            # Tags applied to this module. These help with module discovery in online galleries.
            Tags         = @(
                'API',
                'Area',
                'Atmosphere',
                'Bing',
                'BingMap'
                'BingMaps',
                'Contact',
                'Find',
                'FindLocation',
                'FindPlace',
                'Geo',
                'Geoencode',
                'Geoencoding',
                'Geolocation',
                'Google',
                'GoogleMap',
                'GoogleMaps',
                'GMap',
                'GMaps',
                'Latitude',
                'Longitude',
                'Locale',
                'Location',
                'Place',
                'Places',
                'Map',
                'MapAPI',
                'Maps',
                'MapsAPI',
                'Rating',
                'Ratings',
                'Search',
                'SearchPlace'
                'TimeZone'
            )

            # A URL to the license for this module.
            # LicenseUri = ''

            # A URL to the main website for this project.
            ProjectUri   = 'https://github.com/techthoughts2/pwshPlaces'

            # A URL to an icon representing this module.
            # IconUri = ''

            # ReleaseNotes of this module
            ReleaseNotes = 'https://github.com/techthoughts2/pwshPlaces/blob/master/.github/CHANGELOG.md'

            # Prerelease string of this module
            # Prerelease = ''

            # Flag to indicate whether the module requires explicit user acceptance for install/update/save
            # RequireLicenseAcceptance = $false

            # External dependent modules of this module
            # ExternalModuleDependencies = @()

        } # End of PSData hashtable

    } # End of PrivateData hashtable

    # HelpInfo URI of this module
    # HelpInfoURI = ''

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''

}
