<#
.SYNOPSIS
    Formats TimeZone object with easier to understand properties while leaving original properties intact
.DESCRIPTION
    Changes TimeZone object to custom PSType and creates additional properties that contains information most likely to be viewed.
.EXAMPLE
    $results.resourceSets.resources.timeZone | Format-BingTimeZone

    Formats TimeZone object results with a set of easier to understand properties
.PARAMETER Results
    TimeZone API results
.OUTPUTS
    Bing.TimeZone
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

    Based on code from: https://github.com/Kreloc/PoshGMaps
.COMPONENT
    pwshPlaces
#>
function Format-BingTimeZone {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            HelpMessage = 'TimeZone API results',
            ValueFromPipeline = $true)]
        $Results
    )
    begin {
        Write-Verbose ('Starting {0}' -f $myinvocation.mycommand)
    } #begin
    process {
        Write-Debug -Message ($Results | Out-String)

        $Results.PSTypeNames.Insert(0, 'Bing.TimeZone')

        Write-Debug -Message ($Results.PSTypeNames | Out-String)

        $updateTypeDataSplat = @{
            TypeName   = 'Bing.TimeZone'
            MemberType = 'ScriptProperty'
            MemberName = 'TimeZoneName'
            Value      = { $this.genericName }
            Force      = $true
        }
        Update-TypeData @updateTypeDataSplat

        $updateTypeDataSplat = @{
            TypeName   = 'Bing.TimeZone'
            MemberType = 'ScriptProperty'
            MemberName = 'TimeZoneShort'
            Value      = { $this.abbreviation }
            Force      = $true
        }
        Update-TypeData @updateTypeDataSplat

        $updateTypeDataSplat = @{
            TypeName   = 'Bing.TimeZone'
            MemberType = 'ScriptProperty'
            MemberName = 'TimeZoneID'
            Value      = { $this.ianaTimeZoneId }
            Force      = $true
        }
        Update-TypeData @updateTypeDataSplat

        $updateTypeDataSplat = @{
            TypeName   = 'Bing.TimeZone'
            MemberType = 'ScriptProperty'
            MemberName = 'LocalTime'
            Value      = { $this.convertedTime.localTime }
            Force      = $true
        }
        Update-TypeData @updateTypeDataSplat

        $updateTypeDataSplat = @{
            TypeName   = 'Bing.TimeZone'
            MemberType = 'ScriptProperty'
            MemberName = 'UTCOffSetDST'
            Value      = { $this.convertedTime.utcOffsetWithDst }
            Force      = $true
        }
        Update-TypeData @updateTypeDataSplat

        $updateTypeDataSplat = @{
            TypeName   = 'Bing.TimeZone'
            MemberType = 'ScriptProperty'
            MemberName = 'TimeZoneCurrentName'
            Value      = { $this.convertedTime.timeZoneDisplayName }
            Force      = $true
        }
        Update-TypeData @updateTypeDataSplat

        $updateTypeDataSplat = @{
            TypeName   = 'Bing.TimeZone'
            MemberType = 'ScriptProperty'
            MemberName = 'TimeZoneCurrentShort'
            Value      = { $this.convertedTime.timeZoneDisplayAbbr }
            Force      = $true
        }
        Update-TypeData @updateTypeDataSplat

        # set a default display of the above properties, all other properties are still there just not displayed
        $updateTypeDataSplat = @{
            TypeName                  = 'Bing.TimeZone'
            DefaultDisplayPropertySet = 'TimeZoneName', 'TimeZoneShort', 'UTCOffSet', 'TimeZoneID', 'LocalTime', 'TimeZoneCurrentName', 'TimeZoneCurrentShort', 'UTCOffSetDST', 'dstRule'
            DefaultKeyPropertySet     = 'TimeZoneName'
            Force                     = $true
        }
        Update-TypeData @updateTypeDataSplat

        $Results
    } #process
    end {
        Write-Verbose ('Ending {0}' -f $myinvocation.mycommand)
    } #end
} #Format-BingTimeZone
