module Scad where

import Data.Colour.SRGB
import Data.Colour.Names
import Tablet

scadBand :: Band -> String
scadBand (Band cords weft) = concatMap showThread cords

showThread (Ply threads (Spin twists))  = setColours ++ doTwist 0 0 twists
  where doTwist :: Int -> Int -> [Twist] -> String
        doTwist d y [] = ""
        doTwist d y (S:twists) = seg (-90) (d - 90) y ++ doTwist (d - 90) (y+1) twists
        doTwist d y (Z:twists) = seg ( 90) (d + 90) y ++ doTwist (d + 90) (y+1) twists
        doTwist d y (I:twists) = seg (  0) (d +  0) y ++ doTwist (d +  0) (y+1) twists
        seg t r y = "rotate([0,0," ++ show r ++ "]) translate([0,0," ++ show (y*2) ++ "]) yarnSegment(" ++ show t ++ ",a,b,c,d);\n"
        setColours = concatMap setColour $ zip (words "a b c d") colours
        colours = map firstColour threads
        setColour (name, c) = name ++ " = [" ++ show r ++ "," ++ show g ++ "," ++ show b ++ "];\n"
          where (RGB r g b) = toSRGB c
showThread _ = ""
