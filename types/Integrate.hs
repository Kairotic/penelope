module Integrate where

data Movement = Pull Int | TurnIn | TurnOut | Over | Under

data Thread = Strand ColourD | Ply [Thread]

data Structure = Structure Thread Movement

