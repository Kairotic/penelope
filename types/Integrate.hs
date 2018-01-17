module Integrate where

import Data.Colour.SRGB
import Data.Colour.Names

data Movement = Pull Int | TurnIn | TurnOut | Over | Under

data Thread = Strand ColourD | Ply [Thread]

data Structure = Structure Thread Movement

