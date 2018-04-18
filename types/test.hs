import SVG
import Scad
import Tablet
import Data.Colour.SRGB
import Data.Colour.Names


simpleWeave :: TabletWeave
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


bfWeave :: TabletWeave
bfWeave = TabletWeave {tLoom = TabletLoom {tablets = take 12 $ cycle [rwgbTablet,
                                                                      flipTablet rwgbTablet
                                                                     ],
                                           tabletWeft = Strand {colour = orange,
                                                                roll = Spin (repeat S)
                                                               }
                                          },
                       tSheds = (take 24 $ cycle [replicate 12 S, replicate 12 S, replicate 12 Z, replicate 12 Z])
                      }
  where rwgbTablet = Tablet {warps = [thread red, thread white, thread green, thread blue], yaw = S}
        
bfBand = tabletWeave bfWeave

fooWeave :: TabletWeave
fooWeave = TabletWeave {tLoom = TabletLoom {tablets = take 12 $ cycle [rwgbTablet
                                                                       -- flipTablet rwgbTablet
                                                                     ],
                                           tabletWeft = Strand {colour = orange,
                                                                roll = Spin (repeat S)
                                                               }
                                          },
                       tSheds = (take 24 $ cycle [replicate 12 S, replicate 12 S, replicate 12 S, replicate 12 S, replicate 12 S, replicate 12 S, replicate 12 Z, replicate 12 Z, replicate 12 Z, replicate 12 Z, replicate 12 Z, replicate 12 Z])
                      }
  where rwgbTablet = Tablet {warps = [thread red, thread white, thread green, thread blue], yaw = S}
        
fooBand = tabletWeave fooWeave



daveWeave :: TabletWeave
daveWeave =
  TabletWeave {tLoom =
    TabletLoom {tablets = [threadTablet [y,y,y,y] Z,
                           threadTablet [w,r,b,w] Z,
                           threadTablet [w,w,r,b] Z,
                           threadTablet [b,w,w,r] Z,
                           threadTablet [b,w,w,r] S,
                           threadTablet [w,w,r,b] S,
                           threadTablet [w,r,b,w] S,
                           threadTablet [y,y,y,y] S
                          {-
                           Tablet [b,r,w,w] S,
                           Tablet [w,b,r,w] S,
                           Tablet [w,w,b,r] S,
                           Tablet [y,y,y,y] S-}
                          ],
                tabletWeft = thread orange
               },
               tSheds = map (replicate 8) [S,S,S,S,Z,Z,Z,Z]
              }
  where y = thread yellow
        b = thread brown
        w = thread white
        r = thread red

daveBand = tabletWeave daveWeave

barWeave :: TabletWeave
barWeave =
  TabletWeave {tLoom =
    TabletLoom {tablets = [Tablet [g,y,w,b] Z,
                           Tablet [g,y,w,b] Z,
                           Tablet [g,y,w,b] Z,
                           Tablet [g,y,w,b] Z,
                           Tablet [g,y,w,b] Z,
                           Tablet [g,y,w,b] Z,
                           Tablet [g,y,w,b] Z,
                           Tablet [g,y,w,b] Z],
                tabletWeft = thread orange
               },
               tSheds = map (replicate 8) [S,Z,S,Z,S,Z,S,Z]
              }
  where y = thread yellow
        w = thread yellow
        b = thread darkgreen
        g = thread darkgreen

barBand = tabletWeave daveWeave

{-
(load "scm/tablet-loom2.jscm")(weave
;; list of card rotations and orientation flips
(list 'ccw 'ccw 'ccw 'ccw 'ccw 'ccw 'ccw 'ccw
      'cw 'cw 'cw 'cw 'cw 'cw 'cw 'cw)
;; initial thread positions in tablets
(list
 (list 'y 'y 'x 'x)
 (list 'x 'y 'y 'x)
 (list 'x 'x 'y 'y)
 (list 'y 'x 'x 'y)
 (list 'y 'y 'x 'x)
 (list 'x 'y 'y 'x)
 (list 'x 'x 'y 'y)
 (list 'y 'x 'x 'y)
)
;; starting orientation of the tablets
(list 'left 'left 'left 'left 'left 'left 'left 'left))
-}

dave2Weave :: TabletWeave
dave2Weave =
  TabletWeave {tLoom =
    TabletLoom {tablets = [threadTablet [b,b,w,w] Z,
                           threadTablet [w,b,b,w] Z,
                           threadTablet [w,w,b,b] Z,
                           threadTablet [b,w,w,b] Z,
                           threadTablet [b,b,w,w] Z,
                           threadTablet [w,b,b,w] Z,
                           threadTablet [w,w,b,b] Z,
                           threadTablet [b,w,w,b] Z
                          ],
                tabletWeft = thread orange
               },
               tSheds = map (replicate 8) [S,S,S,S,S,S,S,S,Z,Z,Z,Z,Z,Z,Z,Z]
              }
  where b = thread white
        w = thread brown


dave2Band = tabletWeave dave2Weave


dave3Weave :: TabletWeave
dave3Weave =
  TabletWeave {tLoom =
    TabletLoom {tablets = [threadTablet [b,w,w,b] Z,
                           threadTablet [b,w,w,b] Z,
                           threadTablet [b,w,w,b] Z,
                           threadTablet [b,w,w,b] Z,
                           threadTablet [b,w,w,b] Z,
                           threadTablet [b,w,w,b] Z,
                           threadTablet [b,w,w,b] Z,
                           threadTablet [b,w,w,b] Z
                          ],
                tabletWeft = thread orange
               },
               tSheds = map (replicate 8) [S,S,Z,Z,S,S,Z,Z,S,S,Z,Z,S,S,Z,Z]
              }
  where b = thread brown
        w = thread white


dave3Band = tabletWeave dave3Weave


{-
(load "scm/tablet-loom2.jscm")(weave
;; list of card rotations and orientation flips
(list 'ccw 'ccw 'cw 'cw 'ccw 'ccw 'cw 'cw
      'ccw 'ccw 'cw 'cw 'ccw 'ccw 'cw 'cw)
;; initial thread positions in tablets
(list
 (list 'x 'y 'y 'x)
 (list 'x 'y 'y 'x)
 (list 'x 'y 'y 'x)
 (list 'x 'y 'y 'x)
 (list 'x 'y 'y 'x)
 (list 'x 'y 'y 'x)
 (list 'x 'y 'y 'x)
 (list 'x 'y 'y 'x)
)
;; starting orientation of the tablets
(list 'left 'left 'left 'left 'left 'left 'left 'left))
-}



arrowWeave :: TabletWeave
arrowWeave =
  TabletWeave {tLoom =
    TabletLoom {tablets = [
                           threadTablet [b,b,b,b] S,
                           threadTablet [b,b,b,b] Z,
                           threadTablet [w,w,w,w] S,
                           threadTablet [w,w,w,w] S,
                           threadTablet [b,w,w,w] S,
                           threadTablet [b,b,w,w] S,
                           threadTablet [b,g,b,w] S,
                           threadTablet [b,g,g,b] S,
                           threadTablet [b,g,g,g] S,
                           threadTablet [b,g,g,g] Z,
                           threadTablet [b,g,g,b] Z,
                           threadTablet [b,g,b,w] Z,
                           threadTablet [b,b,w,w] Z,
                           threadTablet [b,w,w,w] Z,
                           threadTablet [w,w,w,w] Z,
                           threadTablet [w,w,w,w] Z,
                           threadTablet [b,b,b,b] S,
                           threadTablet [b,b,b,b] Z
                          ],
                tabletWeft = thread orange
               },
               tSheds = map (replicate 18) [S,S,S,S,S,S,S,S,Z,Z,Z,Z,Z,Z,Z,Z]
              }
  where b = thread black
        g = thread green
        w = thread white

arrowBand = tabletWeave arrowWeave



heartWeave :: TabletWeave
heartWeave =
  TabletWeave {tLoom =
    TabletLoom {tablets = [
                                      threadTablet [b,b,w,w] S,
                                      threadTablet [b,b,w,w] S,
                                      threadTablet [b,b,w,w] S,
                                      threadTablet [b,b,w,w] S,
                                      threadTablet [b,b,w,w] Z,
                                      threadTablet [b,b,w,w] Z,
                                      threadTablet [b,b,w,w] Z,
                                      threadTablet [b,b,w,w] Z
                          ],
                tabletWeft = thread orange
               },
               tSheds = map (replicate 18) [S,S,S,S,S,S,S,S]
              }
  where b = thread blue
        w = thread white

heartBand = tabletWeave heartWeave
