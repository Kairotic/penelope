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

