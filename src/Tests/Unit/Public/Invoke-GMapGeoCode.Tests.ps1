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
    Describe 'Invoke-GMapGeoCode' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        BeforeEach {
            Mock -CommandName Invoke-RestMethod -MockWith {
                $geoGMapAddress
            } #endMock
            $googleAPIKey = 'xxxxxxxxxx'
        }
        Context 'Error' {

            It 'should throw if an error is encountered with invoking the API' {
                Mock -CommandName Invoke-RestMethod -MockWith {
                    throw 'Fake Error'
                } #endMock
                { Invoke-GMapGeoCode -Address '24-593 Federation Drive, San Francisco, CA' -GoogleAPIKey $googleAPIKey } | Should -Throw
            } #it

            It 'should warn the user if the API does not return an OK status' {
                Mock Write-Warning { }
                Mock -CommandName Invoke-RestMethod -MockWith {
                    [PSCustomObject]@{
                        results = ''
                        status  = 'ZERO_RESULTS'
                    }
                } #endMock
                Invoke-GMapGeoCode -Address '24-593 Federation Drive, San Francisco, CA' -GoogleAPIKey $googleAPIKey
                Should -Invoke -CommandName Write-Warning -Times 1
                Assert-VerifiableMock
            } #it

        } #context_Error
        Context 'Success' {

            It 'should return expected results if no issues are encountered' {
                Mock -CommandName Invoke-RestMethod -MockWith {
                    $geoGMapLatLong
                } #endMock
                $invokeGMapGeoCodeSplat = @{
                    Latitude     = '29.7012853'
                    Longitude    = '-98.1250235'
                    Language     = 'en'
                    RegionBias   = 'us'
                    GoogleAPIKey = $googleAPIKey
                }
                $eval = Invoke-GMapGeoCode @invokeGMapGeoCodeSplat
                ($eval | Measure-Object).Count | Should -BeExactly 2
                $eval[0].Latitude | Should -BeExactly '29.7012853'
                $eval[0].Longitude | Should -BeExactly '-98.1250235'
            } #it

            It 'should call the API with the expected parameters with address' {
                Mock -CommandName Invoke-RestMethod {
                    $Uri | Should -BeLike 'https://maps.googleapis.com/maps/api/geocode/json?address=*'
                } -Verifiable
                Invoke-GMapGeoCode -Address '24-593 Federation Drive, San Francisco, CA' -GoogleAPIKey $googleAPIKey
                Assert-VerifiableMock
            } #it

            It 'should call the API with the expected parameters with location' {
                Mock -CommandName Invoke-RestMethod {
                    $Uri | Should -BeLike 'https://maps.googleapis.com/maps/api/geocode/json?latlng=*'
                } -Verifiable
                Invoke-GMapGeoCode -Latitude '29.7012853' -Longitude '-98.1250235' -GoogleAPIKey $googleAPIKey
                Assert-VerifiableMock
            } #it

            It 'should call the API with the expected parameters with place ID' {
                Mock -CommandName Invoke-RestMethod {
                    $Uri | Should -BeLike 'https://maps.googleapis.com/maps/api/geocode/json?place_id=*'
                } -Verifiable
                Invoke-GMapGeoCode -PlaceID 'ChIJK34phme9XIYRqstHW_gHr2w' -GoogleAPIKey $googleAPIKey
                Assert-VerifiableMock
            } #it

        } #context_Success
    } #describe_Invoke-GMapGeoCode
} #inModule
