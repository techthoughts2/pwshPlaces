#-------------------------------------------------------------------------
Set-Location -Path $PSScriptRoot
#-------------------------------------------------------------------------
$ModuleName = 'pwshPlaces'
$PathToManifest = [System.IO.Path]::Combine('..', '..', '..', $ModuleName, "$ModuleName.psd1")
$PathToTestObjects = [System.IO.Path]::Combine('..', 'TestObjects.psm1')
Import-Module $PathToTestObjects -DisableNameChecking -Global -Force
#-------------------------------------------------------------------------
if (Get-Module -Name $ModuleName -ErrorAction 'SilentlyContinue') {
    #if the module is already in memory, remove it
    Remove-Module -Name $ModuleName -Force
}
Import-Module $PathToManifest -Force
#-------------------------------------------------------------------------

InModuleScope 'pwshPlaces' {
    Describe 'Format-BingTimeZone' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        # Context 'Error' {
        # } #context_Error
        Context 'Success' {

            # BeforeEach {
            # } #beforeEach

            It 'should return the expected results for queries' {
                $eval = ($findBingTimeZone.resourceSets.resources.timeZoneAtLocation.timeZone | Format-BingTimeZone)
                $eval.TimeZoneName              | Should -BeExactly 'Central Standard Time'
                $eval.TimeZoneShort             | Should -BeExactly 'CST'
                $eval.UTCOffSet                 | Should -BeExactly '-6:00'
                $eval.TimeZoneID                | Should -BeExactly 'America/Chicago'
                $eval.LocalTime                 | Should -BeExactly '10/10/21 10:58:29'
                $eval.TimeZoneCurrentName       | Should -BeExactly 'Central Daylight Time'
                $eval.TimeZoneCurrentShort      | Should -BeExactly 'CDT'
                $eval.UTCOffSetDST              | Should -BeExactly '-5:00'
                $eval.dstRule.dstStartMonth     | Should -BeExactly 'Mar'
                $eval.dstRule.dstEndMonth       | Should -BeExactly 'Nov'
            } #it

            It 'should return the expected results for point' {
                $eval = ($findBingTimeZonePoint.resourceSets.resources.timeZone | Format-BingTimeZone)
                $eval.TimeZoneName              | Should -BeExactly 'Central Standard Time'
                $eval.TimeZoneShort             | Should -BeExactly 'CST'
                $eval.UTCOffSet                 | Should -BeExactly '-6:00'
                $eval.TimeZoneID                | Should -BeExactly 'America/Chicago'
                $eval.LocalTime                 | Should -BeExactly '10/10/21 10:58:29'
                $eval.TimeZoneCurrentName       | Should -BeExactly 'Central Daylight Time'
                $eval.TimeZoneCurrentShort      | Should -BeExactly 'CDT'
                $eval.UTCOffSetDST              | Should -BeExactly '-5:00'
                $eval.dstRule.dstStartMonth     | Should -BeExactly 'Mar'
                $eval.dstRule.dstEndMonth       | Should -BeExactly 'Nov'
            } #it

        } #context_Success
    } #describe_Format-BingTimeZone
} #inModule
