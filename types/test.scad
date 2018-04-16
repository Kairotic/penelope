pack=2;
module twist(x,y,t) {
    linear_extrude(height = 2, center = false, convexity = 10, twist = t, $fn=50)
        translate([x, y, 0])
        circle(r = 1);
}

module yarnSegment(t, a,b,c,d) {
        color(a)
    twist(-1,1,t);
    color(b)
    twist(-1,-1,t);
    color(c)
    twist(1,-1,t);
    color(d)    
    twist(1,1,t);
}translate([0,0*pack,0]) {
a = [1.0,1.0,0.0];
b = [1.0,1.0,0.0];
c = [1.0,1.0,0.0];
d = [1.0,1.0,0.0];
rotate ([0,0,45]) {
rotate([0,0,90]) translate([0,0,0]) yarnSegment(90,a,b,c,d);
rotate([0,0,180]) translate([0,0,-2]) yarnSegment(90,a,b,c,d);
rotate([0,0,270]) translate([0,0,-4]) yarnSegment(90,a,b,c,d);
rotate([0,0,270]) translate([0,0,-6]) yarnSegment(0,a,b,c,d);
rotate([0,0,180]) translate([0,0,-8]) yarnSegment(-90,a,b,c,d);
rotate([0,0,90]) translate([0,0,-10]) yarnSegment(-90,a,b,c,d);
rotate([0,0,0]) translate([0,0,-12]) yarnSegment(-90,a,b,c,d);
rotate([0,0,0]) translate([0,0,-14]) yarnSegment(0,a,b,c,d);

};
};
translate([0,2*pack,0]) {
a = [1.0,1.0,1.0];
b = [1.0,0.0,0.0];
c = [0.6470588235294119,0.16470588235294117,0.16470588235294117];
d = [1.0,1.0,1.0];
rotate ([0,0,45]) {
rotate([0,0,90]) translate([0,0,0]) yarnSegment(90,a,b,c,d);
rotate([0,0,180]) translate([0,0,-2]) yarnSegment(90,a,b,c,d);
rotate([0,0,270]) translate([0,0,-4]) yarnSegment(90,a,b,c,d);
rotate([0,0,270]) translate([0,0,-6]) yarnSegment(0,a,b,c,d);
rotate([0,0,180]) translate([0,0,-8]) yarnSegment(-90,a,b,c,d);
rotate([0,0,90]) translate([0,0,-10]) yarnSegment(-90,a,b,c,d);
rotate([0,0,0]) translate([0,0,-12]) yarnSegment(-90,a,b,c,d);
rotate([0,0,0]) translate([0,0,-14]) yarnSegment(0,a,b,c,d);

};
};
translate([0,4*pack,0]) {
a = [1.0,1.0,1.0];
b = [1.0,1.0,1.0];
c = [1.0,0.0,0.0];
d = [0.6470588235294119,0.16470588235294117,0.16470588235294117];
rotate ([0,0,45]) {
rotate([0,0,90]) translate([0,0,0]) yarnSegment(90,a,b,c,d);
rotate([0,0,180]) translate([0,0,-2]) yarnSegment(90,a,b,c,d);
rotate([0,0,270]) translate([0,0,-4]) yarnSegment(90,a,b,c,d);
rotate([0,0,270]) translate([0,0,-6]) yarnSegment(0,a,b,c,d);
rotate([0,0,180]) translate([0,0,-8]) yarnSegment(-90,a,b,c,d);
rotate([0,0,90]) translate([0,0,-10]) yarnSegment(-90,a,b,c,d);
rotate([0,0,0]) translate([0,0,-12]) yarnSegment(-90,a,b,c,d);
rotate([0,0,0]) translate([0,0,-14]) yarnSegment(0,a,b,c,d);

};
};
translate([0,6*pack,0]) {
a = [0.6470588235294119,0.16470588235294117,0.16470588235294117];
b = [1.0,1.0,1.0];
c = [1.0,1.0,1.0];
d = [1.0,0.0,0.0];
rotate ([0,0,45]) {
rotate([0,0,90]) translate([0,0,0]) yarnSegment(90,a,b,c,d);
rotate([0,0,180]) translate([0,0,-2]) yarnSegment(90,a,b,c,d);
rotate([0,0,270]) translate([0,0,-4]) yarnSegment(90,a,b,c,d);
rotate([0,0,270]) translate([0,0,-6]) yarnSegment(0,a,b,c,d);
rotate([0,0,180]) translate([0,0,-8]) yarnSegment(-90,a,b,c,d);
rotate([0,0,90]) translate([0,0,-10]) yarnSegment(-90,a,b,c,d);
rotate([0,0,0]) translate([0,0,-12]) yarnSegment(-90,a,b,c,d);
rotate([0,0,0]) translate([0,0,-14]) yarnSegment(0,a,b,c,d);

};
};
translate([0,8*pack,0]) {
a = [0.6470588235294119,0.16470588235294117,0.16470588235294117];
b = [1.0,0.0,0.0];
c = [1.0,1.0,1.0];
d = [1.0,1.0,1.0];
rotate ([0,0,45]) {
rotate([0,0,-90]) translate([0,0,0]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-180]) translate([0,0,-2]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-270]) translate([0,0,-4]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-270]) translate([0,0,-6]) yarnSegment(0,a,b,c,d);
rotate([0,0,-180]) translate([0,0,-8]) yarnSegment(90,a,b,c,d);
rotate([0,0,-90]) translate([0,0,-10]) yarnSegment(90,a,b,c,d);
rotate([0,0,0]) translate([0,0,-12]) yarnSegment(90,a,b,c,d);
rotate([0,0,0]) translate([0,0,-14]) yarnSegment(0,a,b,c,d);

};
};
translate([0,10*pack,0]) {
a = [1.0,1.0,1.0];
b = [0.6470588235294119,0.16470588235294117,0.16470588235294117];
c = [1.0,0.0,0.0];
d = [1.0,1.0,1.0];
rotate ([0,0,45]) {
rotate([0,0,-90]) translate([0,0,0]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-180]) translate([0,0,-2]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-270]) translate([0,0,-4]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-270]) translate([0,0,-6]) yarnSegment(0,a,b,c,d);
rotate([0,0,-180]) translate([0,0,-8]) yarnSegment(90,a,b,c,d);
rotate([0,0,-90]) translate([0,0,-10]) yarnSegment(90,a,b,c,d);
rotate([0,0,0]) translate([0,0,-12]) yarnSegment(90,a,b,c,d);
rotate([0,0,0]) translate([0,0,-14]) yarnSegment(0,a,b,c,d);

};
};
translate([0,12*pack,0]) {
a = [1.0,1.0,1.0];
b = [1.0,1.0,1.0];
c = [0.6470588235294119,0.16470588235294117,0.16470588235294117];
d = [1.0,0.0,0.0];
rotate ([0,0,45]) {
rotate([0,0,-90]) translate([0,0,0]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-180]) translate([0,0,-2]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-270]) translate([0,0,-4]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-270]) translate([0,0,-6]) yarnSegment(0,a,b,c,d);
rotate([0,0,-180]) translate([0,0,-8]) yarnSegment(90,a,b,c,d);
rotate([0,0,-90]) translate([0,0,-10]) yarnSegment(90,a,b,c,d);
rotate([0,0,0]) translate([0,0,-12]) yarnSegment(90,a,b,c,d);
rotate([0,0,0]) translate([0,0,-14]) yarnSegment(0,a,b,c,d);

};
};
translate([0,14*pack,0]) {
a = [1.0,1.0,0.0];
b = [1.0,1.0,0.0];
c = [1.0,1.0,0.0];
d = [1.0,1.0,0.0];
rotate ([0,0,45]) {
rotate([0,0,-90]) translate([0,0,0]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-180]) translate([0,0,-2]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-270]) translate([0,0,-4]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-270]) translate([0,0,-6]) yarnSegment(0,a,b,c,d);
rotate([0,0,-180]) translate([0,0,-8]) yarnSegment(90,a,b,c,d);
rotate([0,0,-90]) translate([0,0,-10]) yarnSegment(90,a,b,c,d);
rotate([0,0,0]) translate([0,0,-12]) yarnSegment(90,a,b,c,d);
rotate([0,0,0]) translate([0,0,-14]) yarnSegment(0,a,b,c,d);

};
};
