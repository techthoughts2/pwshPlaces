#region Gmap

#region findPlace

$findGMapPlaceBasic = [PSCustomObject]@{
    candidates = [PSCustomObject]@{
        business_status       = 'OPERATIONAL'
        formatted_address     = '148 S Castell Ave, New Braunfels, TX 78130, United States'
        geometry              = [PSCustomObject]@{
            location = [PSCustomObject]@{
                lat = '29.7013856'
                lng = '-98.1249258'
            }
            viewport = [PSCustomObject]@{
                northeast = [PSCustomObject]@{
                    lat = '29.7028062298927'
                    lng = '-98.1235759201073'
                }
                southwest = [PSCustomObject]@{
                    lat = '29.7001065701073'
                    lng = '-98.1262755798927'
                }
            }
        }
        icon                  = 'https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/restaurant-71.png'
        icon_background_color = '#FF9E67'
        icon_mask_base_uri    = 'https://maps.gstatic.com/mapfiles/place_api/icons/v2/restaurant_pinlet'
        name                  = 'Krause''s Cafe'
        place_id              = 'ChIJf9Yxhme9XIYRkXo-Bl62Q10'
        plus_code             = [PSCustomObject]@{
            compound_code = 'PV2G+H2 New Braunfels, Texas'
            global_code   = '76X3PV2G+H2'
        }
        types                 = @(
            'bar'
            'restaurant'
            'food'
            'point_of_interest'
            'establishment'
        )
    }
    status     = 'OK'
}

$findGMapPlaceAtmosphere = [PSCustomObject]@{
    candidates = [PSCustomObject]@{
        business_status       = 'OPERATIONAL'
        formatted_address     = '148 S Castell Ave, New Braunfels, TX 78130, United States'
        geometry              = [PSCustomObject]@{
            location = [PSCustomObject]@{
                lat = '29.7013856'
                lng = '-98.1249258'
            }
            viewport = [PSCustomObject]@{
                northeast = [PSCustomObject]@{
                    lat = '29.7028062298927'
                    lng = '-98.1235759201073'
                }
                southwest = [PSCustomObject]@{
                    lat = '29.7001065701073'
                    lng = '-98.1262755798927'
                }
            }
        }
        icon                  = 'https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/restaurant-71.png'
        icon_background_color = '#FF9E67'
        icon_mask_base_uri    = 'https://maps.gstatic.com/mapfiles/place_api/icons/v2/restaurant_pinlet'
        name                  = 'Krause''s Cafe'
        place_id              = 'ChIJf9Yxhme9XIYRkXo-Bl62Q10'
        plus_code             = [PSCustomObject]@{
            compound_code = 'PV2G+H2 New Braunfels, Texas'
            global_code   = '76X3PV2G+H2'
        }
        price_level           = '2'
        rating                = '4.3'
        types                 = @(
            'bar'
            'restaurant'
            'food'
            'point_of_interest'
            'establishment'
        )
        user_ratings_total    = '3675'
    }
    status     = 'OK'
}

$findGMapPlaceContact = [PSCustomObject]@{
    candidates = [PSCustomObject]@{
        business_status       = 'OPERATIONAL'
        formatted_address     = '148 S Castell Ave, New Braunfels, TX 78130, United States'
        geometry              = [PSCustomObject]@{
            location = [PSCustomObject]@{
                lat = '29.7013856'
                lng = '-98.1249258'
            }
            viewport = [PSCustomObject]@{
                northeast = [PSCustomObject]@{
                    lat = '29.7028062298927'
                    lng = '-98.1235759201073'
                }
                southwest = [PSCustomObject]@{
                    lat = '29.7001065701073'
                    lng = '-98.1262755798927'
                }
            }
        }
        icon                  = 'https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/restaurant-71.png'
        icon_background_color = '#FF9E67'
        icon_mask_base_uri    = 'https://maps.gstatic.com/mapfiles/place_api/icons/v2/restaurant_pinlet'
        name                  = 'Krause''s Cafe'
        opening_hours         = [PSCustomObject]@{
            open_now = 'False'
        }
        place_id              = 'ChIJf9Yxhme9XIYRkXo-Bl62Q10'
        plus_code             = [PSCustomObject]@{
            compound_code = 'PV2G+H2 New Braunfels, Texas'
            global_code   = '76X3PV2G+H2'
        }
        types                 = @(
            'bar'
            'restaurant'
            'food'
            'point_of_interest'
            'establishment'
        )
    }
    status     = 'OK'
}

$findGMapPlaceAll = [PSCustomObject]@{
    candidates = [PSCustomObject]@{
        business_status       = 'OPERATIONAL'
        formatted_address     = '148 S Castell Ave, New Braunfels, TX 78130, United States'
        geometry              = [PSCustomObject]@{
            location = [PSCustomObject]@{
                lat = '29.7013856'
                lng = '-98.1249258'
            }
            viewport = [PSCustomObject]@{
                northeast = [PSCustomObject]@{
                    lat = '29.7028062298927'
                    lng = '-98.1235759201073'
                }
                southwest = [PSCustomObject]@{
                    lat = '29.7001065701073'
                    lng = '-98.1262755798927'
                }
            }
        }
        icon                  = 'https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/restaurant-71.png'
        icon_background_color = '#FF9E67'
        icon_mask_base_uri    = 'https://maps.gstatic.com/mapfiles/place_api/icons/v2/restaurant_pinlet'
        name                  = 'Krause''s Cafe'
        opening_hours         = [PSCustomObject]@{
            open_now = 'False'
        }
        place_id              = 'ChIJf9Yxhme9XIYRkXo-Bl62Q10'
        plus_code             = [PSCustomObject]@{
            compound_code = 'PV2G+H2 New Braunfels, Texas'
            global_code   = '76X3PV2G+H2'
        }
        price_level           = '2'
        rating                = '4.3'
        types                 = @(
            'bar'
            'restaurant'
            'food'
            'point_of_interest'
            'establishment'
        )
        user_ratings_total    = '3675'
    }
    status     = 'OK'
}

#endRegion

#region GeoCode

$geoGMapAddress = [PSCustomObject]@{
    results = [PSCustomObject]@{
        address_components = @(
            [PSCustomObject]@{
                long_name  = '148'
                short_name = '148'
                types      = @(
                    'street_number'
                )
            }
            [PSCustomObject]@{
                long_name  = 'South Castell Avenue'
                short_name = 'S Castell Ave'
                types      = @(
                    'route'
                )
            }
            [PSCustomObject]@{
                long_name  = ''
                short_name = ''
                types      = @(

                )
            }
            [PSCustomObject]@{
                long_name  = 'New Braunfels'
                short_name = 'New Braunfels'
                types      = @(
                    'locality'
                    'political'
                )
            }
            [PSCustomObject]@{
                long_name  = 'Comal County'
                short_name = 'Comal County'
                types      = @(
                    'administrative_area_level_2'
                    'political'
                )
            }
            [PSCustomObject]@{
                long_name  = 'Texas'
                short_name = 'TX'
                types      = @(
                    'administrative_area_level_1'
                    'political'
                )
            }
            [PSCustomObject]@{
                long_name  = 'United States'
                short_name = 'US'
                types      = @(
                    'country'
                    'political'
                )
            }
            [PSCustomObject]@{
                long_name  = '78130'
                short_name = '78130'
                types      = @(
                    'postal_code'
                )
            }
            [PSCustomObject]@{
                long_name  = '5102'
                short_name = '5102'
                types      = @(
                    'postal_code_suffix'
                )
            }
        )
        formatted_address  = '148 S Castell Ave, New Braunfels, TX 78130, USA'
        geometry           = [PSCustomObject]@{
            bounds        = [PSCustomObject]@{
                northeast = [PSCustomObject]@{
                    lat = '29.7014997'
                    lng = '-98.1247988'
                }
                southwest = [PSCustomObject]@{
                    lat = '29.7010964'
                    lng = '-98.1252494'
                }
            }
            location      = [PSCustomObject]@{
                lat = '29.7012853'
                lng = '-98.1250235'
            }
            location_type = 'ROOFTOP'
            viewport      = [PSCustomObject]@{
                northeast = [PSCustomObject]@{
                    lat = '29.7026470302915'
                    lng = '-98.1236751197085'
                }
                southwest = [PSCustomObject]@{
                    lat = '29.6999490697085'
                    lng = '-98.1263730802915'
                }
            }
        }
        place_id           = 'ChIJK34phme9XIYRqstHW_gHr2w'
        types              = @(
            'premise'
        )
    }
    status  = 'OK'
}

$geoGMapLatLong = [PSCustomObject]@{
    plus_code = [PSCustomObject]@{
        compound_code = 'PV2F+GX New Braunfels, TX, USA'
        global_code   = '76X3PV2F+GX'
    }
    results   = @(
        [PSCustomObject]@{
            address_components = @(
                [PSCustomObject]@{
                    long_name  = 'PV2F+GX'
                    short_name = 'PV2F+GX'
                    types      = @(
                        'plus_code'
                    )
                }
                [PSCustomObject]@{
                    long_name  = 'New Braunfels'
                    short_name = 'New Braunfels'
                    types      = @(
                        'locality'
                        'political'
                    )
                }
                [PSCustomObject]@{
                    long_name  = 'Comal County'
                    short_name = 'Comal County'
                    types      = @(
                        'administrative_area_level_2'
                        'political'
                    )
                }
                [PSCustomObject]@{
                    long_name  = 'Texas'
                    short_name = 'TX'
                    types      = @(
                        'administrative_area_level_1'
                        'political'
                    )
                }
                [PSCustomObject]@{
                    long_name  = 'United States'
                    short_name = 'US'
                    types      = @(
                        'country'
                        'political'
                    )
                }
            )
            formatted_address  = 'PV2F+GX New Braunfels, TX, USA'
            geometry           = [PSCustomObject]@{
                bounds        = [PSCustomObject]@{
                    northeast = [PSCustomObject]@{
                        lat = '29.701375'
                        lng = '-98.125'
                    }
                    southwest = [PSCustomObject]@{
                        lat = '29.70125'
                        lng = '-98.125125'
                    }
                }
                location      = [PSCustomObject]@{
                    lat = '29.7012853'
                    lng = '-98.1250235'
                }
                location_type = 'ROOFTOP'
                viewport      = [PSCustomObject]@{
                    northeast = [PSCustomObject]@{
                        lat = '29.7026470302915'
                        lng = '-98.1236751197085'
                    }
                    southwest = [PSCustomObject]@{
                        lat = '29.6999490697085'
                        lng = '-98.1263730802915'
                    }
                }
            }
            place_id           = 'GhIJYqr0boezPUAR0O6QYgCIWMA'
            types              = @(
                'plus_code'
            )
        }
        [PSCustomObject]@{
            address_components = @(
                [PSCustomObject]@{
                    long_name  = '148'
                    short_name = '148'
                    types      = @(
                        'street_number'
                    )
                }
                [PSCustomObject]@{
                    long_name  = 'South Castell Avenue'
                    short_name = 'S Castell Ave'
                    types      = @(
                        'route'
                    )
                }
                [PSCustomObject]@{
                    long_name  = ''
                    short_name = ''
                    types      = @(

                    )
                }
                [PSCustomObject]@{
                    long_name  = 'New Braunfels'
                    short_name = 'New Braunfels'
                    types      = @(
                        'locality'
                        'political'
                    )
                }
                [PSCustomObject]@{
                    long_name  = 'Comal County'
                    short_name = 'Comal County'
                    types      = @(
                        'administrative_area_level_2'
                        'political'
                    )
                }
                [PSCustomObject]@{
                    long_name  = 'Texas'
                    short_name = 'TX'
                    types      = @(
                        'administrative_area_level_1'
                        'political'
                    )
                }
                [PSCustomObject]@{
                    long_name  = 'United States'
                    short_name = 'US'
                    types      = @(
                        'country'
                        'political'
                    )
                }
                [PSCustomObject]@{
                    long_name  = '78130'
                    short_name = '78130'
                    types      = @(
                        'postal_code'
                    )
                }
                [PSCustomObject]@{
                    long_name  = '5102'
                    short_name = '5102'
                    types      = @(
                        'postal_code_suffix'
                    )
                }
            )
            formatted_address  = '148 S Castell Ave, New Braunfels, TX 78130, USA'
            geometry           = [PSCustomObject]@{
                bounds        = [PSCustomObject]@{
                    northeast = [PSCustomObject]@{
                        lat = '29.7014997'
                        lng = '-98.1247988'
                    }
                    southwest = [PSCustomObject]@{
                        lat = '29.7010964'
                        lng = '-98.1252494'
                    }
                }
                location      = [PSCustomObject]@{
                    lat = '29.7012853'
                    lng = '-98.1250235'
                }
                location_type = 'ROOFTOP'
                viewport      = [PSCustomObject]@{
                    northeast = [PSCustomObject]@{
                        lat = '29.7026470302915'
                        lng = '-98.1236751197085'
                    }
                    southwest = [PSCustomObject]@{
                        lat = '29.6999490697085'
                        lng = '-98.1263730802915'
                    }
                }
            }
            place_id           = 'ChIJK34phme9XIYRqstHW_gHr2w'
            types              = @(
                'premise'
            )
        }
    )
    status    = 'OK'
}

$geoGMapPlaceID = [PSCustomObject]@{
    results = [PSCustomObject]@{
        address_components = @(
            [PSCustomObject]@{
                long_name  = '148'
                short_name = '148'
                types      = @(
                    'street_number'
                )
            }
            [PSCustomObject]@{
                long_name  = 'South Castell Avenue'
                short_name = 'S Castell Ave'
                types      = @(
                    'route'
                )
            }
            [PSCustomObject]@{
                long_name  = ''
                short_name = ''
                types      = @(

                )
            }
            [PSCustomObject]@{
                long_name  = 'New Braunfels'
                short_name = 'New Braunfels'
                types      = @(
                    'locality'
                    'political'
                )
            }
            [PSCustomObject]@{
                long_name  = 'Comal County'
                short_name = 'Comal County'
                types      = @(
                    'administrative_area_level_2'
                    'political'
                )
            }
            [PSCustomObject]@{
                long_name  = 'Texas'
                short_name = 'TX'
                types      = @(
                    'administrative_area_level_1'
                    'political'
                )
            }
            [PSCustomObject]@{
                long_name  = 'United States'
                short_name = 'US'
                types      = @(
                    'country'
                    'political'
                )
            }
            [PSCustomObject]@{
                long_name  = '78130'
                short_name = '78130'
                types      = @(
                    'postal_code'
                )
            }
            [PSCustomObject]@{
                long_name  = '5102'
                short_name = '5102'
                types      = @(
                    'postal_code_suffix'
                )
            }
        )
        formatted_address  = '148 S Castell Ave, New Braunfels, TX 78130, USA'
        geometry           = [PSCustomObject]@{
            bounds        = [PSCustomObject]@{
                northeast = [PSCustomObject]@{
                    lat = '29.7014997'
                    lng = '-98.1247988'
                }
                southwest = [PSCustomObject]@{
                    lat = '29.7010964'
                    lng = '-98.1252494'
                }
            }
            location      = [PSCustomObject]@{
                lat = '29.7012853'
                lng = '-98.1250235'
            }
            location_type = 'ROOFTOP'
            viewport      = [PSCustomObject]@{
                northeast = [PSCustomObject]@{
                    lat = '29.7026470302915'
                    lng = '-98.1236751197085'
                }
                southwest = [PSCustomObject]@{
                    lat = '29.6999490697085'
                    lng = '-98.1263730802915'
                }
            }
        }
        place_id           = 'ChIJK34phme9XIYRqstHW_gHr2w'
        types              = @(
            'premise'
        )
    }
    status  = 'OK'
}

#endregion

$nearbyGMap = [PSCustomObject]@{
    html_attributions = ''
    next_page_token   = 'toooooken'
    status            = 'OK'
    results           = @(
        [PSCustomObject]@{
            business_status       = 'OPERATIONAL'
            geometry              = [PSCustomObject]@{
                location = [PSCustomObject]@{
                    lat = '29.7013856'
                    lng = '-98.1249258'
                }
                viewport = [PSCustomObject]@{
                    northeast = [PSCustomObject]@{
                        lat = '29.7028062298927'
                        lng = '-98.1235759201073'
                    }
                    southwest = [PSCustomObject]@{
                        lat = '29.7001065701073'
                        lng = '-98.1262755798927'
                    }
                }
            }
            icon                  = 'https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/restaurant-71.png'
            icon_background_color = '#FF9E67'
            icon_mask_base_uri    = 'https://maps.gstatic.com/mapfiles/place_api/icons/v2/restaurant_pinlet'
            name                  = 'Krause''s Cafe'
            opening_hours         = [PSCustomObject]@{
                open_now = 'False'
            }
            place_id              = 'ChIJf9Yxhme9XIYRkXo-Bl62Q10'
            plus_code             = [PSCustomObject]@{
                compound_code = 'PV2G+H2 New Braunfels, Texas'
                global_code   = '76X3PV2G+H2'
            }
            price_level           = '2'
            rating                = '4.3'
            reference             = 'ChIJf9Yxhme9XIYRkXo-Bl62Q10'
            types                 = @(
                'bar'
                'restaurant'
                'food'
                'point_of_interest'
                'establishment'
            )
            user_ratings_total    = '3675'
            vicinity              = '148 South Castell Avenue, New Braunfels'
        } #obj
        [PSCustomObject]@{
            business_status       = 'OPERATIONAL'
            geometry              = [PSCustomObject]@{
                location = [PSCustomObject]@{
                    lat = '29.6980452'
                    lng = '-98.1297508'
                }
                viewport = [PSCustomObject]@{
                    northeast = [PSCustomObject]@{
                        lat = '29.6993595802915'
                        lng = '-98.1281500697085'
                    }
                    southwest = [PSCustomObject]@{
                        lat = '29.6966616197085'
                        lng = '-98.1308480302915'
                    }
                }
            }
            icon                  = 'https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/restaurant-71.png'
            icon_background_color = '#FF9E67'
            icon_mask_base_uri    = 'https://maps.gstatic.com/mapfiles/place_api/icons/v2/restaurant_pinlet'
            name                  = 'Granzin Bar-B-Q'
            opening_hours         = [PSCustomObject]@{
                open_now = 'False'
            }
            place_id              = 'ChIJ6VO3IWG9XIYRXWDr4zdiDro'
            plus_code             = [PSCustomObject]@{
                compound_code = 'MVXC+63 New Braunfels, TX, USA'
                global_code   = '76X3MVXC+63'
            }
            price_level           = '2'
            rating                = '4.3'
            reference             = 'ChIJ6VO3IWG9XIYRXWDr4zdiDro'
            types                 = @(
                'restaurant'
                'food'
                'point_of_interest'
                'establishment'
            )
            user_ratings_total    = '1260'
            vicinity              = '660 West San Antonio Street, New Braunfels'
        } #obj
    )
}

$textSearchGMap = [PSCustomObject]@{
    html_attributions = ''
    next_page_token   = 'toooooken'
    status            = 'OK'
    results           = @(
        [PSCustomObject]@{
            business_status       = 'OPERATIONAL'
            formatted_address     = '148 S Castell Ave, New Braunfels, TX 78130, United States'
            geometry              = [PSCustomObject]@{
                location = [PSCustomObject]@{
                    lat = '29.7013856'
                    lng = '-98.1249258'
                }
                viewport = [PSCustomObject]@{
                    northeast = [PSCustomObject]@{
                        lat = '29.7028062298927'
                        lng = '-98.1235759201073'
                    }
                    southwest = [PSCustomObject]@{
                        lat = '29.7001065701073'
                        lng = '-98.1262755798927'
                    }
                }
            }
            icon                  = 'https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/restaurant-71.png'
            icon_background_color = '#FF9E67'
            icon_mask_base_uri    = 'https://maps.gstatic.com/mapfiles/place_api/icons/v2/restaurant_pinlet'
            name                  = 'Krause''s Cafe'
            opening_hours         = [PSCustomObject]@{
                open_now = 'False'
            }
            place_id              = 'ChIJf9Yxhme9XIYRkXo-Bl62Q10'
            plus_code             = [PSCustomObject]@{
                compound_code = 'PV2G+H2 New Braunfels, Texas'
                global_code   = '76X3PV2G+H2'
            }
            price_level           = '2'
            rating                = '4.3'
            reference             = 'ChIJf9Yxhme9XIYRkXo-Bl62Q10'
            types                 = @(
                'bar'
                'restaurant'
                'food'
                'point_of_interest'
                'establishment'
            )
            user_ratings_total    = '3675'
        } #obj
        [PSCustomObject]@{
            business_status       = 'OPERATIONAL'
            formatted_address     = '1644 McQueeney Rd, New Braunfels, TX 78130, United States'
            geometry              = [PSCustomObject]@{
                location = [PSCustomObject]@{
                    lat = '29.6877297'
                    lng = '-98.115463'
                }
                viewport = [PSCustomObject]@{
                    northeast = [PSCustomObject]@{
                        lat = '29.6892016298927'
                        lng = '-98.1141575701073'
                    }
                    southwest = [PSCustomObject]@{
                        lat = '29.6865019701073'
                        lng = '-98.1168572298927'
                    }
                }
            }
            icon                  = 'https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/restaurant-71.png'
            icon_background_color = '#4B96F3'
            icon_mask_base_uri    = 'https://maps.gstatic.com/mapfiles/place_api/icons/v2/shopping_pinlet'
            name                  = "Granzin's Meat Market"
            opening_hours         = [PSCustomObject]@{
                open_now = 'False'
            }
            place_id              = 'ChIJE43gTHK9XIYRleSxiXqF6GU'
            plus_code             = [PSCustomObject]@{
                compound_code = 'MVQM+3R New Braunfels, Texas'
                global_code   = '76X3MVQM+3R'
            }
            rating                = '4.8'
            reference             = 'ChIJE43gTHK9XIYRleSxiXqF6GU'
            types                 = @(
                'grocery_or_supermarket'
                'liquor_store'
                'food'
                'point_of_interest'
                'store'
                'establishment'
            )
            user_ratings_total    = '793'
        } #obj
    )
}

$placeDetailsGMap = [PSCustomObject]@{
    html_attributions = ''
    result            = [PSCustomObject]@{
        address_components     = @(
            [PSCustomObject]@{
                long_name  = '148'
                short_name = '148'
                types      = @(
                    'street_number'
                )
            }
            [PSCustomObject]@{
                long_name  = 'S Castell Ave'
                short_name = '148'
                types      = @(
                    'route'
                )
            }
            [PSCustomObject]@{
                long_name  = 'New Braunfels'
                short_name = 'New Braunfels'
                types      = @(
                    'locality'
                    'political'
                )
            }
            [PSCustomObject]@{
                long_name  = 'Comal County'
                short_name = 'Comal County'
                types      = @(
                    'administrative_area_level_2'
                    'political'
                )
            }
            [PSCustomObject]@{
                long_name  = 'Texas'
                short_name = 'TX'
                types      = @(
                    'administrative_area_level_1'
                    'political'
                )
            }
            [PSCustomObject]@{
                long_name  = 'United States'
                short_name = 'US'
                types      = @(
                    'country'
                    'political'
                )
            }
            [PSCustomObject]@{
                long_name  = '78130'
                short_name = '78130'
                types      = @(
                    'postal_code'
                )
            }
            [PSCustomObject]@{
                long_name  = '5102'
                short_name = '5102'
                types      = @(
                    'postal_code_suffix'
                )
            }
        )
        business_status        = 'OPERATIONAL'
        formatted_address      = '148 S Castell Ave, New Braunfels, TX 78130, United States'
        formatted_phone_number = '(830) 625-2807'
        geometry               = [PSCustomObject]@{
            location = [PSCustomObject]@{
                lat = '29.7013856'
                lng = '-98.1249258'
            }
            viewport = [PSCustomObject]@{
                northeast = [PSCustomObject]@{
                    lat = '29.7028062298927'
                    lng = '-98.1235759201073'
                }
                southwest = [PSCustomObject]@{
                    lat = '29.7001065701073'
                    lng = '-98.1262755798927'
                }
            }
        }
        icon                   = 'https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/restaurant-71.png'
        icon_background_color  = '#FF9E67'
        icon_mask_base_uri     = 'https://maps.gstatic.com/mapfiles/place_api/icons/v2/restaurant_pinlet'
        name                   = 'Krause''s Cafe'
        opening_hours          = [PSCustomObject]@{
            open_now     = 'False'
            periods      = [PSCustomObject]@{
                open  = @(
                    [PSCustomObject]@{
                        day  = 0
                        time = 0730
                    }
                    [PSCustomObject]@{
                        day  = 1
                        time = 0730
                    }
                    [PSCustomObject]@{
                        day  = 2
                        time = 0730
                    }
                    [PSCustomObject]@{
                        day  = 3
                        time = 0730
                    }
                    [PSCustomObject]@{
                        day  = 4
                        time = 0730
                    }
                    [PSCustomObject]@{
                        day  = 5
                        time = 0730
                    }
                    [PSCustomObject]@{
                        day  = 6
                        time = 0730
                    }
                )
                close = @(
                    [PSCustomObject]@{
                        day  = 0
                        time = 2200
                    }
                    [PSCustomObject]@{
                        day  = 1
                        time = 2200
                    }
                    [PSCustomObject]@{
                        day  = 2
                        time = 2200
                    }
                    [PSCustomObject]@{
                        day  = 3
                        time = 2200
                    }
                    [PSCustomObject]@{
                        day  = 4
                        time = 2200
                    }
                    [PSCustomObject]@{
                        day  = 5
                        time = 2300
                    }
                    [PSCustomObject]@{
                        day  = 6
                        time = 2300
                    }
                )
            }
            weekday_text = @(
                'Monday: 7:30 AM – 10:00 PM'
                'Tuesday: 7:30 AM – 10:00 PM'
                'Wednesday: 7:30 AM – 10:00 PM'
                'Thursday: 7:30 AM – 10:00 PM'
                'Friday: 7:30 AM – 11:00 PM'
                'Saturday: 7:30 AM – 11:00 PM'
                'Sunday: 7:30 AM – 10:00 PM'
            )
        }
        place_id               = 'ChIJf9Yxhme9XIYRkXo-Bl62Q10'
        plus_code              = [PSCustomObject]@{
            compound_code = 'PV2G+H2 New Braunfels, Texas'
            global_code   = '76X3PV2G+H2'
        }
        price_level            = '2'
        rating                 = '4.3'
        reviews                = @(
            [PSCustomObject]@{
                author_name               = 'Andrea Mara'
                author_url                = 'https://www.google.com/maps/contrib/106805061694773377686/reviews'
                language                  = 'en'
                profile_photo_url         = 'https://lh3.googleusercontent.com/a-/AOh14Gg9C60vdW30CJmsLgpaXtLNC0-OF0eSSRCkNseqK60=s128-c0x00000000-cc-rp-mo-ba3'
                rating                    = '4'
                relative_time_description = '2 weeks ago'
                text                      = 'We went there for the first time and we were so happy we found it.
                                            This restaurant has a huge outside beer garden and inside restaurant.
                                            My husband had the Reuben sandwich with German potato salad and I had
                                            their cheeseburger with homemade chips.  I had not tasted such great
                                            beef since we used to raise our own beef.  The meat was so tasty and
                                            moist.   Both of us only ate half our sandwiches as we had a huge
                                            pretzel for an appetizer.  We will be going back.'
                time                      = '1631827922'
            }
        )
        types                  = @(
            'bar'
            'restaurant'
            'food'
            'point_of_interest'
            'establishment'
        )
        url                    = 'https://maps.google.com/?cid=6720415583914850961'
        user_ratings_total     = 3697
        utc_offset             = '-300'
        vicinity               = '148 South Castell Avenue, New Braunfels'
        website                = 'https://www.krausescafe.com/'
    }
    status            = 'OK'
}

#endregion

#region BingMap

#region GeoCode

$geoBingAddress = [PSCustomObject]@{
    authenticationResultCode = 'ValidCredentials'
    brandLogoUri             = 'http://dev.virtualearth.net/Branding/logo_powered_by.png'
    copyright                = 'Copyright © 2021 Microsoft and its suppliers. All rights reserved. This API
                                cannot be accessed and the content and any results may not be used, reproduced
                                or transmitted in any manner without express written permission from Microsoft
                                Corporation.'
    resourceSets             = [PSCustomObject]@{
        estimatedTotal = 1
        resources      = [PSCustomObject]@{
            '__type'      = 'Location:http://schemas.microsoft.com/search/local/ws/rest/v1'
            bbox          = @(
                '29.6974302824293',
                '-98.1309490484719',
                '29.7051557175707',
                '-98.1190909515281'
            )
            name          = '148 S Castell Ave, New Braunfels, TX 78130'
            point         = [PSCustomObject]@{
                type        = 'Point'
                coordinates = @(
                    29.701293
                    -98.12502
                )
            }
            address       = [PSCustomObject]@{
                addressLine      = '148 S Castell Ave'
                adminDistrict    = 'TX'
                adminDistrict2   = 'Comal County'
                countryRegion    = 'United States'
                formattedAddress = '148 S Castell Ave, New Braunfels, TX 78130'
                locality         = 'New Braunfels'
                postalCode       = '78130'
            }
            confidence    = 'High'
            entityType    = 'Address'
            geocodePoints = @(
                [PSCustomObject]@{
                    type              = 'Point'
                    coordinates       = @(
                        29.701293
                        -98.12502
                    )
                    calculationMethod = 'Rooftop'
                    usageTypes        = @(
                        'Display'
                    )
                }
                [PSCustomObject]@{
                    type              = 'Point'
                    coordinates       = @(
                        29.7015261
                        -98.124818
                    )
                    calculationMethod = 'Rooftop'
                    usageTypes        = @(
                        'Route'
                    )
                }
            )
            matchCodes    = @(
                'Good'
            )
        }
    }
    statusCode               = '200'
    statusDescription        = 'OK'
    traceId                  = 'xxxxxxxxxxxxxxxxx|XXXXXXX|0.0.0.1|Ref A:XXXXXXXXXXXXX Ref B: XXXXXXXXX Ref C: 2021-10-06T03:08:54Z'
}

#endregion

$findBingPlace = [PSCustomObject]@{
    authenticationResultCode = 'ValidCredentials'
    brandLogoUri             = 'http://dev.virtualearth.net/Branding/logo_powered_by.png'
    copyright                = 'Copyright © 2021 Microsoft and its suppliers. All rights reserved. This API
                                cannot be accessed and the content and any results may not be used, reproduced
                                or transmitted in any manner without express written permission from Microsoft
                                Corporation.'
    resourceSets             = [PSCustomObject]@{
        estimatedTotal = 1
        resources      = [PSCustomObject]@{
            '__type'      = 'Location:http://schemas.microsoft.com/search/local/ws/rest/v1'
            name          = "Krause's Cafe"
            point         = [PSCustomObject]@{
                type        = 'Point'
                coordinates = @(
                    29.7015113830566
                    -98.1247940063477
                )
            }
            address       = [PSCustomObject]@{
                addressLine      = '148 S Castell Ave'
                adminDistrict    = 'TX'
                countryRegion    = 'US'
                formattedAddress = '148 S Castell Ave, New Braunfels, TX, 78130'
                locality         = 'New Braunfels'
                postalCode       = '78130'
            }
            PhoneNumber   = '(830) 625-2807'
            Website       = 'https://www.krausescafe.com/'
            entityType    = 'Restaurant'
            geocodePoints = @(
                [PSCustomObject]@{
                    type              = 'Point'
                    coordinates       = @(
                        29.7013301849365
                        -98.1249465942383
                    )
                    calculationMethod = 'Rooftop'
                    usageTypes        = @(
                        'Display'
                    )
                }
            )
        }
    }
    statusCode               = '200'
    statusDescription        = 'OK'
    traceId                  = 'xxxxxxxxxxxxxxxxx|XXXXXXX|0.0.0.1|Ref A:XXXXXXXXXXXXX Ref B: XXXXXXXXX Ref C: 2021-10-06T03:08:54Z'
}

#endregion

Export-ModuleMember -Variable '*'
