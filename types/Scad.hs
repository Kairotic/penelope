module Scad where

import Data.Colour.SRGB
import Data.Colour.Names
import Tablet

scadBand :: Band -> String
scadBand (Band cords weft) = concatMap showThread cords

showThread t = ""
