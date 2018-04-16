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
  TabletWeave {tLoom = TabletLoom {tablets = [Tablet [a,a,a,a] Z,
                                               Tablet [y,z,x,y] Z,
                                               Tablet [y,y,z,x] Z,
                                               Tablet [x,y,y,z] Z,
                                               Tablet [x,y,y,z] S,                                                                                     Tablet [y,y,z,x] S,
                                               Tablet [y,z,x,y] S,
                                               Tablet [a,a,a,a] S,
                                               -- TODO - threading
                                               -- should be done
                                               -- before the flip (?)
                                               {-
                                               Tablet [x,z,y,y] S,
                                               Tablet [y,x,z,y] S,
                                               Tablet [y,y,x,z] S,
                                               Tablet [a,a,a,a] S-}
                                             ],
                                    tabletWeft = thread orange
                                  },
                tSheds = map (replicate 8) [S,S,S,S,Z,Z,Z,Z]
              }
  where a = thread yellow
        x = thread brown
        y = thread white
        z = thread red

daveBand = tabletWeave daveWeave
