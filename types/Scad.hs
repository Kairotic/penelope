module Scad where

scadBand :: Band -> String
scadBand (Band cords weft) = concatMap showThread cords

showThread = ""
