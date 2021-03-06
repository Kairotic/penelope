
module twist(x,y,t) {
    linear_extrude(height = 2, center = false, convexity = 10, twist = t, $fn=20)
        translate([x, y, 0])
        circle(r = 1);
}

module yarnSegment(t, a,b,c,d) {
    color(a)
    twist(-1,1,t);
    color(b)
    twist(1,-1,t);
    color(c)
    twist(1,1,t);
    color(d)
    twist(-1,-1,t);
}

a = [0,1,0];
b = [0,0,1];
c = [1,0,0];
d = [1,1,0];

yarnSegment(90,a,b,c,d);
rotate([0,0,-90]) translate([0,0,2])
  yarnSegment(90,a,b,c,d);
rotate([0,0,-180]) translate([0,0,4])
  yarnSegment(-90,a,b,c,d);
rotate([0,0,-90]) translate([0,0,6])
  yarnSegment(-90,a,b,c,d);
translate([0,0,8])
  yarnSegment(0,a,b,c,d);
translate([0,0,10])
  yarnSegment(90,a,b,c,d);
