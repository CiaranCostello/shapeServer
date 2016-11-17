module Transform(Transfor(..), transform) where

import 	qualified Data.Matrix as M
	(Matrix(..)
	, fromLists
	, multStd2
	, identity
	)

-- Transformations
-- svg can take transformations as a matrix with six values, matrix(a b c d e f)
--	a c d
-- (b d f)
--  0 0 1

data Transform = Identity
           | Translate Double Double
           | Scale Double Double
           | Transform <+> Transform
           | Rotate Double
             deriving (Show, Read)

--By expressing all transformations as 3x3 matrices we can compose them with matrix multiplication

transform :: Transform -> M.Matrix Double
transform Identity 			= M.indentity 3
transform (Translate x y) 	= M.fromLists [[1, 0, x],
										   [0, 1, y],
										   [0, 0, 1]]
transform (Scale x y) 		= M.fromLists [[x, 0, 0],
										   [0, y, 0],
										   [0, 0, 1]]
transform (Rotate d) 		= M.fromLists [[cos rad, -(sin rad), 0],
                                           [sin rad, cos rad, 0],
                                           [0, 0, 0]]
    where r = (d * pi)/180
transform (t1 <+> t2) = M.multStd2 (transform t1) (transform t2)