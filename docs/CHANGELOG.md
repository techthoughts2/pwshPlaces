# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.1]

- Module Changes
    - Updated links in `psd1` manifest
- Misc
    - Added new pwshPlaces logo and icons
    - Updated CONTRIBUTING guidelines

## [1.0.0]

- Module Changes
    - `Find-BingTimeZone`
        - Added new parameter for pulling more details DST details: `IncludeDSTRules`
    - `Get-GMapPlaceDetail`
        - Added new parameter for sorting reviews: `ReviewSort`
    - Updated help for all functions
    - Minor spelling corrections on output messages
- Build Updates
    - Updated all Github action files to:
        - support ignore certain files for Readthedocs implementation
        - updated actions from `v2` to `v3`
    - Moved `CHANGELOG.md` from `.github` to `docs`
    - `actions_bootstrap.ps1` - bumped module versions to latest
    - All Infra/Infrastructure references changed to Integration
    - Removed all test case uses of `Assert-MockCalled`
    - Added support for readthedocs
    - Corrected bug in `pwshPlaces.Settings.ps1` referencing `requiredPSVersion` fpr `ValidateRequirements` check.
- Misc
    - Updated `settings.json` for tab requirements to support Readthedocs
    - Added `SECURITY.md`
    - Updated `LICENSE` year

## [0.7.0]

- Changed API key(s) from being locally sourced environment variables to parameters
    - Added `GoogleAPIKey` parameter to all Google Maps functions
    - Added `BingMapsAPIKey` parameter to all Bing Maps functions

## [0.6.0]

- Initial release.
