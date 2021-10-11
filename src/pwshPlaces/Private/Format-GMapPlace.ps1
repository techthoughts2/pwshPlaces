<#
.SYNOPSIS
    Formats Place object with easier to understand properties while leaving original properties intact
.DESCRIPTION
    Changes Place object to custom PSType and creates additional properties that contains information most likely to be viewed.
.EXAMPLE
    $results.candidates | Format-GMapPlace

    Formats Place object results with a set of easier to understand properties
.PARAMETER Results
    Place API results
.OUTPUTS
    GMap.Place
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

    Based on code from: https://github.com/Kreloc/PoshGMaps
.COMPONENT
    pwshPlaces
#>
function Format-GMapPlace {
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

        $Results.PSTypeNames.Insert(0, 'GMap.Place')

        Write-Debug -Message ($Results.PSTypeNames | Out-String)

        $updateTypeDataSplat = @{
            TypeName   = 'GMap.Place'
            MemberType = 'ScriptProperty'
            MemberName = 'Latitude'
            Value      = { $this.geometry.location.lat }
            Force      = $true
        }
        Update-TypeData @updateTypeDataSplat

        $updateTypeDataSplat = @{
            TypeName   = 'GMap.Place'
            MemberType = 'ScriptProperty'
            MemberName = 'Longitude'
            Value      = { $this.geometry.location.lng }
            Force      = $true
        }
        Update-TypeData @updateTypeDataSplat

        $updateTypeDataSplat = @{
            TypeName   = 'GMap.Place'
            MemberType = 'ScriptProperty'
            MemberName = 'Address'
            Value      = { $this.formatted_address }
            Force      = $true
        }
        Update-TypeData @updateTypeDataSplat

        # if ($Contact) {
        $updateTypeDataSplat = @{
            TypeName   = 'GMap.Place'
            MemberType = 'ScriptProperty'
            MemberName = 'Open'
            Value      = { $this.opening_hours.open_now }
            Force      = $true
        }
        Update-TypeData @updateTypeDataSplat
        # }

        # set a default display of the above properties, all other properties are still there just not displayed
        $updateTypeDataSplat = @{
            TypeName                  = 'GMap.Place'
            DefaultDisplayPropertySet = 'place_id', 'name', 'Address', 'Open', 'rating', 'user_ratings_total', 'price_level', 'Latitude', 'Longitude', 'types'
            DefaultKeyPropertySet     = 'place_id'
            Force                     = $true
        }
        Update-TypeData @updateTypeDataSplat

        $Results
    } #process
    end {
        Write-Verbose ('Ending {0}' -f $myinvocation.mycommand)
    } #end
} #Format-GMapPlace
