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
    Describe 'Find-GMapPlace' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        BeforeEach {
            Mock -CommandName Invoke-RestMethod -MockWith {
                $findGMapPlaceBasic
            } #endMock
        }
        Context 'Error' {

            It 'should throw if an error is encountered with invoking the API' {
                Mock -CommandName Invoke-RestMethod -MockWith {
                    throw 'Fake Error'
                } #endMock
                { Find-GMapPlace -Query 'cafe' } | Should -Throw
            } #it

            It 'should warn the user if the API does not return an OK status' {
                Mock Write-Warning { }
                Mock -CommandName Invoke-RestMethod -MockWith {
                    [PSCustomObject]@{
                        results = ''
                        status  = 'ZERO_RESULTS'
                    }
                } #endMock
                Find-GMapPlace -Query 'cafe'
                Assert-MockCalled -CommandName Write-Warning -Times 1
                Assert-VerifiableMock
            } #it

        } #context_Error
        Context 'Success' {

            It 'should return expected results if no issues are encountered' {
                $eval = Find-GMapPlace -Query 'cafe' -PointLatitude '29.7049806' -PointLongitude '-98.068343'
                ($eval | Measure-Object).Count | Should -BeExactly 1
                $eval[0].Latitude | Should -BeExactly '29.7013856'
                $eval[0].Longitude | Should -BeExactly '-98.1249258'
            } #it

            #  jake- put all the things here
            It 'should call the API with the expected parameters when all options are provided' {
                Mock -CommandName Invoke-RestMethod {
                    $Uri | Should -BeLike 'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=*'
                    $Uri | Should -BeLike '*phonenumber*'
                    $Uri | Should -BeLike '*locationbias=point*'
                    $Uri | Should -BeLike '*language=en*'
                    $Uri | Should -BeLike '*opening_hours*'
                    $Uri | Should -BeLike '*price_level*'
                } -Verifiable
                Find-GMapPlace -Query '+18306252807' -PointLatitude '29.7049806' -PointLongitude '-98.068343' -Contact -Atmosphere -Language en
                Assert-VerifiableMock
            } #it

            It 'should call the API with the expected parameters with circle' {
                Mock -CommandName Invoke-RestMethod {
                    $Uri | Should -BeLike 'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=*locationbias=circle*'
                } -Verifiable
                Find-GMapPlace -Query 'cafe' -CircleLatitude '29.7049806' -CircleLongitude '-98.068343' -CircleRadius '8046'
                Assert-VerifiableMock
            } #it

            It 'should call the API with the expected parameters with rectangle' {
                Mock -CommandName Invoke-RestMethod {
                    $Uri | Should -BeLike 'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=*locationbias=rectangle*'
                } -Verifiable
                Find-GMapPlace -Query 'cafe' -SouthLatitude '39.8592387' -WestLongitude '-75.295486' -NorthLatitude '40.0381942' -EastLongitude '-75.0064087'
                Assert-VerifiableMock
            } #it

        } #context_Success
    } #describe_Find-GMapPlace
} #inModule
