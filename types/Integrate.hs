module Integrate where

import Data.List (transpose)
import Data.Colour.SRGB
import Data.Colour.Names

data Action = Pull Int | Turn | TurnBack | Over | Under
data Twist = S | Z
           deriving Eq

instance Show Twist where
  show S = "S"
  show Z = "Z"
                     
data Spin = Spin [Twist]

instance Show Spin where
  show (Spin s) =  (concatMap (show) $ take 5 s) ++ ".."

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

data Thread = Strand {colour :: Colour Double, roll :: Spin}
            | Ply {plyThreads :: [Thread], roll :: Spin}

instance Show Thread where
  show (Strand c r) = "Strand " ++ showColour c ++ " " ++ show r
    where showColour c | c == red = "red"
                       | c == blue = "blue"
                       | c == green = "green"
                       | c == white = "white"
                       | otherwise = show c
  show (Ply pt r) = "Ply " ++ show pt ++ " " ++ show r

-- Trying to conflate S/Z threading (or flip) on the card with
-- rotation of it by referring to former as 'yaw' and latter as
-- 'roll'
data Tablet = Tablet {warps :: [Thread], yaw :: Twist}
            deriving Show

type Heddles = [Int]

data Loom = Loom {warp :: Thread, loomWeft :: Thread, heddles :: Heddles}

-- A weave as two interactive curves
data Weave = Weave {wWarp :: Curve, wWeft :: Curve}

data TabletLoom = TabletLoom {tablets :: [Tablet], tabletWeft :: Thread}
                 deriving Show

-- Not the shed exactly but how to go from one shed to the
-- next.. Should be one twist per card
type TabletShed = [Twist]

data TabletWeave = TabletWeave {tLoom :: TabletLoom, tSheds :: [TabletShed]}
                 deriving Show

-- Curve as in how to move from one dimensional thread to two dimensional surface
data Curve = Curve Thread [Action]
           deriving Show
-- Cords here aren't curves, they're 1d but with varying spin
data Band = Band {bandCords :: [Thread], bandWeft :: Curve}
          deriving Show

flipTwist S = Z
flipTwist Z = S

flipTablet t = t {yaw = flipTwist (yaw t)}

spin twist = Spin $ repeat twist

tabletWeave :: TabletWeave -> Band
tabletWeave tw = Band cords weftCurve
  where cords = twistCords tw
        weftCurve = Curve (tabletWeft $ tLoom tw)  []
        -- assuming yaw of tablet = roll of thread, depends which side you look at tablet from
        -- tabletCord tablet = Ply (warps tablet) (Spin [])

twistCords :: TabletWeave -> [Thread]
twistCords tw = map tabletCord (zip (tablets $ tLoom tw) twists)
  where tabletCord (tablet, tabletTwists) = Ply (warps tablet) (Spin $ map doFlip tabletTwists)
          where doFlip x | yaw tablet == S = x
                         | otherwise = flipTwist x
        -- list of thread twists rather than list of card moves over time
        twists = transpose (tSheds tw)
  
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

