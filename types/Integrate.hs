module Integrate where

import Data.List (transpose)
import Data.Colour.SRGB
import Data.Colour.Names
import System.Cmd

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
  show (Ply pt r) = "Ply " ++ show pt ++ " " ++ show r

showColour c | c == red = "r"
             | c == blue = "b"
             | c == green = "g"
             | c == white = "w"
             | otherwise = show c

firstColour :: Thread -> Colour Double
firstColour (Strand c _) = c
firstColour (Ply (t:_) r) = firstColour t

data Segment = Segment (Colour Double) (Colour Double) Twist

instance Show Segment where
  show s@(Segment c1 c2 t) = colourTwistEven s ++ " (" ++ showColour c1 ++ "/" ++ showColour c2 ++ " " ++ show t ++ ")"

plyTop :: Int -> Thread -> [Segment]
plyTop _ (Strand _ _) = []
plyTop _ (Ply _ (Spin [])) = []
plyTop n (Ply pt (Spin (twist:twists)))
  = this:succ
    where this = Segment (firstColour $ pt !!! n) (firstColour $pt !!! (n+delta)) twist
          succ = plyTop (n+delta) (Ply pt (Spin twists))
          delta | twist == S = 1 -- TODO - guess - other way around?
                | otherwise = -1
          (!!!) :: [a] -> Int -> a
          (!!!) xs n = xs !! (n `mod` length xs)

showSegments :: [Segment] -> [String]
showSegments ss = map (\(f, s) -> (f s))
                  $ zip (cycle [colourTwistEven, colourTwistOdd]) ss

-- showBand :: Band -> String
showBand b = concat $ concat $ transpose $ map (showSegments . plyTop 0) $ bandCords b

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

thread c = Strand c (spin S)

-- ANSI drawing stuff

ansifg c | c == black   = "\x001b[30m"
         | c == red     = "\x001b[31m"
         | c == green   = "\x001b[32m"
         | c == yellow  = "\x001b[33m"
         | c == blue    = "\x001b[34m"
         | c == magenta = "\x001b[35m"
         | c == cyan    = "\x001b[36m"
         | c == white   = "\x001b[37m"
         | otherwise    = ansireset

ansibg c | c == black   = "\x001b[40m"
         | c == red     = "\x001b[41m"
         | c == green   = "\x001b[42m"
         | c == yellow  = "\x001b[43m"
         | c == blue    = "\x001b[44m"
         | c == magenta = "\x001b[45m"
         | c == cyan    = "\x001b[46m"
         | c == white   = "\x001b[47m"
         | otherwise    = ansireset

ansireset = "\x001b[0m"

colourTwistEven (Segment f b S) = colourString f b (tr:[])
colourTwistEven (Segment f b Z) = colourString f b (tl:[])

colourTwistOdd (Segment f b S) = colourString b f (bl:[])
colourTwistOdd (Segment f b Z) = colourString b f (br:[])

colourString :: (Colour Double) -> (Colour Double) -> String -> String
colourString f b s = ansifg f ++ ansibg b ++ s ++ ansireset

tl = '◤'
tr = '◥'
bl = '◣'
br = '◢'

-- SVG drawing things

svgFgBg x y (Segment f b t) = (svgPath idFg (x*svgScale,y*svgScale) f fCorner) ++ (svgPath idBg (x*svgScale,y*svgScale) b bCorner)
  where idFg = "fg-" ++ show x ++ "x" ++ show y
        idBg = "bg-" ++ show x ++ "x" ++ show y
        fCorner | t == S = TR
                | otherwise = TL
        bCorner | t == S = BL
                | otherwise = BR

--data Direction = Up | Right | Down | Left

svgBand b = svgPreamble ++ warpTop ++ svgPostamble
  where warpTop = svgLayer "warptop" $ concatMap (\(x,ys) -> concatMap (\(y,s) -> svgFgBg x y s) ys) $ zip [0 ..] (map (zip [0 ..] . plyTop 0) $ bandCords b)
        -- weft = svgWeft CW 0 0 $ curvePath $ bandWeft b

{-
svgWeft :: Direction -> Twist -> Int -> Int -> [Action] -> String
svgWeft _ _ _ _ [] = ""
svgWeft d t x y ((Pull n):as) = svg ++ svgWeft d x' y' as
  where (x',y') | d == Up    = (x, y-n)
                | d == Down  = (x, y+n)
                | d == Left  = (x-n, y)
                | d == Right = (x+n, y)
        svg = "<path d=\"m " ++ path ++ " z\" style=\"fill:" ++ cHex red ++ ";fill-rule:evenodd;stroke:none\" />"
        path = show (x*svgScale) ++ "," ++ show (y*svgScale) ++ " "
               ++ (show x  )
-}

-- path TL x y = show x ++ "," ++ show y ++ " 10,0 -10,10"


svgPreamble = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>\n<svg\n   xmlns:dc=\"http://purl.org/dc/elements/1.1/\"\n   xmlns:cc=\"http://creativecommons.org/ns#\"\n   xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\"\n   xmlns:svg=\"http://www.w3.org/2000/svg\"\n   xmlns=\"http://www.w3.org/2000/svg\"\n   version=\"1.1\"\n   id=\"svg2\"\n   viewBox=\"0 0 744.09448819 1052.3622047\"\n   height=\"297mm\"\n   width=\"210mm\">\n  <defs\n     id=\"defs4\" />\n  <metadata\n     id=\"metadata7\">\n    <rdf:RDF>\n      <cc:Work\n         rdf:about=\"\">\n        <dc:format>image/svg+xml</dc:format>\n        <dc:type\n           rdf:resource=\"http://purl.org/dc/dcmitype/StillImage\" />\n        <dc:title></dc:title>\n      </cc:Work>\n    </rdf:RDF>\n  </metadata>\n  <g\n     id=\"layer1\">\n"

svgPostamble = "</g>\n</svg>\n"

svgScale = 10

data Corner = TL | TR | BL | BR
path TL x y = show x ++ "," ++ show y ++ " 10,0 -10,10"
path TR x y = show x ++ "," ++ show y ++ " 10,0 0,10"
path BL x y = show x ++ "," ++ show y ++ " 10,10 -10,0"
path BR x y = show (x+10) ++ "," ++ show y ++ " 0,10 -10,0"

svgLayer :: String -> String -> String
svgLayer id inner = "<g id=\"" ++ id ++ "\">" ++ inner ++ "</g>"

svgPath :: String -> (Int,Int) -> Colour Double -> Corner ->  String
svgPath id (x,y) c cnr = "<path id=\"" ++ id ++ "\" d=\"m " ++ path cnr x y ++ " z\" style=\"fill:" ++ cHex c ++ ";fill-rule:evenodd;stroke:none\" />"
  where xy = show x ++ " " ++ show y

cHex = sRGB24show

writeBand b = do writeFile "test.svg" (svgBand b)
                 system "~/Dropbox/bin/fixsvg.pl test.svg"
                 system "inkscape test.svg --export-pdf=test.pdf"
                 return ()

-- EXAMPLES

test = TabletWeave {tLoom = TabletLoom {tablets = take 12 $ cycle [tablet2,
                                                                   flipTablet tablet1
                                                                  ],
                                        tabletWeft = Strand {colour = orange,
                                                             roll = Spin (repeat S)
                                                            }
                                       },
                    tSheds = (take 24 $ cycle [forward, backward])
                   }
  where tablet1 = Tablet {warps = [thread red, thread white, thread red, thread white], yaw = S}
        tablet2 = Tablet {warps = [thread blue, thread green, thread blue, thread green], yaw = S}
        forward = replicate 12 S
        backward = replicate 12 Z
testBand = tabletWeave test

simpleWeave = TabletWeave {tLoom = TabletLoom {tablets = take 12 $ cycle [rwgbTablet,
                                                                          flipTablet rwgbTablet
                                                                         ],
                                               tabletWeft = Strand {colour = orange,
                                                                    roll = Spin (repeat S)
                                                                   }
                                              },
                           tSheds = (take 24 $ cycle [replicate 12 S, replicate 12 S, replicate 12 S, replicate 12 S, replicate 12 Z, replicate 12 Z, replicate 12 Z, replicate 12 Z])
                          }
  where rwgbTablet = Tablet {warps = [thread red, thread white, thread green, thread blue], yaw = S}
        
simpleBand = tabletWeave simpleWeave
             
complexWeave = TabletWeave {tLoom = TabletLoom {tablets = take 11 $ cycle [tablet2,
                                                                           flipTablet tablet2,
                                                                           tablet3,
                                                                           flipTablet tablet4,
                                                                           flipTablet tablet2
                                                                          ],
                                                tabletWeft = Strand {colour = orange,
                                                                     roll = Spin (repeat S)
                                                                    }
                                               },
                    tSheds = (take 24 $ cycle [forward, backward, backward, forward, forward, backward])
                           }
  where tablet1 = Tablet {warps = [thread red, thread white, thread red, thread white], yaw = S}
        tablet2 = Tablet {warps = [thread blue, thread green, thread blue, thread green], yaw = S}
        tablet3 = Tablet {warps = [thread orange, thread purple, thread orange, thread purple], yaw = S}
        tablet4 = Tablet {warps = [thread purple, thread orange, thread purple, thread orange], yaw = S}
        forward = replicate 12 S
        backward = replicate 12 Z

complexBand = tabletWeave complexWeave
