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

data Thread = Strand (Colour Double) Spin
            | Ply [Thread] Spin

-- Trying to conflate S/Z threading (or flip) on the card with
-- rotation of it by referring to former as 'yaw' and latter as
-- 'roll'
data Tablet = Tablet {warps :: [Thread], yaw :: Twist}

type Heddles = [Int]

data Loom = Loom {warp :: Thread, loomWeft :: Thread, heddles :: Heddles}

data TabletLoom = TabletLoom {tablets :: [Tablet], tabletWeft :: Thread}

-- Not the shed exactly but how to go from one shed to the next..
type TabletShed = [Twist]

data TabletWeave = TabletWeave {tShed :: [TabletShed], tLoom :: TabletLoom}

-- Curve as in how to move from one dimensional thread to two dimensional surface
data Curve = Curve Thread Action
-- Cords here aren't curves, they're 1d but with varying spin
data Band = Band {cords :: [Thread], bandWeft :: Curve}


-- tabletWeave :: TabletWeave -> 
-- tabletWeave tw = 
