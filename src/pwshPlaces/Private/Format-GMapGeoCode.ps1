<#
.SYNOPSIS
    Formats GeoCode object with easier to understand properties while leaving original properties intact
.DESCRIPTION
    Changes GeoCode object to custom PSType and creates additional properties that contains information most likely to be viewed.
.EXAMPLE
    $results.result | Format-GMapGeoCode

    Formats GeoCode object results with a set of easier to understand properties
.PARAMETER Results
    GeoCode API results
.OUTPUTS
    GMap.GeoCode
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

    Based on code from: https://github.com/Kreloc/PoshGMaps
.COMPONENT
    pwshPlaces
#>
function Format-GMapGeoCode {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            HelpMessage = 'GeoCode API results',
            ValueFromPipeline = $true)]
        $Results
    )
    begin {
        Write-Verbose ('Starting {0}' -f $myinvocation.mycommand)
    } #begin
    process {
        Write-Debug -Message ($Results | Out-String)

        $Results.PSTypeNames.Insert(0, 'GMap.GeoCode')

        Write-Debug -Message ($Results.PSTypeNames | Out-String)

        $updateTypeDataSplat = @{
            TypeName   = 'GMap.GeoCode'
            MemberType = 'ScriptProperty'
            MemberName = 'StreetNumber'
            Value      = { $(($this.address_components | Where-Object { $_.types -contains "street_number" }).long_name) }
            Force      = $true
        }
        Write-Verbose ($updateTypeDataSplat | Out-String)
        Update-TypeData @updateTypeDataSplat

        $updateTypeDataSplat = @{
            TypeName   = 'GMap.GeoCode'
            MemberType = 'ScriptProperty'
            MemberName = 'Street'
            Value      = { $($this.address_components | Where-Object { $_.types -contains "route" }).long_name }
            Force      = $true
        }
        Update-TypeData @updateTypeDataSplat

        $updateTypeDataSplat = @{
            TypeName   = 'GMap.GeoCode'
            MemberType = 'ScriptProperty'
            MemberName = 'City'
            Value      = { $($this.address_components | Where-Object { $_.types -contains "locality" }).long_name }
            Force      = $true
        }
        Update-TypeData @updateTypeDataSplat

        $updateTypeDataSplat = @{
            TypeName   = 'GMap.GeoCode'
            MemberType = 'ScriptProperty'
            MemberName = 'Country'
            Value      = { $($this.address_components | Where-Object { $_.types -contains "country" }).long_name }
            Force      = $true
        }
        Update-TypeData @updateTypeDataSplat

        $updateTypeDataSplat = @{
            TypeName   = 'GMap.GeoCode'
            MemberType = 'ScriptProperty'
            MemberName = 'PostalCode'
            Value      = { $($this.address_components | Where-Object { $_.types -contains "postal_code" }).long_name }
            Force      = $true
        }
        Update-TypeData @updateTypeDataSplat

        $updateTypeDataSplat = @{
            TypeName   = 'GMap.GeoCode'
            MemberType = 'ScriptProperty'
            MemberName = 'Latitude'
            Value      = { $this.geometry.location.lat }
            Force      = $true
        }
        Update-TypeData @updateTypeDataSplat

        $updateTypeDataSplat = @{
            TypeName   = 'GMap.GeoCode'
            MemberType = 'ScriptProperty'
            MemberName = 'Longitude'
            Value      = { $this.geometry.location.lng }
            Force      = $true
        }
        Update-TypeData @updateTypeDataSplat

        # set a default display of the above properties, all other properties are still there just not displayed
        $updateTypeDataSplat = @{
            TypeName                  = 'GMap.GeoCode'
            DefaultDisplayPropertySet = 'place_id', 'formatted_address', 'StreetNumber', 'Street', 'City', 'Country', 'PostalCode', 'Latitude', 'Longitude', 'types'
            DefaultKeyPropertySet     = 'place_id'
            Force                     = $true
        }
        Update-TypeData @updateTypeDataSplat

        $Results
    } #process
    end {
        Write-Verbose ('Ending {0}' -f $myinvocation.mycommand)
    } #end
} #Format-GMapGeoCode
