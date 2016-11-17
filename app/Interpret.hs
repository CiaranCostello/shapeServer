{-# LANGUAGE OverloadedStrings #-}

module Interpret(interpret) where

import qualified Data.Matrix   (getElem, toLists)
import qualified Text.Blaze.Svg11 ((!), mkPath, rotate, l, m)
import qualified Text.Blaze.Svg11 as S
import qualified Text.Blaze.Svg11.Attributes as A
import qualified Text.Blaze.Svg.Renderer.Text (renderSvg)
import qualified Text.Blaze.Svg (matrix)
import Shapes
import Transform as T

interpret :: Drawing -> S.Svg
interpret d = S.docTypeSvg ! A.version "1.1" ! A.width "600" ! A.height "400" ! A.viewbox "0 0 6 6" $ do
  interpretInner d

interpretInner :: Drawing -> S.Svg
interpretInner [x] = parse x
interpretInner (x:xs) = parse x >> interpretInner xs

parse :: (Transform,Shape,Style) -> S.Svg
parse (t, Circle, s) = attributeParse S.circle (s,t) ! A.r "1" ! A.cx "3" ! A.cy "3"
parse (t, Square, s) = attributeParse S.rect (s,t) ! A.width "1" ! A.height "1" ! A.x "3" ! A.y "3"

attributeParse :: S.Svg -> (Style, Transform) -> S.Svg
attributeParse svg (s, t) = styleParse (transformParse svg t) s

styleParse :: S.Svg -> Style -> S.Svg
styleParse svg (Style strW fillCol strCol) = svg ! A.fill (S.stringValue $ show fillCol) ! A.strokeWidth (S.stringValue $ show strW) ! A.stroke (S.stringValue $ show strCol)

transformParse :: S.Svg -> Transform -> S.Svg
transformParse s t = s ! attribute
	where m = T.transform t
		[[a1, a2, a3],[b1, b2, b3], _] = toLists m
		attribute = matrix a1 b1 a2 b2 a3 b3

