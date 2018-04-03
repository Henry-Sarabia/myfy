module Views.Landing exposing (root)

import Html exposing (Html, div, text, h1, h2, nav, section, span, a, p)
import Html.Attributes exposing (class, style, alt)
import Html.Events exposing (onClick)
import Models exposing (Model, Login)
import Msgs exposing (Msg(..))
import RemoteData exposing (WebData)
import Views.Common exposing (..)

 
root : Model -> Html Msg
root model =
    div 
        []
        [ heroImage model
        , heroFeatures
        ]


heroImage : Model -> Html Msg
heroImage model =
    section
        [ class "hero is-large"
        , style 
            [ ("background-image", "linear-gradient(rgba(0, 0, 0, 0.25), rgba(0, 0, 0, 0.25)), url(herobg2.jpg)")
            , ("background-position", "center")
            , ("background-repeat", "no-repeat")
            , ("background-size", "cover")
            ]
        ]
        [ heroImageBody model ]


heroImageBody : Model -> Html Msg
heroImageBody model =
    div
        [ class "hero-body" ]
        [ div
            [ class "container has-text-centered" ]
            [ titleText "Discover your MyFy experience today"
            , subtitleText "Analyze your Spotify data to create personalized summary and instant Discover playlists"
            , spotifyButton model.login
            ]
        ]


titleText : String -> Html Msg
titleText title =
    h1 
        [ class "title is-1 is-spaced has-text-light" ]
        [ text title ]


subtitleText : String -> Html Msg 
subtitleText sub = 
    h2
        [ class "subtitle is-3 has-text-light" ]
        [ text sub ] 


spotifyButton : WebData Login -> Html Msg
spotifyButton login  =
    case login of
        RemoteData.NotAsked ->
            baseSpotifyButton ForceFetchLogin

        RemoteData.Loading ->
            baseSpotifyButton ForceFetchLogin

        RemoteData.Success response ->
            baseSpotifyButton (LoadLogin response.url)

        RemoteData.Failure err ->
            baseSpotifyButton ForceFetchLogin


baseSpotifyButton : Msg -> Html Msg
baseSpotifyButton msg =
    a 
        [ class "button is-success is-large"
        , onClick msg
        ]
        [ icon "fab fa-spotify"
        , spanText "Get Started"
        ]


heroFeatures : Html Msg
heroFeatures =
    section 
        [ class "hero is-light is-medium"]
        [ div
            [ class "hero-body" ]
            [ div 
                [ class "container" ]
                [ nav 
                    [ class "columns" ]
                    [ iconColumn "far fa-address-card fa-5x" "Taste Summary" "Analyze weeks, months, or up to years of data and generate playlists that exemplify your distinct taste in music"
                    , iconColumn "fas fa-search fa-5x" "Discover Now" "No need to wait a week, get an automatically curated discover playlist right now"
                    , iconColumn "fab fa-spotify fa-5x" "Simple Login" "You have enough accounts to worry about - use your existing Spotify account to log in"
                    , iconColumn "fas fa-unlock-alt fa-5x" "Forever Free" "No ads, no analytics, no subscription - simply share and enjoy"
                    ]
                ]
            ]
        ]

iconColumn : String -> String -> String -> Html Msg
iconColumn iconLink title sub =
    div
        [ class "column has-text-centered" ]
        [ largeIcon iconLink
        , featureTitle title
        , featureSub sub 
        ]


featureTitle : String -> Html Msg
featureTitle label =
    p
        [ class "title is-4 is-spaced" ]
        [ text label ]


featureSub : String -> Html Msg
featureSub label =
    p
        [ class "subtitle"
        , style [ ("line-height", "1.6") ]
        ]
        [ text label ]