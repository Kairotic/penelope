module Scad where

import Data.Colour.SRGB
import Data.Colour.Names
import Tablet

scadBand :: Band -> String
scadBand (Band cords weft) = concatMap showThread cords

showThread (Ply ts s)  = ""
  where colours = map firstColour ts
        setColour name c = name ++ " = [" ++ show r ++ "," ++ show g ++ "," ++ show b ++ "];\n"
          where (RGB r g b) = toSRGB c
showThread _ = ""
