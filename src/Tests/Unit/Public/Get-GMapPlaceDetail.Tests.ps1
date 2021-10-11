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
    Describe 'Get-GMapPlaceDetail' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        BeforeEach {
            Mock -CommandName Invoke-RestMethod -MockWith {
                $placeDetailsGMap
            } #endMock
        }
        Context 'Error' {

            It 'should throw if an error is encountered with invoking the API' {
                Mock -CommandName Invoke-RestMethod -MockWith {
                    throw 'Fake Error'
                } #endMock
                { Get-GMapPlaceDetail -PlaceID 'ChIJE43gTHK9XIYRleSxiXqF6GU' } | Should -Throw
            } #it

            It 'should warn the user if the API does not return an OK status' {
                Mock Write-Warning { }
                Mock -CommandName Invoke-RestMethod -MockWith {
                    [PSCustomObject]@{
                        results = ''
                        status  = 'ZERO_RESULTS'
                    }
                } #endMock
                Get-GMapPlaceDetail -PlaceID 'ChIJE43gTHK9XIYRleSxiXqF6GU' -Contact
                Assert-MockCalled -CommandName Write-Warning -Times 1
                Assert-VerifiableMock
            } #it

        } #context_Error
        Context 'Success' {

            It 'should return expected results if no issues are encountered' {
                $eval = Get-GMapPlaceDetail -PlaceID 'ChIJf9Yxhme9XIYRkXo-Bl62Q10'
                ($eval | Measure-Object).Count | Should -BeExactly 1
                $eval.place_id              | Should -BeExactly 'ChIJf9Yxhme9XIYRkXo-Bl62Q10'
                $eval.name                  | Should -BeExactly 'Krause''s Cafe'
                $eval.website               | Should -BeExactly 'https://www.krausescafe.com/'
                $eval.Address               | Should -BeExactly '148 S Castell Ave, New Braunfels, TX 78130, United States'
                $eval.Phone                 | Should -BeExactly '(830) 625-2807'
                $eval.Open                  | Should -BeExactly 'False'
                $eval.GoogleMapsURL         | Should -BeExactly 'https://maps.google.com/?cid=6720415583914850961'
                $eval.rating                | Should -BeExactly '4.3'
                $eval.user_ratings_total    | Should -BeExactly '3697'
                $eval.price_level           | Should -BeExactly '2'
                $eval.Latitude              | Should -BeExactly '29.7013856'
                $eval.Longitude             | Should -BeExactly '-98.1249258'
            } #it

            It 'should call the API with the expected parameters when all options are provided' {
                Mock -CommandName Invoke-RestMethod {
                    $Uri | Should -BeLike 'https://maps.googleapis.com/maps/api/place/details/json?place_id=*'
                    $Uri | Should -BeLike '*language=*'
                    $Uri | Should -BeLike '*fields=*'
                    $Uri | Should -BeLike '*address_component*'
                    $Uri | Should -BeLike '*formatted_phone_number*'
                    $Uri | Should -BeLike '*price_level*'
                    $Uri | Should -BeLike '*region=*'
                } -Verifiable
                Get-GMapPlaceDetail -PlaceID 'ChIJf9Yxhme9XIYRkXo-Bl62Q10' -Contact -Atmosphere -Language en -RegionBias us
                Assert-VerifiableMock
            } #it

        } #context_Success
    } #describe_Get-GMapPlaceDetails
} #inModule
