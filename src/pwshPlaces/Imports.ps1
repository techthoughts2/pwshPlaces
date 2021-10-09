# This is a locally sourced Imports file for local development.
# It can be imported by the psm1 in local development to add script level variables.
# It will merged in the build process. This is for local development only.

#region script variables
# $script:resourcePath = "$PSScriptRoot\Resources"

#------------------------------------------------------------
# ! API KEYS
#$env:GoogleAPIKey = ''
#$env:BingAPIKey = ''
#------------------------------------------------------------

$script:googleMapsBaseURI = 'https://maps.googleapis.com/maps/api/'
$script:bingMapsBaseURI = 'https://dev.virtualearth.net/REST/'

#endregion

#region parameter enums

enum ccTLD {
    ac #Ascension Island
    ad #Andorra
    ae #United Arab Emirate
    af #Afghanistan
    ag #Antigua and Barbuda
    ai #Anguilla
    al #Albania
    am #Armenia
    ao #Angola
    aq #Antarctica
    ar #Argentina
    as #American Samoa
    at #Austria
    au #Australia
    aw #Aruba
    ax #Åland Islands
    az #Azerbaijan
    ba #Bosnia and Herzegov
    bb #Barbados
    bd #Bangladesh
    be #Belgium
    bf #Burkina Faso
    bg #Bulgaria
    bh #Bahrain
    bi #Burundi
    bj #Benin
    bm #Bermuda
    bn #Brunei
    bo #Bolivia
    br #Brazil
    bs #Bahamas
    bt #Bhutan
    bv #Bouvet Island
    bw #Botswana
    by #Belarus
    bz #Belize
    ca #Canada
    cc #Cocos (Keeling) Isl
    cd #Democratic Republic
    cf #Central African Rep
    cg #Republic of the Con
    ch #Switzerland
    ci #Ivory Coast
    ck #Cook Islands
    cl #Chile
    cm #Cameroon
    cn #China
    co #Colombia
    cr #Costa Rica
    cu #Cuba
    cv #Cape Verde
    cw #Curaçao
    cx #Christmas Island
    cy #Cyprus
    cz #Czech Republic
    de #Germany
    dj #Djibouti
    dk #Denmark
    dm #Dominica
    do #Dominican Republic
    dz #Algeria
    ec #Ecuador
    ee #Estonia
    eg #Egypt
    er #Eritrea
    es #Spain
    et #Ethiopia
    eu #European Union
    fi #Finland
    fj #Fiji
    fk #Falkland Islands
    fm #Micronesia
    fo #Faroe Islands
    fr #France
    ga #Gabon
    gb #United Kingdom
    gd #Grenada
    ge #Georgia
    gf #French Guiana
    gg #Guernsey
    gh #Ghana
    gi #Gibraltar
    gl #Greenland
    gm #Gambia
    gn #Guinea
    gp #Guadeloupe
    gq #Equatorial Guinea
    gr #Greece
    gs #South Georgia
    gt #Guatemala
    gu #Guam
    gw #Guinea-Bissau
    gy #Guyana
    hk #Hong Kong
    hm #Heard Island and Mc
    hn #Honduras
    hr #Croatia
    ht #Haiti
    hu #Hungary
    id #Indonesia
    ie #Ireland
    il #Israel
    im #Isle of Man
    in #India
    io #British Indian Ocea
    iq #Iraq
    ir #Iran
    is #Iceland
    it #Italy
    je #Jersey
    jm #Jamaica
    jo #Jordan
    jp #Japan
    ke #Kenya
    kg #Kyrgyzstan
    kh #Cambodia
    ki #Kiribati
    km #Comoros
    kn #Saint Kitts and Nev
    kp #North Korea
    kr #South Korea
    kw #Kuwait
    ky #Cayman Islands
    kz #Kazakhstan
    la #Laos
    lb #Lebanon
    lc #Saint Lucia
    li #Liechtenstein
    lk #Sri Lanka
    lr #Liberia
    ls #Lesotho
    lt #Lithuania
    lu #Luxembourg
    lv #Latvia
    ly #Libya
    ma #Morocco
    mc #Monaco
    md #Moldova
    me #Montenegro
    mg #Madagascar
    mh #Marshall Islands
    mk #North Macedonia
    ml #Mali
    mm #Myanmar
    mn #Mongolia
    mo #Macao
    mp #Northern Mariana Is
    mq #Martinique
    mr #Mauritania
    ms #Montserrat
    mt #Malta
    mu #Mauritius
    mv #Maldives
    mw #Malawi
    mx #Mexico
    my #Malaysia
    mz #Mozambique
    na #Namibia
    nc #New Caledonia
    ne #Niger
    nf #Norfolk Island
    ng #Nigeria
    ni #Nicaragua
    nl #Netherlands
    no #Norway
    np #Nepal
    nr #Nauru
    nu #Niue
    nz #New Zealand
    om #Oman
    pa #Panama
    pe #Peru
    pf #French Polynesia
    pg #Papua New Guinea
    ph #Philippines
    pk #Pakistan
    pl #Poland
    pm #Saint Pierre and Mi
    pn #Pitcairn Islands
    pr #Puerto Rico
    ps #Palestine
    pt #Portugal
    pw #Palau
    py #Paraguay
    qa #Qatar
    re #Réunion
    ro #Romania
    rs #Serbia
    ru #Russia
    rw #Rwanda
    sa #Saudi Arabia
    sb #Solomon Islands
    sc #Seychelles
    sd #Sudan
    se #Sweden
    sg #Singapore
    sh #Saint Helena
    si #Slovenia
    sj #Svalbard and Jan Ma
    sk #Slovakia
    sl #Sierra Leone
    sm #San Marino
    sn #Senegal
    so #Somalia
    sr #Suriname
    ss #South Sudan
    st #Sao Tome and Princi
    su #Soviet Union
    sv #El Salvador
    sx #Sint Maarten
    sy #Syria
    sz #Eswatini
    tc #Turks and Caicos Is
    td #Chad
    tf #French Southern Ter
    tg #Togo
    th #Thailand
    tj #Tajikistan
    tk #Tokelau
    tl #East Timor
    tm #Turkmenistan
    tn #Tunisia
    to #Tonga
    tr #Turkey
    tt #Trinidad and Tobago
    tv #Tuvalu
    tw #Taiwan
    tz #Tanzania
    ua #Ukraine
    ug #Uganda
    uk #United Kingdom
    us #United States
    uy #Uruguay
    uz #Uzbekistan
    va #Vatican
    vc #Saint Vincent and t
    ve #Venezuela
    vg #British Virgin Isla
    vi #U.S. Virgin Islands
    vn #Vietnam
    vu #Vanuatu
    wf #Wallis and Futuna
    ws #Samoa
    ye #Yemen
    yt #Mayotte
    za #South Africa
    zm #Zambia
    zw #Zimbabwe
} #enum_ccTLD

#region GMaps enums

# https://developers.google.com/maps/faq#languagesupport
enum languages {
    af      #Afrikaans
    sq      #Albanian
    am      #Amharic
    ar      #Arabic
    hy      #Armenian
    az      #Azerbaijani
    eu      #Basque
    be      #Belarusian
    bn      #Bengali
    bs      #Bosnian
    bg      #Bulgarian
    my      #Burmese
    ca      #Catalan
    zh      #Chinese
    # zh-CN   #Chinese (Simplified)
    # zh-HK   #Chinese (Hong Kong)
    # zh-TW   #Chinese (Traditional)
    hr      #Croatian
    cs      #Czech
    da      #Danish
    nl      #Dutch
    en      #English
    # en-AU   #English (Australian)
    # en-GB   #English (Great Britain)
    et      #Estonian
    fa      #Farsi
    fi      #Finnish
    fil     #Filipino
    fr      #French
    # fr-CA   #French (Canada)
    ka      #Georgian
    de      #German
    el      #Greek
    iw      #Hebrew
    hi      #Hindi
    hu      #Hungarian
    is      #Icelandic
    id      #Indonesian
    it      #Italian
    ja      #Japanese
    kn      #Kannada
    kk      #Kazakh
    km      #Khmer
    ko      #Korean
    ky      #Kyrgyz
    lo      #Lao
    lv      #Latvian
    lt      #Lithuanian
    mk      #Macedonian
    ms      #Malay
    ml      #Malayalam
    mr      #Marathi
    mn      #Mongolian
    ne      #Nepali
    no      #Norwegian
    pl      #Polish
    pt      #Portuguese
    # pt-BR   #Portuguese (Brazil)
    # pt-PT   #Portuguese (Portugal)
    pa      #Punjabi
    ro      #Romanian
    ru      #Russian
    sr      #Serbian
    # si      #Sinhalese
    sk      #Slovak
    # sl      #Slovenian
    es      #Spanish
    # es-419  #Spanish (Latin America)
    sw      #Swahili
    ta      #Tamil
    te      #Telugu
    th      #Thai
    uk      #Ukrainian
    ur      #Urdu
    uz      #Uzbek
    vi      #Vietnamese
    zu      #Zulu
} #enum_languages

# https://developers.google.com/maps/documentation/places/web-service/supported_types#table1
enum placeTypes {
    accounting
    airport
    amusement_park
    aquarium
    art_gallery
    atm
    bakery
    bank
    bar
    beauty_salon
    bicycle_store
    book_store
    bowling_alley
    bus_station
    cafe
    campground
    car_dealer
    car_rental
    car_repair
    car_wash
    casino
    cemetery
    church
    city_hall
    clothing_store
    convenience_store
    courthouse
    dentist
    department_store
    doctor
    drugstore
    electrician
    electronics_store
    embassy
    fire_station
    florist
    funeral_home
    furniture_store
    gas_station
    gym
    hair_care
    hardware_store
    hindu_temple
    home_goods_store
    hospital
    insurance_agency
    jewelry_store
    laundry
    lawyer
    library
    light_rail_station
    liquor_store
    local_government_office
    locksmith
    lodging
    meal_delivery
    meal_takeaway
    mosque
    movie_rental
    movie_theater
    moving_company
    museum
    night_club
    painter
    park
    parking
    pet_store
    pharmacy
    physiotherapist
    plumber
    police
    post_office
    primary_school
    real_estate_agency
    restaurant
    roofing_contractor
    rv_park
    school
    secondary_school
    shoe_store
    shopping_mall
    spa
    stadium
    storage
    store
    subway_station
    supermarket
    synagogue
    taxi_stand
    tourist_attraction
    train_station
    transit_station
    travel_agency
    university
    veterinary_care
    zoo
} #enum_placeTypes

#endregion

#region bing enums

enum cultureCodes {
    af              #Afrikaans
    am              #Amharic
    #ar-sa           #Arabic (Saudi Arabia)
    as              #Assamese
    #az-Latn         #Azerbaijani (Latin)
    be              #Belarusian
    bg              #Bulgarian
    #bn-BD           #Bangla (Bangladesh)
    #bn-IN           #Bangla (India)
    bs              #Bosnian (Latin)
    ca              #Catalan Spanish
    #ca-ES-valencia  #Valencian
    cs              #Czech
    cy              #Welsh
    da              #Danish
    de              #German (Germany)
    #de-de           #German (Germany)**
    el              #Greek
    #en-GB           #English (United Kingdom)
    #en-US           #English (United States)**
    es              #Spanish (Spain)
    #es-ES           #Spanish (Spain)**
    #es-US           #Spanish (United States)1
    #es-MX           #Spanish (Mexico)1
    et              #Estonian
    eu              #Basque
    fa              #Persian
    fi              #Finnish
    #fil-Latn        #Filipino
    fr              #French (France)
    #fr-FR           #French (France)**
    #fr-CA           #French (Canada)2
    ga              #Irish
    #gd-Latn         #Scottish Gaelic
    #gl              #Galician
    #gu              #Gujarati
    #ha-Latn         #Hausa (Latin)
    he              #Hebrew
    hi              #Hindi
    hr              #Croatian
    hu              #Hungarian
    hy              #Armenian
    id              #Indonesian
    #ig-Latn         #Igbo
    is              #Icelandic
    it              #Italian (Italy)
    #it-it           #Italian (Italy)**
    ja              #Japanese
    ka              #Georgian
    kk              #Kazakh
    km              #Khmer
    kn              #Kannada
    ko              #Korean
    kok             #Konkani
    #ku-Arab         #Central Kurdish
    #ky-Cyrl         #Kyrgyz
    lb              #Luxembourgish
    lt              #Lithuanian
    lv              #Latvian
    #mi-Latn         #Maori
    mk              #Macedonian
    ml              #Malayalam
    #mn-Cyrl         #Mongolian (Cyrillic)
    mr              #Marathi
    ms              #Malay (Malaysia)
    mt              #Maltese
    nb              #Norwegian (Bokmål)
    ne              #Nepali (Nepal)
    nl              #Dutch (Netherlands)
    #nl-BE           #Dutch (Netherlands)**
    nn              #Norwegian (Nynorsk)
    nso             #Sesotho sa Leboa
    or              #Odia
    pa              #Punjabi (Gurmukhi)
    #pa-Arab         #Punjabi (Arabic)
    pl              #Polish
    #prs-Arab        #Dari
    #pt-BR           #Portuguese (Brazil)
    #pt-PT           #Portuguese (Portugal)
    #qut-Latn        #K’iche’
    quz             #Quechua (Peru)
    ro              #Romanian (Romania)
    ru              #Russian
    rw              #Kinyarwanda
    #sd-Arab         #Sindhi (Arabic)
    #si              #Sinhala
    sk              #Slovak
    #sl              #Slovenian
    sq              #Albanian
    #sr-Cyrl-BA      #Serbian (Cyrillic, Bosnia and Herzegovina)
    #sr-Cyrl-RS      #Serbian (Cyrillic, Serbia)
    #sr-Latn-RS      #Serbian (Latin, Serbia)
    #sv              #Swedish (Sweden)
    sw              #Kiswahili
    ta              #Tamil
    te              #Telugu
    #tg-Cyrl         #Tajik (Cyrillic)
    th              #Thai
    ti              #Tigrinya
    #tk-Latn         #Turkmen (Latin)
    tn              #Setswana
    tr              #Turkish
    #tt-Cyrl         #Tatar (Cyrillic)
    #ug-Arab         #Uyghur
    uk              #Ukrainian
    ur              #Urdu
    #uz-Latn         #Uzbek (Latin)
    vi              #Vietnamese
    wo              #Wolof
    xh              #isiXhosa
    #yo-Latn         #Yoruba
    #zh-Hans         #Chinese (Simplified)
    #zh-Hant         #Chinese (Traditional)
    zu              #isiZulu
} #enum_cultureCodes

enum typeIdentifier {
    AmusementParks                  # Amusement parks.
    AntiqueStores                   # For retail stores that sell antiques.
    Attractions                     # Miscellaneous attractions that don't belong to another type.
    BanksAndCreditUnions
    Bars                            # For establishments that serve primarily alcoholic drinks such as beer, wine, liquor, and cocktails for consumption by the patrons on certain premises.
    BarsGrillsAndPubs               # A casual restaurant that serves substantial amount of food and alcoholic beverages on the menu.
    BelgianRestaurants              # Restaurants that primarily serve cuisine from Belgium.
    Bookstores                      # For retail stores that primarily sell books, and may also include newspapers, magazines, maps.
    BreweriesAndBrewPubs            # For businesses or entities which brew and process beer on the premises, typically also serving their products in-house to the public.
    BritishRestaurants              # A restaurant that primarily serves cuisine from the British cultural traditions, including English, Welsh, Cornish and Scottish.
    BuffetRestaurants               # A restaurant where food is presented buffet-style and patrons can serve themselves.
    CDAndRecordStores               # Includes music stores that primarily sell music via CDs, Records, Albums, Cassette Tapes. May also sell music accessories for those devices.
    CafeRestaurants                 # This casual eating and drinking place offers significant food options, prepared to order, and seating at the premise.
    CaribbeanRestaurants            # A restaurant that primarily serves cuisine from the Caribbean traditions.
    Carnivals                       # Carnival attractions.
    Casinos                         # Casinos and other gambling establishments.
    ChildrensClothingStores         # For retail stores that primarily sell clothing for children (including infants).
    ChineseRestaurants              # A restaurant that primarily serves cuisine from the Chinese cultural traditions.
    CigarAndTobaccoShops            # For retail stores that sell tobacco and tobacco accessories.
    CocktailLounges                 # For bars whose focus is serving and selling alcoholic mixed drinks.
    CoffeeAndTea                    # For establishments that primarily serve coffee and/or tea.
    ComicBookStores                 # For retail stores that focus sales on comic books, comic magazines, and other comic accessories.
    Delicatessens                   # In the United States, a delicatessen store, or deli, is a type of business that is both a grocery store and serves food.
    DeliveryService                 # This type includes business which offer the option to deliver prepared dishes to different locations like home or work.
    DepartmentStores                # For retailers that primarily sell a wide range of consumer goods such as clothing, housewares, furniture and appliances, toys, cosmetics.
    Diners                          # Diners are characterized by offering a wide range of foods, mostly American, a casual atmosphere, a counter, and late operating hours.
    DiscountStores                  # For retail stores that primarily sell products at lower prices than standard retail stores. Discount stores may or may not have various departments offering a wide variety of goods.
    Donuts                          # For places that primarily serve donuts.
    FastFood                        # For businesses characterized by their quickness, cheap food, and minimal service.
    FleaMarketsAndBazaars           # Where individuals are able to rent a space to display and sell their goods that are usually used/old at a lower price.
    FrenchRestaurants               # A restaurant that primarily serves cuisine from the French cultural traditions.
    FrozenYogurt                    # For entities that primarily serve frozen yogurt such as FroYo and Frogurt.
    FurnitureStores                 # For retail stores that sell objects (whether new or used) intended to support various human activities such as sitting and sleeping.
    GermanRestaurants               # Restaurants that primarily serve cuisine from Germany.
    GreekRestaurants                # Restaurants that primarily serve cuisine from the Greek cultural traditions.
    Grocers                         # Retail entities that provide food products to consumers, including corner stores.
    Grocery                         # Retail entities that provide food products to consumers.
    HawaiianRestaurants             # A restaurant that primarily serves cuisine from Hawaiian traditions.
    HomeImprovementStores           # For retail stores that primarily sell hardware for home improvements such as power tools, electrical supplies and other related items.
    Hospitals
    HotelsAndMotels
    HungarianRestaurants            # Restaurants that primarily serve food from Hungarian cuisine.
    IceCreamAndFrozenDesserts       # For businesses that primarily serve ice cream and other frozen desserts, like cheese cake.
    IndianRestaurants               # Restaurants that primarily serve cuisine from Indian cultural traditions.
    ItalianRestaurants              # Restaurants that primarily serve cuisine from Italian cultural traditions.
    JapaneseRestaurants             # Restaurants that primarily serve cuisine from Japanese cultural traditions.
    JewelryAndWatchesStores         # For retail stores which sell jewelry and watches, as well as business that purchase gold and silver from the buyer ("cash for gold").
    Juices                          # For businesses offering juices and smoothies.
    KitchenwareStores               # For retail stores that primarily sell tableware, cookware and bakeware.
    KoreanRestaurants               # Restaurants that primarily serve cuisine from Korean cultural traditions.
    LandmarksAndHistoricalSites     # Man-made landmarks and historical sites.
    LiquorStores                    # For retail stores that primarily sell liquor, wine, beer and spirits.
    MallsAndShoppingCenters         # For large complexes with various retail shops and interconnecting walkways allowing shoppers to have a complete shopping experience.
    MensClothingStores              # For retail stores that primarily sell clothing specifically designed for men to wear
    MexicanRestaurants              # Restaurants that primarily serve cuisine from Mexican cultural traditions.
    MiddleEasternRestaurants        # Restaurants that primarily serve cuisine from Middle Eastern cultural traditions.
    MiniatureGolfCourses            # Miniature golf courses.
    MovieTheaters                   # Movie theaters and houses.
    Museums                         # Museums and art galleries.
    MusicStores                     # For retail shops which sell music related equipment or offer music related services.
    OutletStores                    # For retail shops which sell music related equipment or offer music related services.
    Parking
    Parks                           # Natural parks and gardens.
    PetShops                        # for retail stores that primarily sell pets.
    PetSupplyStores                 # For retail stores that primarily sell pet supplies.
    Pizza                           # Restaurants that primarily serve pizza, including pizza deliveries.
    PolishRestaurants               # Restaurants that primarily serve cuisine from Polish cultural traditions.
    PortugueseRestaurants           # Restaurants that primarily serve cuisine from Portuguese cultural traditions.
    Pretzels                        # For businesses, places, kiosks, stands, or carts that primarily sell pretzels.
    Restaurants                     # Business entities with the primary purpose of serving prepared-to-order food to the public.
    RussianAndUkrainianRestaurants  # Restaurants that primarily serve cuisine from Russian and/or Ukrainian cultural traditions.
    Sandwiches                      # Restaurants that primarily serve sandwiches.
    SchoolAndOfficeSupplyStores     # Includes all office-related products. Pens, pencils, whiteboard markers, binders, mailing/shipping supplies, and basic office machines (fax, media projectors, etc.). Also includes retail-specific supplies, like shopping bags, signs, and cash handling products. All forms and types of calendars, breakroom and office cleaning supplies, and in-person meeting supplies.
    SeafoodRestaurants              # A restaurant that primarily serves seafood, including freshwater fish.
    ShoeStores                      # For retail stores that primarily sell footwear.
    SightseeingTours                # Sight-seeing tours.
    SpanishRestaurants              # Restaurants that primarily serve cuisine from Spanish cultural traditions.
    SportingGoodsStores             # For retail stores that primarily sell sport and fitness equipment.
    SportsBars                      # Bars with a primary focus on viewing live sporting and entertainment events.
    SteakHouseRestaurants           # Restaurants that primarily serve beef steaks.
    Supermarkets                    # Large, warehouse-like retail entities that provide food products to consumers.
    SushiRestaurants                # Restaurants that primarily service sushi, including both cooked and raw seafood.
    TakeAway                        # A food establishment that offers the option to purchase prepared dishes for the purpose of being eaten elsewhere.
    Taverns                         # Similar to bars, but with additional seating; typically these are businesses which were once residences.
    ThaiRestaurants                 # Restaurants that primarily serve cuisine from Thai cultural traditions.
    TouristInformation              # Tourist information booths and visitor centers.
    ToyAndGameStores                # For retail stores that primarily sell toys and games for all ages, including electronic toys, and educational game systems.
    TurkishRestaurants              # Restaurants that primarily serve cuisine from Turkish cultural traditions.
    VegetarianAndVeganRestaurants   # Restaurant that primarily serve vegetarian and/or vegan cuisine.
    VietnameseRestaurants           # Restaurants that primarily serve cuisine from Vietnamese cultural traditions.
    VitaminAndSupplementStores      # For retail stores that primarily sell vitamins and supplements.
    WomensClothingStores            # For retail stores that primarily sell women's clothing.
    Zoos                            # Zoos and aquariums.
} #enum_typeIdentifier

#endregion

#endregion
