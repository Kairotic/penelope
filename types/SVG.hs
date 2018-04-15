module SVG where

import Data.Colour.SRGB
import Data.Colour.Names
import System.Process

import Tablet

data Segment = Segment (Colour Double) (Colour Double) Twist

-- Returns a list representing a sequence of 'top' strands in a
-- multi-ply thread, in terms of the colour of the previous strand,
-- the previous of the current one, and the direction of twist. If the
-- twist direction is I, then both colours should be the say.
plyTop :: Int -> Thread -> [Segment]
plyTop _ (Strand _ _) = []
plyTop _ (Ply _ (Spin [])) = []
plyTop n (Ply pt (Spin (twist:twists)))
  = this:succ
    where this = Segment (firstColour $ pt !!! n) (firstColour $pt !!! (n+delta)) twist
          succ = plyTop (n+delta) (Ply pt (Spin twists))
          delta | twist == S = 1 -- TODO - guess - other way around?
                | twist == Z = -1
                | twist == I = 0
          (!!!) :: [a] -> Int -> a
          (!!!) xs n = xs !! (n `mod` length xs)

-- Given an x y position, return a string representing a Segment in
-- SVG code.
svgFgBg :: Int -> Int -> Segment -> String
svgFgBg x y (Segment f b t) = (svgPath idFg (x*sX,y*sY) f fCorner) ++ (svgPath idBg (x*sX,y*sY) b bCorner)
  where idFg = "fg-" ++ show x ++ "x" ++ show y
        idBg = "bg-" ++ show x ++ "x" ++ show y
        fCorner | t == S = TR
                | otherwise = TL
        bCorner | t == S = BL
                | otherwise = BR

-- Return SVG code to draw the given band
svgBand :: Band -> String
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

sX = 10
sY = 20
sXs = show sX
sYs = show sY

data Corner = TL | TR | BL | BR
path TL x y = show x ++ "," ++ show y ++ " " ++ sXs ++ ",0 -" ++ sXs ++ "," ++ sYs
path TR x y = show x ++ "," ++ show y ++ " " ++ sXs ++ ",0 0," ++ sYs
path BL x y = show x ++ "," ++ show y ++ " " ++ sXs ++ "," ++ sYs ++ " -" ++ sXs ++ ",0"
path BR x y = show (x+sXs) ++ "," ++ show y ++ " 0," ++ sYs ++ " -" ++ sXs ++ ",0"

svgLayer :: String -> String -> String
svgLayer id inner = "<g id=\"" ++ id ++ "\">" ++ inner ++ "</g>"

svgPath :: String -> (Int,Int) -> Colour Double -> Corner ->  String
svgPath id (x,y) c cnr = "<path id=\"" ++ id ++ "\" d=\"m " ++ path cnr x y ++ " z\" style=\"fill:" ++ cHex c ++ ";fill-rule:evenodd;stroke:none\" />"
  where xy = show x ++ " " ++ show y

cHex = sRGB24show

writeBand b = do writeFile "test.svg" (svgBand b)
                 -- callProcess "~/Dropbox/bin/fixsvg.pl" ["test.svg"]
                 callProcess "inkscape" ["test.svg", "--export-pdf=test.pdf"]
                 return ()
