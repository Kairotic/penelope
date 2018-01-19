module Integrate where

import Data.List (transpose)
import Data.Colour.SRGB
import Data.Colour.Names

-- From earlier attempt at representation of thread within a
-- weave..
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

instance Eq Action where
  (==) Turn Turn = True
  (==) TurnBack TurnBack = True
  (==) Over Over = True
  (==) Under Under = True
  (==) (Pull a) (Pull b) = a == b
  (==) _ _ = False


data Twist = S | Z
           deriving Eq

-- Used for twist in yarn, threading (and 'flipping') of tablets, and
-- rotation of tablets. These are closely related if you consider the
-- twist of tablets to create a new yarn by twisting threads together
-- within the band.
instance Show Twist where
  show S = "S"
  show Z = "Z"

-- A sequence of twists. Currently called 'spin' but there is probably better name!
data Spin = Spin [Twist]

instance Show Spin where
  show (Spin s) =  (concatMap (show) $ take 5 s) ++ ".."

-- A thread can eiher be a base Strand, or be a Ply composed of other
-- threads (which can recurse to any level). A strand has a colour,
-- both strand and ply have a twist over their length (called 'roll'
-- in sympathy with the 'yaw' of a flipping tablet)
data Thread = Strand {colour :: Colour Double, roll :: Spin}
            | Ply {plyThreads :: [Thread], roll :: Spin}

instance Show Thread where
  show (Strand c r) = "Strand " ++ showColour c ++ " " ++ show r
    where showColour c | c == red = "r"
                       | c == blue = "b"
                       | c == green = "g"
                       | c == white = "w"
                       | otherwise = show c
  show (Ply pt r) = "Ply " ++ show pt ++ " " ++ show r

-- A curve is a sequence of actions -- representing how to use a one
-- dimensional thread to fill a two dimensional surface..
data Curve = Curve {curveThread :: Thread,
                    curvePath :: [Action]
                   }
           deriving Show

-- Trying to conflate S/Z threading (or flip) on the card with
-- rotation of it by referring to former as 'yaw' and latter as
-- 'roll'
data Tablet = Tablet {warps :: [Thread], yaw :: Twist}
            deriving Show

-- Undeveloped representation of a loom for 'normal' weaving
type Heddles = [Int]
data Loom = Loom {warp :: Thread, loomWeft :: Thread, heddles :: Heddles}
-- A weave as two interactive curves
data Weave = Weave {wWarp :: Curve, wWeft :: Curve}

-- A tablet weaving loom, as an ordered set of tablets and a weft
data TabletLoom = TabletLoom {tablets :: [Tablet], tabletWeft :: Thread}
                deriving Show

-- Not the shed exactly but how to go from one shed to the
-- next.. Should be one twist per card. This is really the same type
-- as a Spin although used differently, hmm.
type TabletShed = [Twist]

-- A tablet weave is a tablet loom and a sequence of tablet rotations to create sheds
data TabletWeave = TabletWeave {tLoom :: TabletLoom, tSheds :: [TabletShed]}
                 deriving Show

-- A band is a set of twisted cords next to each other, drawn together
-- into a band by the weft. Cords here aren't curves, they're 1d but
-- with varying S/Z spin. It's the curve of the weft that binds them
-- together (by passing through the cords) into a 2D surface.
data Band = Band {bandCords :: [Thread], bandWeft :: Curve}
          deriving Show

-- Function for flipping S/Z direction
flipTwist S = Z
flipTwist Z = S

-- Returns the input tablet, but flipped
flipTablet t = t {yaw = flipTwist (yaw t)}

-- An infinitely long twist in a single given direction
spin twist = Spin $ repeat twist

-- A function that does the tablet weaving - turrning the TabletWeave
-- instructions into an actual Band.
tabletWeave :: TabletWeave -> Band
tabletWeave tw = Band cords weftCurve
  where cords = twistCords tw
        weftCurve = Curve {curveThread = (tabletWeft $ tLoom tw) ,
                           curvePath = concat $ replicate weftCount [Pull warpCount, TurnBack, Turn]
                          }
        warpCount = length $ tablets $ tLoom tw
        weftCount = length $ tSheds tw

-- Twists the cords according to the 'flip' of the tablet and the sequences of twists in the shed.
twistCords :: TabletWeave -> [Thread]
twistCords tw = map tabletCord (zip (tablets $ tLoom tw) twists)
  where tabletCord (tablet, tabletTwists) = Ply (warps tablet) (Spin $ map doFlip tabletTwists)
        -- assuming yaw of tablet = roll of thread, depends which side you look at tablet from?
          where doFlip x | yaw tablet == S = x
                         | otherwise = flipTwist x
        -- list of thread twists rather than list of card moves over time
        twists = transpose (tSheds tw)

-- An example tablet weave
test = TabletWeave {tLoom = TabletLoom {tablets = take 12 $ cycle [redWhiteTablet,
                                                                   flipTablet blueGreenTablet
                                                                  ],
                                        tabletWeft = Strand {colour = orange,
                                                             roll = Spin (repeat S)
                                                            }
                                       },
                    tSheds = (take 24 $ cycle [replicate 12 S, replicate 12 Z])
                   }
  where redWhiteTablet = Tablet {warps = [redThread, redThread, whiteThread, whiteThread], yaw = S}
        blueGreenTablet = Tablet {warps = [blueThread, blueThread, greenThread, greenThread], yaw = S}
        redThread = Strand red (spin S)
        whiteThread = Strand white (spin S)
        blueThread = Strand blue (spin S)
        greenThread = Strand green (spin S)

-- The resulting band
testBand = tabletWeave test

ansi c | c == black   = "\x001b[30m"
       | c == red     = "\x001b[31m"
       | c == green   = "\x001b[32m"
       | c == yellow  = "\x001b[33m"
       | c == blue    = "\x001b[34m"
       | c == magenta = "\x001b[35m"
       | c == cyan    = "\x001b[36m"
       | c == white   = "\x001b[37m"
       | otherwise    = "\x001b[0m" -- reset
