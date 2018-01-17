module Integrate where

import Data.Colour.SRGB
import Data.Colour.Names

data Movement = Pull Int | Turn | TurnBack | Over | Under

instance Show Movement where
  show (Pull n) = "pull " ++ show n
  show Turn = "turn"
  show TurnBack = "turn back"
  show Over = "over"
  show Under = "under"

data Thread = Strand (Colour Double) | Ply [Thread]

data Structure = Structure Thread Movement

