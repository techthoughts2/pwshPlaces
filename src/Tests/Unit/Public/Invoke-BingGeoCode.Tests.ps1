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
        }
        Context 'Error' {

            It 'should throw if an error is encountered with invoking the API' {
                Mock -CommandName Invoke-RestMethod -MockWith {
                    throw 'Fake Error'
                } #endMock
                { Invoke-BingGeoCode -AddressLine '148 S Castell Ave' -City 'New Braunfels' -State TX -PostalCode 78130 } | Should -Throw
            } #it

            It 'should warn the user if the API does not return an OK status' {
                Mock Write-Warning { }
                Mock -CommandName Invoke-RestMethod -MockWith {
                    [PSCustomObject]@{
                        results = ''
                        status  = 'ZERO_RESULTS'
                    }
                } #endMock
                Invoke-BingGeoCode -AddressLine '148 S Castell Ave' -City 'New Braunfels' -State TX -PostalCode 78130 -Country us
                Assert-MockCalled -CommandName Write-Warning -Times 1
                Assert-VerifiableMock
            } #it

        } #context_Error
        Context 'Success' {

            It 'should return expected results if no issues are encountered' {
                $eval = Invoke-BingGeoCode -AddressLine '148 S Castell Ave' -City 'New Braunfels' -State TX -PostalCode 78130 -Country us
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
                    $Uri | Should -BeLike '*language=*'
                } -Verifiable
                Invoke-BingGeoCode -AddressLine '148 S Castell Ave' -City 'New Braunfels' -State TX -PostalCode 78130 -Country us -Language en -MaxResults 20
                Assert-VerifiableMock
            } #it

            It 'should call the API with the expected parameters with location' {
                Mock -CommandName Invoke-RestMethod {
                    $Uri | Should -BeLike 'https://dev.virtualearth.net/REST/v1/Locations/29.7030,-98.1245?output=json*'
                } -Verifiable
                Invoke-BingGeoCode -Latitude '29.7030' -Longitude '-98.1245'
                Assert-VerifiableMock
            } #it

        } #context_Success
    } #describe_Invoke-BingGeoCode
} #inModule
