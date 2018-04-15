module Scad where

import Data.Colour.SRGB
import Data.Colour.Names
import Tablet

scadBand :: Band -> String
scadBand (Band cords weft) = concatMap showThread cords

showThread (Ply threads twists)  = setColours ++ doTwist 0 twists
  where doTwist d (S:twists) = doTwist (d-90) twists
        doTwist d (Z:twists) = doTwist (d+90) twists
        doTwist d (I:twists) = doTwist (d+0 ) twists
        setColours = concatMap setColour $ zip (words "a b c d") colours
        colours = map firstColour ts
        setColour (name, c) = name ++ " = [" ++ show r ++ "," ++ show g ++ "," ++ show b ++ "];\n"
          where (RGB r g b) = toSRGB c
showThread _ = ""
