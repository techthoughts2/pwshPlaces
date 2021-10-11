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
    Describe 'Format-GMapPlaceDetail' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        # Context 'Error' {
        # } #context_Error
        Context 'Success' {

            # BeforeEach {
            # } #beforeEach

            It 'should return the expected results' {
                $eval = ($placeDetailsGMap.result | Format-GMapPlaceDetail)
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

        } #context_Success
    } #describe_Format-GMapPlaceDetail
} #inModule
