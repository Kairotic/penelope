
module twist(x,y) {
    linear_extrude(height = 10, center = false, convexity = 10, twist = 90, $fn = 100)
        translate([x, y, 0])
        circle(r = 1);
}

twist(0,1);