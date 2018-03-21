
module twist(x,y) {
    linear_extrude(height = 2, center = false, convexity = 10, twist = 90, $fn = 100)
        translate([x, y, 0])
        circle(r = 1);
}

module yarnSegment() {    
    twist(-1,1);
    twist(1,-1);
    twist(1,1);
    twist(-1,-1);
}


yarnSegment();
translate([0,0,2])
  yarnSegment();