module TabletSwitch where

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

instance Show Action where
  show (Pull n) = "pull " ++ show n
  show Turn = "turn"
  show TurnBack = "turn back"
  show Over = "over"
  show Under = "under"

data Twist = S | Z | I
           deriving Eq

-- Used for twist in yarn, threading (and 'flipping') of tablets, and
-- rotation of tablets. These are closely related if you consider the
-- twist of tablets to create a new yarn by twisting threads together
-- within the band.
instance Show Twist where
  show S = "S"
  show Z = "Z"
  show I = "I"

data Spin = Spin [Twist]

instance Show Spin where
  show (Spin s) =  (concatMap (show) $ take 5 s) ++ ".."

showColour c | c == red = "r"
             | c == blue = "b"
             | c == green = "g"
             | c == white = "w"
             | otherwise = show c

-- A thread can eiher be a base Strand, or be a Ply composed of other
-- threads (which can recurse to any level). A strand has a colour,
-- both strand and ply have a twist over their length (called 'roll'
-- in sympathy with the 'yaw' of a flipping tablet)
data Thread = Strand {colour :: Colour Double, roll :: Spin}
            | Ply {plyThreads :: [Thread], roll :: Spin}

instance Show Thread where
  show (Strand c r) = "Strand " ++ showColour c ++ " " ++ show r
  show (Ply pt r) = "Ply " ++ show pt ++ " " ++ show r


-- Trying to conflate S/Z threading (or flip) on the card with
-- rotation of it by referring to former as 'yaw' and latter as
-- 'roll'
data Tablet = Tablet {warps :: [Thread], yaw :: Twist}
            deriving Show

-- A tablet weaving loom, as an ordered set of tablets and a weft
data TabletLoom = TabletLoom {tablets :: [Tablet], tabletWeft :: Thread}
                deriving Show

-- Not the shed exactly but how to go from one shed to the
-- next.. Should be one twist per card. This is really the same type
-- as a Spin although used differently, hmm.
type TabletShed = [Twist]

-- A tablet weave is a tablet loom and a sequence of tablet rotations
-- to create sheds
data TabletWeave = TabletWeave {tLoom :: TabletLoom, tSheds :: [TabletShed]}
                 deriving Show

-- An infinitely long twist in a single given direction
spin :: Twist -> Spin
spin twist = Spin $ repeat twist

-- Function for flipping S/Z direction
flipTwist :: Twist -> Twist
flipTwist S = Z
flipTwist Z = S
flipTwist I = I

-- Returns the colour of a strand, or if the thread has more than one
-- strand, the colour of the 'first' one.
firstColour :: Thread -> Colour Double
firstColour (Strand c _) = c
firstColour (Ply (t:_) r) = firstColour t

-- A curve is a sequence of actions -- representing how to use a one
-- dimensional thread to fill a two dimensional surface..
data Curve = Curve {curveThread :: Thread,
                    curvePath :: [Action]
                   }
           deriving Show

-- A band is a set of twisted cords next to each other, drawn together
-- into a band by the weft. Cords here aren't curves, they're 1d but
-- with varying S/Z spin. It's the curve of the weft that binds them
-- together (by passing through the cords) into a 2D surface.
data Band = Band {bandCords :: [Thread], bandWeft :: Curve}
          deriving Show

-- Returns the input tablet, but flipped
flipTablet :: Tablet -> Tablet
flipTablet t = t {yaw = flipTwist (yaw t)}

