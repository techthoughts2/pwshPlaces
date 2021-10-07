<#
.SYNOPSIS
    Formats GeoCode object with easier to understand properties while leaving original properties intact
.DESCRIPTION
    Changes GeoCode object to custom PSType and creates additional properties that contains information most likely to be viewed.
.EXAMPLE
    $results.resourceSets.resources | Format-BingGeoCode

    Formats GeoCode object results with a set of easier to understand properties
.PARAMETER Results
    GeoCode API results
.OUTPUTS
    Bing.GeoCode
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

    Based on code from: https://github.com/Kreloc/PoshGMaps
.COMPONENT
    pwshPlaces
#>
function Format-BingGeoCode {
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

        $Results.PSTypeNames.Insert(0, 'Bing.GeoCode')

        Write-Debug -Message ($Results.PSTypeNames | Out-String)

        $updateTypeDataSplat = @{
            TypeName   = 'Bing.GeoCode'
            MemberType = 'ScriptProperty'
            MemberName = 'formatted_address'
            Value      = { $this.address.formattedAddress }
            Force      = $true
        }
        Update-TypeData @updateTypeDataSplat

        $updateTypeDataSplat = @{
            TypeName   = 'Bing.GeoCode'
            MemberType = 'ScriptProperty'
            MemberName = 'Street'
            Value      = { $this.address.addressLine }
            Force      = $true
        }
        Update-TypeData @updateTypeDataSplat

        $updateTypeDataSplat = @{
            TypeName   = 'Bing.GeoCode'
            MemberType = 'ScriptProperty'
            MemberName = 'City'
            Value      = { $this.address.locality }
            Force      = $true
        }
        Update-TypeData @updateTypeDataSplat

        $updateTypeDataSplat = @{
            TypeName   = 'Bing.GeoCode'
            MemberType = 'ScriptProperty'
            MemberName = 'Country'
            Value      = { $this.address.countryRegion }
            Force      = $true
        }
        Update-TypeData @updateTypeDataSplat

        $updateTypeDataSplat = @{
            TypeName   = 'Bing.GeoCode'
            MemberType = 'ScriptProperty'
            MemberName = 'PostalCode'
            Value      = { $this.address.postalCode }
            Force      = $true
        }
        Update-TypeData @updateTypeDataSplat

        $updateTypeDataSplat = @{
            TypeName   = 'Bing.GeoCode'
            MemberType = 'ScriptProperty'
            MemberName = 'Latitude'
            Value      = { $this.point.coordinates[0] }
            Force      = $true
        }
        Update-TypeData @updateTypeDataSplat

        $updateTypeDataSplat = @{
            TypeName   = 'Bing.GeoCode'
            MemberType = 'ScriptProperty'
            MemberName = 'Longitude'
            Value      = { $this.point.coordinates[1] }
            Force      = $true
        }
        Update-TypeData @updateTypeDataSplat

        # set a default display of the above properties, all other properties are still there just not displayed
        $updateTypeDataSplat = @{
            TypeName                  = 'Bing.GeoCode'
            DefaultDisplayPropertySet = 'name', 'formatted_address', 'Street', 'City', 'Country', 'PostalCode', 'Latitude', 'Longitude', 'entityType'
            DefaultKeyPropertySet     = 'name'
            Force                     = $true
        }
        Update-TypeData @updateTypeDataSplat

        $Results
    } #process
    end {
        Write-Verbose ('Ending {0}' -f $myinvocation.mycommand)
    } #end
} #Format-BingGeoCode
