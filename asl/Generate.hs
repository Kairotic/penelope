module Generate where

data Grammar = Symbol String
             | Option [Grammar]
             | Sequence [Grammar]
