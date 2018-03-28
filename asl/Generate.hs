module Generate where

import System.Random
import Control.Concurrent.MVar

data Grammar = Symbol String
             | Option [Grammar]
             | Sequence [Grammar]

mHead :: MVar [a] -> IO a
mHead mv = do xs <- takeMVar mv
              putMVar mv (tail xs)
              return $ head xs

toString :: (MVar [Float]) -> Grammar -> IO String
toString _ (Symbol s) = return s
toString mFs (Option os) = do f <- mHead mFs
                              let o = os !! (floor (f * (fromIntegral $ length os)))
                              toString mFs o
toString mFs (Sequence gs) = do ss <- mapM (toString mFs) gs
                                return $ concat ss



choose :: [String] -> Grammar
choose xs = Option $ map Symbol xs

colour = choose $ words "red orange yellow pink"

colourSeq = Option [colour,
                    Sequence [colour, Symbol " ", colourSeq]
                   ]

colourSeqList = Option [colourSeq,
                        colourSeq, Symbol ", ", colourSeqList
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

-- gen ::  Grammar -> [Float] -> String

-- generate = do g <- getStdGen
--              let rs = randomRs (0.0, 1.0) g
              
