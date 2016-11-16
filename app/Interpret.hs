{-# LANGUAGE OverloadedStrings #-}

module Interpret(interpret) where

import Text.Blaze.Svg11 ((!), mkPath, rotate, l, m)
import qualified Text.Blaze.Svg11 as S
import qualified Text.Blaze.Svg11.Attributes as A
import Text.Blaze.Svg.Renderer.Text (renderSvg)
import Shapes

interpret :: Drawing -> S.Svg
interpret d = S.docTypeSvg ! A.version "1.1" ! A.width "600" ! A.height "400" ! A.viewbox "0 0 6 4" $ do
  interpretInner d

interpretInner :: Drawing -> S.Svg
interpretInner [x] = parse x
interpretInner (x:xs) = parse x >> interpretInner xs

parse :: (Transform,Shape,Style) -> S.Svg
parse (t, Circle, s) = attributeParse S.circle (s,t) ! A.r "1" ! A.cx "1" ! A.cy "1"
parse (t, Square, s) = attributeParse S.rect (s,t) ! A.width "1" ! A.height "1"

attributeParse :: S.Svg -> (Style, Transform) -> S.Svg
attributeParse svg (s, t) = styleParse (transformParse svg t) s

styleParse :: S.Svg -> Style -> S.Svg
styleParse svg (Style strW fillCol strCol) = svg ! A.fill (S.stringValue $ show fillCol) ! A.strokeWidth (S.stringValue $ show strW) ! A.stroke (S.stringValue $ show strCol)

transformParse :: S.Svg -> Transform -> S.Svg
transformParse s _ = s