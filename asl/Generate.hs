module Generate where

import System.Random
import Control.Concurrent.MVar

data Grammar = Symbol String
             | Option [Grammar]
             | Sequence [Grammar]
             | Function String Grammar

removeOption test (Option gs) = Option $ filter (not . test) gs
removeOption _ g = g

removeFunction g name = removeOption test g
  where test (Function name' _) = name == name'
        test _ = False

mHead :: MVar [a] -> IO a
mHead mv = do xs <- takeMVar mv
              putMVar mv (tail xs)
              return $ head xs

toString :: Grammar -> IO String
toString g = do gen <- getStdGen
                let rs = randomRs (0.0, 1.0) gen
                mFs <- newMVar (rs :: [Float])
                toString' mFs g
              

toString' :: (MVar [Float]) -> Grammar -> IO String
toString' _ (Symbol s) = return s
toString' mFs (Option os) = do f <- mHead mFs
                               let o = os !! (floor (f * (fromIntegral $ length os)))
                               toString' mFs o
toString' mFs (Sequence gs) = do ss <- mapM (toString' mFs) gs
                                 return $ concat ss

toString' mFs (Function name g) = do s <- toString' mFs g
                                     return $ name ++ (' ':s)

choose :: [String] -> Grammar
choose xs = Option $ map Symbol xs

colour = choose $ words "red orange yellow pink"

colourSeq = Option [colour,
                    Sequence [colour, Symbol " ", colourSeq]
                   ]

colourSeqList = Option [colourSeq,
                        Sequence [colourPoly, Symbol ", ", colourSeqList]
                       ]

colourPolyMeter = Sequence [Symbol "{",
                            colourSeqList,
                            Symbol "}"
                           ]

colourPolyRhythm = Sequence [Symbol "[",
                             colourSeqList,
                             Symbol "]"
                            ]

colourPoly = Option [colourPolyMeter,
                     colourPolyRhythm
                    ]

trans = Option [Symbol "rev",
                Function "jux" (removeFunction trans "jux"),
                Function "every" $ Sequence [choose (words "2 3 4 5"), Symbol " (", trans, Symbol ")"]
               ]

pattern = Option [colourPoly,
                  Sequence [trans, Symbol " ", colourPoly]
                 ]
