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
    Describe 'Format-BingGeoCode' -Tag Unit {
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
                $eval = ($geoBingAddress.resourceSets.resources | Format-BingGeoCode)
                $eval.name              | Should -BeExactly '148 S Castell Ave, New Braunfels, TX 78130'
                $eval.FormattedAddress  | Should -BeExactly '148 S Castell Ave, New Braunfels, TX 78130'
                $eval.Street            | Should -BeExactly '148 S Castell Ave'
                $eval.City              | Should -BeExactly 'New Braunfels'
                $eval.Country           | Should -BeExactly 'United States'
                $eval.PostalCode        | Should -BeExactly '78130'
                $eval.Latitude          | Should -BeExactly '29.701293'
                $eval.Longitude         | Should -BeExactly '-98.12502'
                $eval.entityType        | Should -BeExactly 'Address'
            } #it

        } #context_Success
    } #describe_Format-BingGeoCode
} #inModule
