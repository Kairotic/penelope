module Integrate where

import Data.List (transpose)
import Data.Colour.SRGB
import Data.Colour.Names
import System.Process

-- 'Pull' is a thread over a given distance (generally under tension)
-- 'Turn' is where a thread takes the same 90 degree turn as last time
-- 'TurnBack' is where takes teh opposite 90 degree turn as last time
-- 'Over' and 'Under' is where a thread goes over or under a thread
-- (possibly itself)
data Action = Pull Int | Turn | TurnBack | Over | Under

data Twist = S | Z
           deriving Eq

-- Used for twist in yarn, threading (and 'flipping') of tablets, and
-- rotation of tablets. These are closely related if you consider the
-- twist of tablets to create a new yarn by twisting threads together
-- within the band.
instance Show Twist where
  show S = "S"
  show Z = "Z"
