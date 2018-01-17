module Integrate where

import Data.Colour.SRGB
import Data.Colour.Names

data Movement = Pull Int | TurnIn | TurnOut | Over | Under

instance Show Movement where
  show (Pull n) = "pull " ++ show n
  show TurnIn = "turn in"
  show TurnOut = "turn out"
  show Over = "over"
  show Under = "under"

data Thread = Strand (Colour Double) | Ply [Thread]

data Structure = Structure Thread Movement

