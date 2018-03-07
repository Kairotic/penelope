
    or = 10;
    cylinder(h=10, r1=or, r2=or, $fn=50);
    ir=2;
    translate([0,0,-5]) {
      cylinder(h=20, r1=ir, r2=ir, $fn=50);
    };