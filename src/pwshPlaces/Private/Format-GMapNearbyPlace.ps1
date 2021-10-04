<#
.SYNOPSIS
    Formats Nearby Place object with easier to understand properties while leaving original properties intact
.DESCRIPTION
    Changes Nearby Place object to custom PSType and creates additional properties that contains information most likely to be viewed.
.EXAMPLE
    $results.results | Format-GMapNearbyPlace

    Formats Nearby Place object results with a set of easier to understand properties
.PARAMETER Results
    Nearby Place API results
.OUTPUTS
    GMap.NearbyPlace
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

    Based on code from: https://github.com/Kreloc/PoshGMaps
.COMPONENT
    pwshPlaces
#>
function Format-GMapNearbyPlace {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            HelpMessage = 'Place API results',
            ValueFromPipeline = $true)]
        $Results
    )
    begin {
        Write-Verbose ('Starting {0}' -f $myinvocation.mycommand)
    } #begin
    process {
        Write-Debug -Message ($Results | Out-String)

        $Results.PSTypeNames.Insert(0, 'GMap.NearbyPlace')

        Write-Debug -Message ($Results.PSTypeNames | Out-String)

        $updateTypeDataSplat = @{
            TypeName   = 'GMap.NearbyPlace'
            MemberType = 'ScriptProperty'
            MemberName = 'Latitude'
            Value      = { $this.geometry.location.lat }
            Force      = $true
        }
        Update-TypeData @updateTypeDataSplat

        $updateTypeDataSplat = @{
            TypeName   = 'GMap.NearbyPlace'
            MemberType = 'ScriptProperty'
            MemberName = 'Longitude'
            Value      = { $this.geometry.location.lng }
            Force      = $true
        }
        Update-TypeData @updateTypeDataSplat

        $updateTypeDataSplat = @{
            TypeName   = 'GMap.NearbyPlace'
            MemberType = 'ScriptProperty'
            MemberName = 'Address'
            Value      = { $this.vicinity }
            Force      = $true
        }
        Update-TypeData @updateTypeDataSplat

        $updateTypeDataSplat = @{
            TypeName   = 'GMap.NearbyPlace'
            MemberType = 'ScriptProperty'
            MemberName = 'Open'
            Value      = { $this.opening_hours.open_now }
            Force      = $true
        }
        Update-TypeData @updateTypeDataSplat

        # set a default display of the above properties, all other properties are still there just not displayed
        $updateTypeDataSplat = @{
            TypeName                  = 'GMap.NearbyPlace'
            DefaultDisplayPropertySet = 'place_id', 'name', 'Address', 'Latitude', 'Longitude', 'types', 'rating', 'user_ratings_total', 'price_level', 'Open'
            DefaultKeyPropertySet     = 'place_id'
            Force                     = $true
        }
        Update-TypeData @updateTypeDataSplat

        $Results
    } #process
    end {
        Write-Verbose ('Ending {0}' -f $myinvocation.mycommand)
    } #end
} #Format-GMapNearbyPlace
