module Shapes(
  Shape(..), Point(..), Vector(..), Style(..), Drawing(..), Colour(..),
  point, getX, getY,
  empty, circle, square)  where
import Transform

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