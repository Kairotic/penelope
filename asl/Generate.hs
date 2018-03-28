module Generate where

data Grammar = Symbol String
             | Option [Grammar]
             | Sequence [Grammar]

choose :: String -> Grammar
choose xs = Option $ map Symbol xs

colour = choose $ words "red orange yellow pink"

colourSeqList = option [colour,
                        Sequence [colour, Symbol " ", colourSequence]
                       ]

colourSeqList = Option [colourSequence,
                        colourSequence, Symbol ", ", colourSeqList
                       ]

colourPolyMeter = Sequence [Symbol "{",
                            colourSeqList,
                            Symbol "}"
                           ]

colourPolyRhythm = Sequence [Symbol "[",
                             colourSeqList,
                             Symbol "]"
                            ]

