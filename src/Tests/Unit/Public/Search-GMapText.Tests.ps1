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
    Describe 'Search-GMapText' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
            function Start-Sleep {
            }
        } #beforeAll
        BeforeEach {
            Mock -CommandName Invoke-RestMethod -MockWith {
                $nearbyGMap
            } #endMock
            $googleAPIKey = 'xxxxxxxxxx'
        }
        Context 'Error' {

            It 'should throw if an error is encountered with invoking the API' {
                Mock -CommandName Invoke-RestMethod -MockWith {
                    throw 'Fake Error'
                } #endMock
                { Search-GMapText -Query "Krause's Cafe" -GoogleAPIKey $googleAPIKey } | Should -Throw
            } #it

            It 'should warn the user if the API does not return an OK status' {
                Mock Write-Warning { }
                Mock -CommandName Invoke-RestMethod -MockWith {
                    [PSCustomObject]@{
                        results = ''
                        status  = 'ZERO_RESULTS'
                    }
                } #endMock
                Search-GMapText -Query "Airport" -RegionBias es -GoogleAPIKey $googleAPIKey
                Assert-MockCalled -CommandName Write-Warning -Times 1
                Assert-VerifiableMock
            } #it

            It 'should throw if subsequent pagetoken calls fail' {
                $script:mockCalled = 0
                $mockInvoke = {
                    $script:mockCalled++
                    if ($script:mockCalled -eq 1) {
                        return $textSearchGMap
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
                { Search-GMapText -Query "Cupcakes" -Type bakery -AllSearchResults -GoogleAPIKey $googleAPIKey } | Should -Throw
            } #it

        } #context_Error
        Context 'Success' {

            It 'should return expected results if no issues are encountered' {
                $searchGMapTextSplat = @{
                    Query          = 'Coco'
                    Latitude       = '26.1202'
                    Longitude      = '127.7025'
                    RankByDistance = $true
                    Type           = 'restaurant'
                    GoogleAPIKey   = $googleAPIKey
                }
                $eval = Search-GMapText @searchGMapTextSplat
                ($eval | Measure-Object).Count | Should -BeExactly 2
                $eval[0].Latitude | Should -BeExactly '29.7013856'
                $eval[0].Longitude | Should -BeExactly '-98.1249258'
            } #it

            It 'should call the API with the expected parameters when all options are provided' {
                Mock -CommandName Invoke-RestMethod {
                    $Uri | Should -BeLike 'https://maps.googleapis.com/maps/api/place/textsearch/json?query=*'
                    $Uri | Should -BeLike '*location=*'
                    $Uri | Should -BeLike '*radius=*'
                    $Uri | Should -BeLike '*type=*'
                    $Uri | Should -BeLike '*language=en*'
                    $Uri | Should -BeLike '*openNow*'
                    $Uri | Should -BeLike '*rankby=prominence*'
                    $Uri | Should -BeLike '*maxprice=*'
                    $Uri | Should -BeLike '*minprice=*'
                } -Verifiable
                $searchGMapTextSplat = @{
                    Query            = 'Coco'
                    Latitude         = '26.1202'
                    Longitude        = '127.7025'
                    Radius           = 5
                    RankByProminence = $true
                    Type             = 'restaurant'
                    Language         = 'en'
                    OpenNow          = $true
                    MinPrice         = 1
                    MaxPrice         = 2
                    AllSearchResults = $true
                    GoogleAPIKey     = $googleAPIKey
                }
                Search-GMapText @searchGMapTextSplat
                Assert-VerifiableMock
            } #it

            It 'should run the expected number of times if AllResults is specified' {
                $script:mockCalled = 0
                $mockInvoke = {
                    $script:mockCalled++
                    if ($script:mockCalled -eq 1) {
                        return $textSearchGMap
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
                $searchGMapTextSplat = @{
                    Query            = 'Coco'
                    Latitude         = '26.1202'
                    Longitude        = '127.7025'
                    Radius           = 5
                    RankByProminence = $true
                    Type             = 'restaurant'
                    Language         = 'en'
                    OpenNow          = $true
                    MinPrice         = 1
                    MaxPrice         = 2
                    AllSearchResults = $true
                    GoogleAPIKey     = $googleAPIKey
                }
                Search-GMapText @searchGMapTextSplat
                Assert-MockCalled -CommandName Invoke-RestMethod -Times 3
                Assert-VerifiableMock
            } #it

        } #context_Success
    } #describe_Search-GMapText
} #inModule
