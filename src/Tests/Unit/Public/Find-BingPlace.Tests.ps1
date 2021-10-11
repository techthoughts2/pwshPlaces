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
    Describe 'Find-BingPlace' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        BeforeEach {
            Mock -CommandName Invoke-RestMethod -MockWith {
                $findBingPlace
            } #endMock
        }
        Context 'Error' {

            It 'should throw if an error is encountered with invoking the API' {
                Mock -CommandName Invoke-RestMethod -MockWith {
                    throw 'Fake Error'
                } #endMock
                { Find-BingPlace -Query 'cafe' } | Should -Throw
            } #it

            It 'should warn the user if the API does not return an OK status' {
                Mock Write-Warning { }
                Mock -CommandName Invoke-RestMethod -MockWith {
                    [PSCustomObject]@{
                        results = ''
                        status  = 'ZERO_RESULTS'
                    }
                } #endMock
                Find-BingPlace -Query 'cafe'
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
                Find-BingPlace -Query 'cafe'
                Assert-MockCalled -CommandName Write-Warning -Times 1
                Assert-VerifiableMock
            } #it

            It 'should return expected results if no issues are encountered' {
                $eval = Find-BingPlace -Query 'cafe' -PointLatitude '29.7049806' -PointLongitude '-98.068343'
                ($eval | Measure-Object).Count | Should -BeExactly 1
                $eval.Latitude | Should -BeExactly '29.7015113830566'
                $eval.Longitude | Should -BeExactly '-98.1247940063477'
            } #it

            #  jake- put all the things here
            It 'should call the API with the expected parameters when all options are provided' {
                Mock -CommandName Invoke-RestMethod {
                    $Uri | Should -BeLike 'https://dev.virtualearth.net/REST/v1/LocalSearch?output=json*'
                    $Uri | Should -BeLike '*query=*'
                    $Uri | Should -BeLike '*userLocation=*'
                    $Uri | Should -BeLike '*culture=en*'
                    $Uri | Should -BeLike '*maxResults=*'
                } -Verifiable
                Find-BingPlace -Query 'cafe' -PointLatitude '29.7049806' -PointLongitude '-98.068343' -Language en -MaxResults 20
                Assert-VerifiableMock
            } #it

            It 'should call the API with the expected parameters with circle' {
                Mock -CommandName Invoke-RestMethod {
                    $Uri | Should -BeLike 'https://dev.virtualearth.net/REST/v1/LocalSearch?output=json*userCircularMapView=*'
                } -Verifiable
                Find-BingPlace -Query 'cafe' -CircleLatitude '29.7049806' -CircleLongitude '-98.068343' -CircleRadius '5000'
                Assert-VerifiableMock
            } #it

            It 'should call the API with the expected parameters with rectangle' {
                Mock -CommandName Invoke-RestMethod {
                    $Uri | Should -BeLike 'https://dev.virtualearth.net/REST/v1/LocalSearch?output=json*userMapView=*'
                } -Verifiable
                Find-BingPlace -Query 'cafe' -SouthLatitude '39.8592387' -WestLongitude '-75.295486' -NorthLatitude '40.0381942' -EastLongitude '-75.0064087' -Region us
                Assert-VerifiableMock
            } #it

        } #context_Success
    } #describe_Find-BingPlace
} #inModule