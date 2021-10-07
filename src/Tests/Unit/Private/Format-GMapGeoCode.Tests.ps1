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
    #-------------------------------------------------------------------------
    $WarningPreference = "SilentlyContinue"
    #-------------------------------------------------------------------------
    Describe 'Format-GMapGeoCode' -Tag Unit {
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
                $eval = ($geoGMapAddress.results | Format-GMapGeoCode)
                $eval.place_id          | Should -BeExactly 'ChIJK34phme9XIYRqstHW_gHr2w'
                $eval.formatted_address | Should -BeExactly '148 S Castell Ave, New Braunfels, TX 78130, USA'
                $eval.StreetNumber      | Should -BeExactly '148'
                $eval.Street            | Should -BeExactly 'South Castell Avenue'
                $eval.City              | Should -BeExactly 'New Braunfels'
                $eval.Country           | Should -BeExactly 'United States'
                $eval.PostalCode        | Should -BeExactly '78130'
                $eval.Latitude          | Should -BeExactly '29.7012853'
                $eval.Longitude         | Should -BeExactly '-98.1250235'
            } #it

        } #context_Success
    } #describe_Format-GMapGeoCode
} #inModule
