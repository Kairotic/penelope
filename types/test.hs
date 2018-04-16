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
  TabletWeave {tLoom = TabletLoom {tablets = [Tablet [w,r,b,y] Z,
                                               Tablet [w,r,b,w] Z,
                                               Tablet [w,w,r,b] Z,
                                               Tablet [b,w,w,r] Z,
                                               Tablet [b,w,w,r] S,
                                               Tablet [w,w,r,b] S,
                                               Tablet [w,r,b,w] S,
                                               Tablet [y,y,y,y] S
        
                                               -- TODO - threading
                                               -- should be done
                                               -- before the flip (?)
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
