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

data Thread = Strand {colour :: Colour Double, roll :: Spin}
            | Ply {plyThreads :: [Thread], roll :: Spin}

-- Trying to conflate S/Z threading (or flip) on the card with
-- rotation of it by referring to former as 'yaw' and latter as
-- 'roll'
data Tablet = Tablet {warps :: [Thread], yaw :: Twist}

type Heddles = [Int]

data Loom = Loom {warp :: Thread, loomWeft :: Thread, heddles :: Heddles}

-- A weave as two interactive curves
data Weave = Weave {wWarp :: Curve, wWeft :: Curve}

data TabletLoom = TabletLoom {tablets :: [Tablet], tabletWeft :: Thread}

-- Not the shed exactly but how to go from one shed to the
-- next.. Should be one twist per card
type TabletShed = [Twist]

data TabletWeave = TabletWeave {tLoom :: TabletLoom, tSheds :: [TabletShed]}

-- Curve as in how to move from one dimensional thread to two dimensional surface
data Curve = Curve Thread [Action]
-- Cords here aren't curves, they're 1d but with varying spin
data Band = Band {bandCords :: [Thread], bandWeft :: Curve}


tabletWeave :: TabletWeave -> Band
tabletWeave tw = Band cords weftCurve
  where cords = map tabletCord (tablets $ tLoom tw)
        weftCurve = Curve (tabletWeft $ tLoom tw)  []
        -- assuming yaw of tablet = roll of thread, depends which side you look at tablet from
        tabletCord tablet = Ply (warps tablet) (Spin [yaw tablet])

test = TabletWeave {tLoom = TabletLoom {tablets = take 12 $ cycle [redWhiteTablet, blueGreenTablet],
                                        tabletWeft = Strand {colour = orange,
                                                             roll = S
                                                            }
                                       },
                    tSheds = (take 24 $ cycle [replicate 12 S, replicate 12 Z])
                   }
  where redWhiteTablet = Tablet {warps = [redThread, redThread, whiteThread, whiteThread]} S
        blueGreenTablet = Tablet {warps = [blueThread, blueThread, greenThread, greenThread]} S
        redThread = Strand red S
        whiteThread = Strand white S
        blueThread = Strand blue S
        greenThread = Strand green S

-- tabletWeave :: TabletWeave -> 
-- tabletWeave tw = 
