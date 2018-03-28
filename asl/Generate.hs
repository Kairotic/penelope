module Generate where

data Grammar = Symbol String
             | Option [Grammar]
             | Sequence [Grammar]

choose :: String -> Grammar
choose xs = Option $ map Symbol xs

colour = choose $ words "red orange yellow pink"

colourSequence = option [colour,
                         colour, Symbol " ", colourSequence
                        ]
