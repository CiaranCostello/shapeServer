{-# LANGUAGE OverloadedStrings #-}
import Web.Scotty
import Network.Wai.Middleware.RequestLogger
import Shapes
import Interpret
import Transform

import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as F
import qualified Text.Blaze.Html.Renderer.Text as R

import Text.Blaze.Svg11 ((!), mkPath, rotate, l, m)
import qualified Text.Blaze.Svg11 as S
import qualified Text.Blaze.Svg11.Attributes as A
import Text.Blaze.Svg.Renderer.Text (renderSvg)

import Data.Text.Lazy

main = scotty 3000 $ do
  middleware logStdoutDev

  get "/" $ do
    html "Hello World!"

  get "/greet" $ do
      html $ "Yo"

  get (literal "/greet/") $ do
      html $ "Oh, wow!"

  get "/greet/:name" $ do
      name <- param "name"
      html $ longresponse name

  get "/svg" $ do
      html $ R.renderHtml $ do
        H.h1 "Shapes DSL to SVG"
        H.body $ do
          interpret [(Identity, Circle, (Style 0 Red Blue)), (Identity, Square, (Style 0 Blue Red))]
          H.form ! F.action "newSvg" ! F.method "POST" $ do
            "Svg:"
            H.input ! F.type_ "text" ! F.value "[(Identity, Circle, (Style 0 Red Blue)), (Identity, Square, (Style 0 Blue Red))]" ! F.size "200" ! F.name "newDsl"
            H.input ! F.type_ "submit" ! F.value "Submit"

  post "/newSvg" $ do 
      newDsl <- param "newDsl"
      html $ R.renderHtml $ do
        H.h1 "Shapes DSL to SVG"
        H.body $ do
          interpret $ (read newDsl :: Drawing)
          H.form ! F.action "newSvg" ! F.method "POST" $ do
            "Svg:"
            H.input ! F.type_ "text" ! F.value (S.stringValue newDsl) ! F.size "200" ! F.name "newDsl"
            H.input ! F.type_ "submit" ! F.value "Submit"



response :: Text -> Text
response n = do R.renderHtml $ do
                  H.h1 ( "Hello " >> H.toHtml n)

longresponse :: Text -> Text
longresponse n = do
  R.renderHtml $ do
    H.head $ H.title "Welcome page"
    H.body $ do
      H.h1 "Welcome!"
      H.p ("Welcome to my Scotty app" >> H.toHtml n)