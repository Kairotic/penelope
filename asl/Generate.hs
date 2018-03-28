module Generate where

data Grammar = Symbol String
             | Option [Grammar]
             | Sequence [Grammar]

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

