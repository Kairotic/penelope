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
