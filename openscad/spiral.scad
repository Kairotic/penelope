
module twist(x,y,t) {
    linear_extrude(height = 2, center = false, convexity = 10, twist = t/*, $fn=100*/)
        translate([x, y, 0])
        circle(r = 1);
}

module yarnSegment(t) {    
    twist(-1,1,t);
    twist(1,-1,t);
    twist(1,1,t);
    twist(-1,-1,t);
}


yarnSegment(90);
translate([0,0,2])
  yarnSegment(90);
translate([0,0,4])
  yarnSegment(-90);
translate([0,0,6])
  yarnSegment(-90);
