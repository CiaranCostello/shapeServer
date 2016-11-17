{-# LANGUAGE OverloadedStrings #-}

module Interpret(interpret) where

import Data.Matrix   (getElem, toLists)
import Text.Blaze.Svg11 ((!), mkPath, rotate, l, m)
import qualified Text.Blaze.Svg11 as S
import qualified Text.Blaze.Svg11.Attributes as A
import Text.Blaze.Svg.Renderer.Text (renderSvg)
import Shapes
import Transform as T

interpret :: Drawing -> S.Svg
interpret d = S.docTypeSvg ! A.version "1.1" ! A.width "300" ! A.height "300" ! A.viewbox "0 0 6 6" $ do
  interpretInner d

interpretInner :: Drawing -> S.Svg
interpretInner [x] = parse x
interpretInner (x:xs) = parse x >> interpretInner xs

parse :: (Transform,Shape,Style) -> S.Svg
parse (t, Circle, s) = attributeParse S.circle (s,t) ! A.r "1" ! A.cx "0" ! A.cy "0"
parse (t, Square, s) = attributeParse S.rect (s,t) ! A.width "1" ! A.height "1" ! A.x "0" ! A.y "0"

attributeParse :: S.Svg -> (Style, Transform) -> S.Svg
attributeParse svg (s, t) = styleParse (transformParse svg t) s

styleParse :: S.Svg -> Style -> S.Svg
styleParse svg (Style strW fillCol strCol) = svg ! A.fill (S.stringValue $ show fillCol) ! A.strokeWidth (S.stringValue $ show strW) ! A.stroke (S.stringValue $ show strCol)

transformParse :: S.Svg -> Transform -> S.Svg
transformParse s t = s ! A.transform attribute
                    where [[a1, a2, a3],[b1, b2, b3], _] = toLists $ T.transform t
                          attribute = S.matrix a1 b1 a2 b2 a3 b3

