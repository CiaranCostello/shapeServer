module Shapes(
  Shape(..), Point(..), Vector(..), Style(..), Drawing(..), Colour(..),
  point, getX, getY,
  empty, circle, square,
  inside)  where


-- Utilities

data Vector = Vector Double Double
              deriving (Show,Read)
vector = Vector

cross :: Vector -> Vector -> Double
cross (Vector a b) (Vector a' b') = a * a' + b * b'

mult :: Matrix -> Vector -> Vector
mult (Matrix r0 r1) v = Vector (cross r0 v) (cross r1 v)

invert :: Matrix -> Matrix
invert (Matrix (Vector a b) (Vector c d)) = matrix (d / k) (-b / k) (-c / k) (a / k)
  where k = a * d - b * c
        
-- 2x2 square matrices are all we need.
data Matrix = Matrix Vector Vector
              deriving (Show, Read)

matrix :: Double -> Double -> Double -> Double -> Matrix
matrix a b c d = Matrix (Vector a b) (Vector c d)

getX (Vector x y) = x
getY (Vector x y) = y

-- Shapes

type Point  = Vector

point :: Double -> Double -> Point
point = vector


data Shape = Empty 
           | Circle 
           | Square
             deriving (Show,Read)

empty, circle, square :: Shape

empty = Empty
circle = Circle
square = Square

-- Colour

data Colour = Red
            | Green
            | Blue
            | Purple
            | Orange
              deriving (Read)

red, green, blue, purple, orange :: Colour

red = Red
green = Green
blue = Blue
purple = Purple
orange = Orange

instance Show Colour where
  show Red = "red"
  show Green = "green"
  show Blue = "blue"
  show Orange = "orange"
  show Purple = "purple"

-- Style
-- Stroke width, Fill colour and Stroke colour

data Style = Style Double Colour Colour
              deriving (Read,Show)

style = Style

-- Drawings

type Drawing = [(Transform,Shape,Style)]

-- interpretation function for drawings

inside :: Point -> Drawing -> Bool
inside p d = or $ map (inside1 p) d

inside1 :: Point -> (Transform, Shape, Style) -> Bool
inside1 p (t,s,_) = insides (transform t p) s

insides :: Point -> Shape -> Bool
p `insides` Empty = False
p `insides` Circle = distance p <= 1
p `insides` Square = maxnorm  p <= 1


distance :: Point -> Double
distance (Vector x y ) = sqrt ( x**2 + y**2 )

maxnorm :: Point -> Double
maxnorm (Vector x y ) = max (abs x) (abs y)

testShape = (scale (point 10 10), circle)
