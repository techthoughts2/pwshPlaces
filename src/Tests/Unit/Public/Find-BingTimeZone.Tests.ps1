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
    Describe 'Find-BingTimeZone' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        BeforeEach {
            Mock -CommandName Invoke-RestMethod -MockWith {
                $findBingTimeZone
            } #endMock
            $bingAPIKey = 'xxxxxxxxxx'
        }
        Context 'Error' {

            It 'should throw if an error is encountered with invoking the API' {
                Mock -CommandName Invoke-RestMethod -MockWith {
                    throw 'Fake Error'
                } #endMock
                { Find-BingTimeZone -Query 'New Braunfels, TX' -BingMapsAPIKey $bingAPIKey } | Should -Throw
            } #it

            It 'should warn the user if the API does not return an OK status' {
                Mock Write-Warning { }
                Mock -CommandName Invoke-RestMethod -MockWith {
                    [PSCustomObject]@{
                        results = ''
                        status  = 'ZERO_RESULTS'
                    }
                } #endMock
                Find-BingTimeZone -PointLatitude 29.70 -PointLongitude -98.11 -BingMapsAPIKey $bingAPIKey
                Assert-MockCalled -CommandName Write-Warning -Times 1
                Assert-VerifiableMock
            } #it

        } #context_Error
        Context 'Success' {

            It 'should warn the user if the API call was successful, but no results were found' {
                Mock Write-Warning { }
                Mock -CommandName Invoke-RestMethod -MockWith {
                    [PSCustomObject]@{
                        resourceSets      = [PSCustomObject]@{
                            estimatedTotal = 0
                        }
                        statusCode        = '200'
                        statusDescription = 'OK'
                    }
                } #endMock
                $findBingTimeZoneSplat = @{
                    PointLatitude  = 29.70
                    PointLongitude = '-98.11'
                    BingMapsAPIKey = $bingAPIKey
                }
                Find-BingTimeZone @findBingTimeZoneSplat
                Assert-MockCalled -CommandName Write-Warning -Times 1
                Assert-VerifiableMock
            } #it

            It 'should return expected results if no issues are encountered with query' {
                $eval = Find-BingTimeZone -Query 'New Braunfels, TX' -BingMapsAPIKey $bingAPIKey
                ($eval | Measure-Object).Count  | Should -BeExactly 1
                $eval.TimeZoneName              | Should -BeExactly 'Central Standard Time'
                $eval.TimeZoneShort             | Should -BeExactly 'CST'
                $eval.UTCOffSet                 | Should -BeExactly '-6:00'
                $eval.TimeZoneID                | Should -BeExactly 'America/Chicago'
                $eval.LocalTime                 | Should -BeExactly '10/10/21 10:58:29'
                $eval.TimeZoneCurrentName       | Should -BeExactly 'Central Daylight Time'
                $eval.TimeZoneCurrentShort      | Should -BeExactly 'CDT'
                $eval.UTCOffSetDST              | Should -BeExactly '-5:00'
            } #it

            It 'should return expected results if no issues are encountered with point' {
                Mock -CommandName Invoke-RestMethod -MockWith {
                    $findBingTimeZonePoint
                } #endMock
                $findBingTimeZoneSplat = @{
                    PointLatitude  = 29.70
                    PointLongitude = '-98.11'
                    BingMapsAPIKey = $bingAPIKey
                }
                $eval = Find-BingTimeZone @findBingTimeZoneSplat
                ($eval | Measure-Object).Count  | Should -BeExactly 1
                $eval.TimeZoneName              | Should -BeExactly 'Central Standard Time'
                $eval.TimeZoneShort             | Should -BeExactly 'CST'
                $eval.UTCOffSet                 | Should -BeExactly '-6:00'
                $eval.TimeZoneID                | Should -BeExactly 'America/Chicago'
                $eval.LocalTime                 | Should -BeExactly '10/10/21 10:58:29'
                $eval.TimeZoneCurrentName       | Should -BeExactly 'Central Daylight Time'
                $eval.TimeZoneCurrentShort      | Should -BeExactly 'CDT'
                $eval.UTCOffSetDST              | Should -BeExactly '-5:00'
            } #it

            #  jake- put all the things here
            It 'should call the API with the expected parameters when all options are provided' {
                Mock -CommandName Invoke-RestMethod {
                    $Uri | Should -BeLike 'https://dev.virtualearth.net/REST/v1/TimeZone*?output=json*'
                    $Uri | Should -BeLike '*userRegion=*'
                    $Uri | Should -BeLike '*culture=en*'
                } -Verifiable
                $findBingTimeZoneSplat = @{
                    PointLatitude  = 29.70
                    PointLongitude = '-98.11'
                    Language       = 'en'
                    RegionBias     = 'us'
                    BingMapsAPIKey = $bingAPIKey
                }
                Find-BingTimeZone @findBingTimeZoneSplat
                Assert-VerifiableMock
            } #it

        } #context_Success
    } #describe_Find-BingTimeZone
} #inModule
