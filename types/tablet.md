# Tablet coding

Representation of Tablet Weaving in Haskell

References:

* http://www.stringpage.com/tw/twtheory.html
* http://dyadic.borrowed-scenery.net/penelope/tabletloom/
* http://www.pawfal.org/dave/blog/tag/tablet-weaving/

## Tablet.hs

Tablet weaving is described in terms of types and functions, with the
aim to result in a representation of tablet weave from the point of
view of threads.

### Types

```haskell
data Action = Pull Int | Turn | TurnBack | Over | Under
```

The actions taken by a thread.

* `Pull` is a thread over a given distance (generally under tension)
* `Turn` is where a thread takes the same 90 degree turn as last time
* `TurnBack` is where takes the opposite 90 degree turn as last time
* `Over` and 'Under' is where a thread goes over or under a thread (possibly itself)

For tablet weaving, perhaps we only really need `pull`. The others are
for when we later integrate plain weaving with tablet weaving.

```haskell
data Twist = S | Z | I
           deriving Eq
```

`Twist` is used for twist in yarn, threading (and 'flipping') of
tablets, and rotation of tablets. These are closely related if you
consider the twist of tablets creates a new yarn by twisting threads
together within the band. `S` and `Z` indicates a twist as standard,
and `I` indicates an untwisted yarn.

```haskell
data Spin = Spin [Twist]
```

A `spin` is a sequence of twists. Normally a yarn would be sequence of
either `S` or `Z` twists.

```haskell
data Thread = Strand {colour :: Colour Double, roll :: Spin}
            | Ply {plyThreads :: [Thread], roll :: Spin}
```

A thread can eiher be an atomic `Strand`, or a `Ply` composed of other
threads (each of which may themselves be `Ply` or `Strand`). A strand
has a colour, and both strand and ply have a twist over their length
(called 'roll' in sympathy with the 'yaw' of a flipping
tablet). Normally a `Ply` thread would spin in the opposite direction
to its composite threads.

```haskell
data Tablet = Tablet {warps :: [Thread], yaw :: Twist}
            deriving Show
```

A tablet is an ordered set of warps, and its yaw (flip). This
conflates S/Z threading (or flip) on the card with rotation of it by
referring to former as 'yaw' and latter as 'roll'. (In English the
three directions that e.g. a plane or fish rotates are called pitch,
yaw and roll).

```haskell
data TabletLoom = TabletLoom {tablets :: [Tablet], tabletWeft :: Thread}
                deriving Show
```

A tablet weaving loom, as an ordered set of tablets, and a weft
thread.

```haskell
type TabletShed = [Twist]
```

The `Shed` of a tablet is a set of twists, one per tablet. Not a shed
exactly, but how to go from one shed to another.  (This is really the
same type as `Spin`, we should probably use that here..)


```haskell
data TabletWeave = TabletWeave {tLoom :: TabletLoom, tSheds :: [TabletShed]}
                 deriving Show
```

A tablet weave is a tablet loom and a sequence of tablet rotations to
create sheds.


```haskell
data Curve = Curve {curveThread :: Thread,
                    curvePath :: [Action]
                   }
           deriving Show
```

A `Curve` is a sequence of actions taken by a thread. This can be
thought of as representing how to use a one dimensional thread to fill a
two or three-dimensional surface.

```haskell
data Band = Band {bandCords :: [Thread], bandWeft :: Curve}
          deriving Show
```

A `Band` is a set of twisted cords next to each other, drawn together
into a band by the weft. Cords here aren't curves, they're 1d but
with varying S/Z spin. It's the curve of the weft that binds them
together (by passing through the cords) into a 2D surface.

### Functions

```haskell
spin :: Twist -> Spin
spin twist = Spin $ repeat twist
```

An infinitely long twist in a single given direction - used to create
a standard thread (as opposed to the `Spin` type defined earlier).

```haskell
thread :: Colour Double -> Thread
thread c = Strand c (spin S)
```

`thread` is a function that returns a `Thread` that is a single strand of a given colour, spun in the `S` direction.

```haskell
flipTwist :: Twist -> Twist
flipTwist S = Z
flipTwist Z = S
flipTwist I = I
```

`flipTwist` flips S/Z direction of a `Twist`.

```haskell
firstColour :: Thread -> Colour Double
firstColour (Strand c _) = c
firstColour (Ply (t:_) r) = firstColour t
```

This returns the colour of a strand, or if the thread has more than
one strand, the colour of the 'first' one.

```
flipTablet :: Tablet -> Tablet
flipTablet t = t {yaw = flipTwist (yaw t)}
```

`flipTablet` returns the given tablet, flipped.

```haskell
tabletWeave :: TabletWeave -> Band
tabletWeave tw = Band cords weftCurve
  where cords = twistCords tw
        weftCurve = Curve {curveThread = (tabletWeft $ tLoom tw) ,
                           curvePath = concat $ replicate weftCount $ [Pull warpCount] ++ [TurnBack, Turn]
                          }
        warpCount = length $ tablets $ tLoom tw
        weftCount = length $ tSheds tw
        -- not currently used..
        tabby n = take n $ cycle [Over, Under]
```

The `tabletWeave` function does the actual tablet weaving - turning
the `TabletWeave` instructions into a `Band`.

```haskell
twistCords :: TabletWeave -> [Thread]
twistCords tw = map tabletCord (zip (tablets $ tLoom tw) twists)
  where tabletCord (tablet, tabletTwists) = Ply (warps tablet) (Spin $ deriveSpin $ map doFlip tabletTwists)
        -- assumes yaw of tablet = roll of thread, depends which side you look at tablet from?
          where doFlip x | yaw tablet == S = x
                         | otherwise = flipTwist x
        -- transpose to get list of thread twists rather than list of
        -- card rotations over time
        twists = transpose (tSheds tw)
```

`twistCords` is used by `tabletWeave` - twists the cords according to the 'flip' of
the tablet and the sequences of twists in the shed.

```haskell
deriveSpin :: [Twist] -> [Twist]
deriveSpin [] = []
deriveSpin (x:[]) = I:[]
deriveSpin (S:S:xs) = S:(deriveSpin (S:xs))
deriveSpin (Z:Z:xs) = Z:(deriveSpin (Z:xs))
deriveSpin (x:xs) = I:(deriveSpin xs)
```

`deriveSpin` turns the twists of the tablets into the twist of the yarn. The twist of the yarn = the first derivative of the twist of the tablet.

### Example

The following taken from Dave's example here: http://dyadic.borrowed-scenery.net/penelope/tabletloom/

(The threading of the `S` tablets is different from Dave's, because
the code does not yet take into account the flip direction when
threading.)

```haskell
daveWeave :: TabletWeave
daveWeave =
  TabletWeave {tLoom =
    TabletLoom {tablets = [Tablet [y,y,y,y] Z,
                           Tablet [w,r,b,w] Z,
                           Tablet [w,w,r,b] Z,
                           Tablet [b,w,w,r] Z,
                           Tablet [b,r,w,w] S,
                           Tablet [w,b,r,w] S,
                           Tablet [w,w,b,r] S,
                           Tablet [y,y,y,y] S],
                tabletWeft = thread orange
               },
               tSheds = map (replicate 8) [S,S,S,S,Z,Z,Z,Z]
              }
  where y = thread yellow
        b = thread brown
        w = thread white
        r = thread red

daveBand = tabletWeave daveWeave
```

Here is the result, rendered via OpenSCAD via [Scad.hs](Scad.hs).

Front

![front](davefront.png)

Back

![back](daveback.png)

'Exploded'

![exploded](daveexplode.png)

Side

![side](daveside.png)

The symbolic structure of the band looks like this:

```haskell
Band {bandCords = [Ply [Strand Data.Colour.SRGB.Linear.rgb 1.0 1.0 0.0 SSSSS..,Strand Data.Colour.SRGB.Linear.rgb 1.0 1.0 0.0 SSSSS..,Strand Data.Colour.SRGB.Linear.rgb 1.0 1.0 0.0 SSSSS..,Strand Data.Colour.SRGB.Linear.rgb 1.0 1.0 0.0 SSSSS..] ZZZIS..,
                   Ply [Strand w SSSSS..,Strand r SSSSS..,Strand Data.Colour.SRGB.Linear.rgb 0.3762621229909065 2.315336617811041e-2 2.315336617811041e-2 SSSSS..,Strand w SSSSS..] ZZZIS..,
                   Ply [Strand w SSSSS..,Strand w SSSSS..,Strand r SSSSS..,Strand Data.Colour.SRGB.Linear.rgb 0.3762621229909065 2.315336617811041e-2 2.315336617811041e-2 SSSSS..] ZZZIS..,
                   Ply [Strand Data.Colour.SRGB.Linear.rgb 0.3762621229909065 2.315336617811041e-2 2.315336617811041e-2 SSSSS..,Strand w SSSSS..,Strand w SSSSS..,Strand r SSSSS..] ZZZIS..,
                   Ply [Strand Data.Colour.SRGB.Linear.rgb 0.3762621229909065 2.315336617811041e-2 2.315336617811041e-2 SSSSS..,Strand r SSSSS..,Strand w SSSSS..,Strand w SSSSS..] SSSIZ..,
                   Ply [Strand w SSSSS..,Strand Data.Colour.SRGB.Linear.rgb 0.3762621229909065 2.315336617811041e-2 2.315336617811041e-2 SSSSS..,Strand r SSSSS..,Strand w SSSSS..] SSSIZ..,
                   Ply [Strand w SSSSS..,Strand w SSSSS..,Strand Data.Colour.SRGB.Linear.rgb 0.3762621229909065 2.315336617811041e-2 2.315336617811041e-2 SSSSS..,Strand r SSSSS..] SSSIZ..,
                   Ply [Strand Data.Colour.SRGB.Linear.rgb 1.0 1.0 0.0 SSSSS..,Strand Data.Colour.SRGB.Linear.rgb 1.0 1.0 0.0 SSSSS..,Strand Data.Colour.SRGB.Linear.rgb 1.0 1.0 0.0 SSSSS..,Strand Data.Colour.SRGB.Linear.rgb 1.0 1.0 0.0 SSSSS..] SSSIZ..
                  ], 
      bandWeft = Curve {curveThread = Strand Data.Colour.SRGB.Linear.rgb 1.0 0.3762621229909065 0.0 SSSSS.., 
                        curvePath = [pull 8,turn back,turn,pull 8,turn back,turn,
                                     pull 8,turn back,turn,pull 8,turn back,turn,
                                     pull 8,turn back,turn,pull 8,turn back,turn,
                                     pull 8,turn back,turn,pull 8,turn back,turn
                                    ]
                       }
     }
```

# Conclusion

Hypotheses

* Warps are straight when they twist (and deform when they don't)
* Wefts are straight when the warp twists (and go up and down when they don't)

Prediction:

* Wefts are harder to pull when the tablets change direction
