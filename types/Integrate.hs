module Integrate where

import Data.Colour.SRGB
import Data.Colour.Names

data Action = Pull Int | Turn | TurnBack | Over | Under
data Twist = S | Z
data Spin = Spin [Twist]

instance Show Action where
  show (Pull n) = "pull " ++ show n
  show Turn = "turn"
  show TurnBack = "turn back"
  show Over = "over"
  show Under = "under"

instance Eq Action where
  (==) Turn Turn = True
  (==) TurnBack TurnBack = True
  (==) Over Over = True
  (==) Under Under = True
  (==) (Pull a) (Pull b) = a == b
  (==) _ _ = False

data Thread = Strand (Colour Double) | Ply [Thread]

data Structure = Structure Thread Action

