
module twist(x,y,t) {
    linear_extrude(height = 2, center = false, convexity = 10, twist = t, $fn=20)
        translate([x, y, 0])
        circle(r = 1);
}

module yarnSegment(t) {
    color([0,1,0]);
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
translate([0,0,8])
  yarnSegment(0);
translate([0,0,10])
  yarnSegment(90);
