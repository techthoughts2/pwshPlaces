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
    Describe 'Format-BingPlace' -Tag Unit {
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
                $eval = ($findBingPlace.resourceSets.resources | Format-BingPlace)
                $eval.name                  | Should -BeExactly 'Krause''s Cafe'
                $eval.formattedAddress      | Should -BeExactly '148 S Castell Ave, New Braunfels, TX, 78130'
                $eval.PhoneNumber           | Should -BeExactly '(830) 625-2807'
                $eval.Website               | Should -BeExactly 'https://www.krausescafe.com/'
                $eval.Latitude              | Should -BeExactly '29.7015113830566'
                $eval.Longitude             | Should -BeExactly '-98.1247940063477'
                $eval.entityType            | Should -BeExactly 'Restaurant'
            } #it

        } #context_Success
    } #describe_Format-BingPlace
} #inModule
