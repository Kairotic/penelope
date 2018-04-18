pack=0.7;
stretch=3;
module twist(x,y,t) {
    linear_extrude(height = stretch, center = false, convexity = 10, twist = t, $fn=50)
        translate([x, y, 0])
        circle(r = 0.95);
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
a = [0.0,0.0,0.0];
b = [0.0,0.0,0.0];
c = [0.0,0.0,0.0];
d = [0.0,0.0,0.0];
rotate ([0,0,45]) {
rotate([0,0,-90]) translate([0,0,0*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-180]) translate([0,0,-1*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-270]) translate([0,0,-2*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-360]) translate([0,0,-3*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-450]) translate([0,0,-4*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-540]) translate([0,0,-5*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-6*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-7*stretch]) yarnSegment(0,a,b,c,d);

};
};
translate([0,2*pack,0]) {
a = [0.0,0.0,0.0];
b = [0.0,0.0,0.0];
c = [0.0,0.0,0.0];
d = [0.0,0.0,0.0];
rotate ([0,0,45]) {
rotate([0,0,90]) translate([0,0,0*stretch]) yarnSegment(90,a,b,c,d);
rotate([0,0,180]) translate([0,0,-1*stretch]) yarnSegment(90,a,b,c,d);
rotate([0,0,270]) translate([0,0,-2*stretch]) yarnSegment(90,a,b,c,d);
rotate([0,0,360]) translate([0,0,-3*stretch]) yarnSegment(90,a,b,c,d);
rotate([0,0,450]) translate([0,0,-4*stretch]) yarnSegment(90,a,b,c,d);
rotate([0,0,540]) translate([0,0,-5*stretch]) yarnSegment(90,a,b,c,d);
rotate([0,0,630]) translate([0,0,-6*stretch]) yarnSegment(90,a,b,c,d);
rotate([0,0,630]) translate([0,0,-7*stretch]) yarnSegment(0,a,b,c,d);

};
};
translate([0,4*pack,0]) {
a = [1.0,1.0,1.0];
b = [1.0,1.0,1.0];
c = [1.0,1.0,1.0];
d = [1.0,1.0,1.0];
rotate ([0,0,45]) {
rotate([0,0,-90]) translate([0,0,0*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-180]) translate([0,0,-1*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-270]) translate([0,0,-2*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-360]) translate([0,0,-3*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-450]) translate([0,0,-4*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-540]) translate([0,0,-5*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-6*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-7*stretch]) yarnSegment(0,a,b,c,d);

};
};
translate([0,6*pack,0]) {
a = [1.0,1.0,1.0];
b = [1.0,1.0,1.0];
c = [1.0,1.0,1.0];
d = [1.0,1.0,1.0];
rotate ([0,0,45]) {
rotate([0,0,-90]) translate([0,0,0*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-180]) translate([0,0,-1*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-270]) translate([0,0,-2*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-360]) translate([0,0,-3*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-450]) translate([0,0,-4*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-540]) translate([0,0,-5*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-6*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-7*stretch]) yarnSegment(0,a,b,c,d);

};
};
translate([0,8*pack,0]) {
a = [0.0,0.0,0.0];
b = [1.0,1.0,1.0];
c = [1.0,1.0,1.0];
d = [1.0,1.0,1.0];
rotate ([0,0,45]) {
rotate([0,0,-90]) translate([0,0,0*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-180]) translate([0,0,-1*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-270]) translate([0,0,-2*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-360]) translate([0,0,-3*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-450]) translate([0,0,-4*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-540]) translate([0,0,-5*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-6*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-7*stretch]) yarnSegment(0,a,b,c,d);

};
};
translate([0,10*pack,0]) {
a = [0.0,0.0,0.0];
b = [1.0,1.0,1.0];
c = [1.0,1.0,1.0];
d = [0.0,0.0,0.0];
rotate ([0,0,45]) {
rotate([0,0,-90]) translate([0,0,0*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-180]) translate([0,0,-1*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-270]) translate([0,0,-2*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-360]) translate([0,0,-3*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-450]) translate([0,0,-4*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-540]) translate([0,0,-5*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-6*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-7*stretch]) yarnSegment(0,a,b,c,d);

};
};
translate([0,12*pack,0]) {
a = [0.0,0.0,0.0];
b = [1.0,1.0,1.0];
c = [0.0,0.0,0.0];
d = [0.0,0.5019607843137255,0.0];
rotate ([0,0,45]) {
rotate([0,0,-90]) translate([0,0,0*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-180]) translate([0,0,-1*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-270]) translate([0,0,-2*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-360]) translate([0,0,-3*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-450]) translate([0,0,-4*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-540]) translate([0,0,-5*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-6*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-7*stretch]) yarnSegment(0,a,b,c,d);

};
};
translate([0,14*pack,0]) {
a = [0.0,0.0,0.0];
b = [0.0,0.0,0.0];
c = [0.0,0.5019607843137255,0.0];
d = [0.0,0.5019607843137255,0.0];
rotate ([0,0,45]) {
rotate([0,0,-90]) translate([0,0,0*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-180]) translate([0,0,-1*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-270]) translate([0,0,-2*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-360]) translate([0,0,-3*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-450]) translate([0,0,-4*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-540]) translate([0,0,-5*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-6*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-7*stretch]) yarnSegment(0,a,b,c,d);

};
};
translate([0,16*pack,0]) {
a = [0.0,0.0,0.0];
b = [0.0,0.5019607843137255,0.0];
c = [0.0,0.5019607843137255,0.0];
d = [0.0,0.5019607843137255,0.0];
rotate ([0,0,45]) {
rotate([0,0,-90]) translate([0,0,0*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-180]) translate([0,0,-1*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-270]) translate([0,0,-2*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-360]) translate([0,0,-3*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-450]) translate([0,0,-4*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-540]) translate([0,0,-5*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-6*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-7*stretch]) yarnSegment(0,a,b,c,d);

};
};
translate([0,18*pack,0]) {
a = [0.0,0.0,0.0];
b = [0.0,0.5019607843137255,0.0];
c = [0.0,0.5019607843137255,0.0];
d = [0.0,0.5019607843137255,0.0];
rotate ([0,0,45]) {
rotate([0,0,-90]) translate([0,0,0*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-180]) translate([0,0,-1*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-270]) translate([0,0,-2*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-360]) translate([0,0,-3*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-450]) translate([0,0,-4*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-540]) translate([0,0,-5*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-6*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-7*stretch]) yarnSegment(0,a,b,c,d);

};
};
translate([0,20*pack,0]) {
a = [0.0,0.0,0.0];
b = [0.0,0.0,0.0];
c = [0.0,0.5019607843137255,0.0];
d = [0.0,0.5019607843137255,0.0];
rotate ([0,0,45]) {
rotate([0,0,-90]) translate([0,0,0*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-180]) translate([0,0,-1*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-270]) translate([0,0,-2*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-360]) translate([0,0,-3*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-450]) translate([0,0,-4*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-540]) translate([0,0,-5*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-6*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-7*stretch]) yarnSegment(0,a,b,c,d);

};
};
translate([0,22*pack,0]) {
a = [0.0,0.0,0.0];
b = [1.0,1.0,1.0];
c = [0.0,0.0,0.0];
d = [0.0,0.5019607843137255,0.0];
rotate ([0,0,45]) {
rotate([0,0,-90]) translate([0,0,0*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-180]) translate([0,0,-1*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-270]) translate([0,0,-2*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-360]) translate([0,0,-3*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-450]) translate([0,0,-4*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-540]) translate([0,0,-5*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-6*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-7*stretch]) yarnSegment(0,a,b,c,d);

};
};
translate([0,24*pack,0]) {
a = [0.0,0.0,0.0];
b = [1.0,1.0,1.0];
c = [1.0,1.0,1.0];
d = [0.0,0.0,0.0];
rotate ([0,0,45]) {
rotate([0,0,-90]) translate([0,0,0*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-180]) translate([0,0,-1*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-270]) translate([0,0,-2*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-360]) translate([0,0,-3*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-450]) translate([0,0,-4*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-540]) translate([0,0,-5*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-6*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-7*stretch]) yarnSegment(0,a,b,c,d);

};
};
translate([0,26*pack,0]) {
a = [0.0,0.0,0.0];
b = [1.0,1.0,1.0];
c = [1.0,1.0,1.0];
d = [1.0,1.0,1.0];
rotate ([0,0,45]) {
rotate([0,0,-90]) translate([0,0,0*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-180]) translate([0,0,-1*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-270]) translate([0,0,-2*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-360]) translate([0,0,-3*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-450]) translate([0,0,-4*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-540]) translate([0,0,-5*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-6*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-7*stretch]) yarnSegment(0,a,b,c,d);

};
};
translate([0,28*pack,0]) {
a = [1.0,1.0,1.0];
b = [1.0,1.0,1.0];
c = [1.0,1.0,1.0];
d = [1.0,1.0,1.0];
rotate ([0,0,45]) {
rotate([0,0,-90]) translate([0,0,0*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-180]) translate([0,0,-1*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-270]) translate([0,0,-2*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-360]) translate([0,0,-3*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-450]) translate([0,0,-4*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-540]) translate([0,0,-5*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-6*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-7*stretch]) yarnSegment(0,a,b,c,d);

};
};
translate([0,30*pack,0]) {
a = [1.0,1.0,1.0];
b = [1.0,1.0,1.0];
c = [1.0,1.0,1.0];
d = [1.0,1.0,1.0];
rotate ([0,0,45]) {
rotate([0,0,-90]) translate([0,0,0*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-180]) translate([0,0,-1*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-270]) translate([0,0,-2*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-360]) translate([0,0,-3*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-450]) translate([0,0,-4*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-540]) translate([0,0,-5*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-6*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-7*stretch]) yarnSegment(0,a,b,c,d);

};
};
translate([0,32*pack,0]) {
a = [0.0,0.0,0.0];
b = [0.0,0.0,0.0];
c = [0.0,0.0,0.0];
d = [0.0,0.0,0.0];
rotate ([0,0,45]) {
rotate([0,0,90]) translate([0,0,0*stretch]) yarnSegment(90,a,b,c,d);
rotate([0,0,180]) translate([0,0,-1*stretch]) yarnSegment(90,a,b,c,d);
rotate([0,0,270]) translate([0,0,-2*stretch]) yarnSegment(90,a,b,c,d);
rotate([0,0,360]) translate([0,0,-3*stretch]) yarnSegment(90,a,b,c,d);
rotate([0,0,450]) translate([0,0,-4*stretch]) yarnSegment(90,a,b,c,d);
rotate([0,0,540]) translate([0,0,-5*stretch]) yarnSegment(90,a,b,c,d);
rotate([0,0,630]) translate([0,0,-6*stretch]) yarnSegment(90,a,b,c,d);
rotate([0,0,630]) translate([0,0,-7*stretch]) yarnSegment(0,a,b,c,d);

};
};
translate([0,34*pack,0]) {
a = [0.0,0.0,0.0];
b = [0.0,0.0,0.0];
c = [0.0,0.0,0.0];
d = [0.0,0.0,0.0];
rotate ([0,0,45]) {
rotate([0,0,-90]) translate([0,0,0*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-180]) translate([0,0,-1*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-270]) translate([0,0,-2*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-360]) translate([0,0,-3*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-450]) translate([0,0,-4*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-540]) translate([0,0,-5*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-6*stretch]) yarnSegment(-90,a,b,c,d);
rotate([0,0,-630]) translate([0,0,-7*stretch]) yarnSegment(0,a,b,c,d);

};
};
