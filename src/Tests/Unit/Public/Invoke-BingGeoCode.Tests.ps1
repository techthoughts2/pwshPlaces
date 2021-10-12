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
    Describe 'Invoke-BingGeoCode' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        BeforeEach {
            Mock -CommandName Invoke-RestMethod -MockWith {
                $geoBingAddress
            } #endMock
            $bingAPIKey = 'xxxxxxxxxx'
        }
        Context 'Error' {

            It 'should throw if an error is encountered with invoking the API' {
                Mock -CommandName Invoke-RestMethod -MockWith {
                    throw 'Fake Error'
                } #endMock
                { Invoke-BingGeoCode -AddressLine '148 S Castell Ave' -City 'New Braunfels' -State TX -PostalCode 78130 -BingMapsAPIKey $bingAPIKey } | Should -Throw
            } #it

            It 'should warn the user if the API does not return an OK status' {
                Mock Write-Warning { }
                Mock -CommandName Invoke-RestMethod -MockWith {
                    [PSCustomObject]@{
                        results = ''
                        status  = 'ZERO_RESULTS'
                    }
                } #endMock
                Invoke-BingGeoCode -Query 'The Alamo' -BingMapsAPIKey $bingAPIKey
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
                $invokeBingGeoCodeSplat = @{
                    AddressLine    = '148 S Castell Ave'
                    City           = 'New Braunfels'
                    State          = 'TX'
                    PostalCode     = 78130
                    Country        = 'us'
                    BingMapsAPIKey = $bingAPIKey
                }
                Invoke-BingGeoCode @invokeBingGeoCodeSplat
                Assert-MockCalled -CommandName Write-Warning -Times 1
                Assert-VerifiableMock
            } #it

            It 'should return expected results if no issues are encountered' {
                $invokeBingGeoCodeSplat = @{
                    AddressLine    = '148 S Castell Ave'
                    City           = 'New Braunfels'
                    State          = 'TX'
                    PostalCode     = 78130
                    Country        = 'us'
                    BingMapsAPIKey = $bingAPIKey
                }
                $eval = Invoke-BingGeoCode @invokeBingGeoCodeSplat
                $eval.Latitude | Should -BeExactly '29.701293'
                $eval.Longitude | Should -BeExactly '-98.12502'
            } #it

            It 'should call the API with the expected parameters with address' {
                Mock -CommandName Invoke-RestMethod {
                    $Uri | Should -BeLike 'https://dev.virtualearth.net/REST/v1/Locations?output=json*'
                    $Uri | Should -BeLike '*addressLine=*'
                    $Uri | Should -BeLike '*locality=*'
                    $Uri | Should -BeLike '*adminDistrict=*'
                    $Uri | Should -BeLike '*postalCode=*'
                    $Uri | Should -BeLike '*countryRegion=*'
                    $Uri | Should -BeLike '*maxResults=*'
                    $Uri | Should -BeLike '*culture=*'
                } -Verifiable
                $invokeBingGeoCodeSplat = @{
                    AddressLine    = '148 S Castell Ave'
                    City           = 'New Braunfels'
                    State          = 'TX'
                    PostalCode     = 78130
                    Country        = 'us'
                    Language       = 'en'
                    MaxResults     = 20
                    BingMapsAPIKey = $bingAPIKey
                }
                Invoke-BingGeoCode @invokeBingGeoCodeSplat
                Assert-VerifiableMock
            } #it

            It 'should call the API with the expected parameters with location' {
                Mock -CommandName Invoke-RestMethod {
                    $Uri | Should -BeLike 'https://dev.virtualearth.net/REST/v1/Locations/29.7030,-98.1245?output=json*'
                } -Verifiable
                Invoke-BingGeoCode -Latitude '29.7030' -Longitude '-98.1245' -BingMapsAPIKey $bingAPIKey
                Assert-VerifiableMock
            } #it

        } #context_Success
    } #describe_Invoke-BingGeoCode
} #inModule
