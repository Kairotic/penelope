module Scad where

import Data.Colour.SRGB
import Data.Colour.Names
import Tablet

scadBand :: Band -> String
scadBand (Band cords weft) = scadPreamble ++ (concat $ map offset $ zip [0, 2 ..] (map showThread cords))
  where offset (n, t) = "translate([0," ++ show (n) ++ ",0]) {\n" ++ t ++ "};\n"

writeScadBand b = writeFile "test.scad" (scadBand b)

showThread (Ply threads (Spin twists))  = setColours ++ "rotate ([0,0,45]) {\n" ++ doTwist 0 0 twists ++ "\n};\n"
  where doTwist :: Int -> Int -> [Twist] -> String
        doTwist d y [] = ""
        doTwist d y (Z:twists) = seg ( 90) (d + 90) y ++ doTwist (d + 90) (y-1) twists
        doTwist d y (S:twists) = seg (-90) (d - 90) y ++ doTwist (d - 90) (y-1) twists
        doTwist d y (I:twists) = seg (  0) (d +  0) y ++ doTwist (d +  0) (y-1) twists
        seg t r y = "rotate([0,0," ++ show r ++ "]) translate([0,0," ++ show (y*2) ++ "]) yarnSegment(" ++ show t ++ ",a,b,c,d);\n"
        setColours = concatMap setColour $ zip (words "a b c d") colours
        colours = map firstColour threads
        setColour (name, c) = name ++ " = [" ++ show r ++ "," ++ show g ++ "," ++ show b ++ "];\n"
          where (RGB r g b) = toSRGB c
showThread _ = ""

scadPreamble = "module twist(x,y,t) {\n    linear_extrude(height = 2, center = false, convexity = 10, twist = t, $fn=20)\n        translate([x, y, 0])\n        circle(r = 1);\n}\n\nmodule yarnSegment(t, a,b,c,d) {\n        color(a)\n    twist(-1,1,t);\n    color(b)\n    twist(-1,-1,t);\n    color(c)\n    twist(1,-1,t);\n    color(d)    \n    twist(1,1,t);\n}"





