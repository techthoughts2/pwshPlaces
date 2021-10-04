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
    Describe 'Search-GMapNearbyPlace' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
            function Start-Sleep {
            }
        } #beforeAll
        BeforeEach {
            Mock -CommandName Invoke-RestMethod -MockWith {
                $nearby
            } #endMock
        }
        Context 'Error' {

            It 'should throw if an error is encountered with invoking the API' {
                Mock -CommandName Invoke-RestMethod -MockWith {
                    throw 'Fake Error'
                } #endMock
                { Search-GMapNearbyPlace -Latitude '29.7049806' -Longitude '-98.068343' -Radius 5000 } | Should -Throw
            } #it

            It 'should warn the user if the API does not return an OK status' {
                Mock Write-Warning { }
                Mock -CommandName Invoke-RestMethod -MockWith {
                    [PSCustomObject]@{
                        results = ''
                        status  = 'ZERO_RESULTS'
                    }
                } #endMock
                Search-GMapNearbyPlace -Latitude '29.7013856' -Longitude '-98.1249258' -Radius 1000 -Type restaurant -MinPrice 1 -MaxPrice 3
                Assert-MockCalled -CommandName Write-Warning -Times 1
                Assert-VerifiableMock
            } #it

            It 'should throw if subsequent pagetoken calls fail' {
                $script:mockCalled = 0
                $mockInvoke = {
                    $script:mockCalled++
                    if ($script:mockCalled -eq 1) {
                        return $nearby
                    }
                    elseif ($script:mockCalled -eq 2) {
                        throw 'Fake Error'
                    }
                    elseif ($script:mockCalled -eq 3) {
                        $mockObj = [PSCustomObject]@{
                            html_attributions = ''
                            next_page_token   = 'toooooken'
                            status            = 'OK'

                        }
                        return $mockObj
                    }
                    else {
                        $mockObj = [PSCustomObject]@{
                            html_attributions = ''
                            status            = 'OK'

                        }
                        return $mockObj
                    }
                } #mock_invoke
                Mock -CommandName Invoke-RestMethod -MockWith $mockInvoke
                { Search-GMapNearbyPlace -Latitude '29.7013856' -Longitude '-98.1249258' -Radius 1000 -Type restaurant -MinPrice 1 -MaxPrice 3 -AllSearchResults } | Should -Throw
            } #it

        } #context_Error
        Context 'Success' {

            It 'should return expected results if no issues are encountered' {
                $eval = Search-GMapNearbyPlace -Latitude '29.7049806' -Longitude '-98.068343' -RankByDistance
                $eval.Count | Should -BeExactly 2
                $eval[0].Latitude | Should -BeExactly '29.7013856'
                $eval[0].Longitude | Should -BeExactly '-98.1249258'
            } #it

            It 'should call the API with the expected parameters when all options are provided' {
                Mock -CommandName Invoke-RestMethod {
                    $Uri | Should -BeLike 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=*'
                    $Uri | Should -BeLike '*radius=*'
                    $Uri | Should -BeLike '*keyword=*'
                    $Uri | Should -BeLike '*type=*'
                    $Uri | Should -BeLike '*language=en*'
                    $Uri | Should -BeLike '*openNow*'
                    $Uri | Should -BeLike '*rankby=prominence*'
                    $Uri | Should -BeLike '*maxprice=*'
                    $Uri | Should -BeLike '*minprice=*'
                } -Verifiable
                Search-GMapNearbyPlace -Latitude '29.7049806' -Longitude '-98.068343' -Radius 5000 -RankByProminence -Keyword 'pasta' -Type restaurant -Language en -OpenNow -MaxPrice 4 -MinPrice 2
                Assert-VerifiableMock
            } #it

            It 'should run the expected number of times if AllResults is specified' {
                $script:mockCalled = 0
                $mockInvoke = {
                    $script:mockCalled++
                    if ($script:mockCalled -eq 1) {
                        return $nearby
                    }
                    elseif ($script:mockCalled -eq 2) {
                        $mockObj = [PSCustomObject]@{
                            html_attributions = ''
                            next_page_token   = 'toooooken'
                            status            = 'OK'
                        }
                        return $mockObj
                    }
                    elseif ($script:mockCalled -eq 3) {
                        $mockObj = [PSCustomObject]@{
                            html_attributions = ''
                            next_page_token   = 'toooooken'
                            status            = 'OK'

                        }
                        return $mockObj
                    }
                    else {
                        $mockObj = [PSCustomObject]@{
                            html_attributions = ''
                            status            = 'OK'

                        }
                        return $mockObj
                    }
                } #mock_invoke
                Mock -CommandName Invoke-RestMethod -MockWith $mockInvoke
                Search-GMapNearbyPlace -Latitude '29.7013856' -Longitude '-98.1249258' -Radius 1000 -Type restaurant -MinPrice 1 -MaxPrice 3 -AllSearchResults
                Assert-MockCalled -CommandName Invoke-RestMethod -Times 3
                Assert-VerifiableMock
            } #it

        } #context_Success
    } #describe_Search-GMapNearbyPlace
} #inModule
