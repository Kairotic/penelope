

linear_extrude(height = 10, center = false, convexity = 10, twist = 90, $fn = 100)
    translate([1, 1, 0])
    circle(r = 1);
    
 linear_extrude(height = 10, center = false, convexity = 10, twist = 90, $fn = 100)
    translate([0, 2, 0])
    circle(r = 1);
 
 linear_extrude(height = 10, center = false, convexity = 10, twist = 90, $fn = 100)
    translate([2, 2, 0])
    circle(r = 1);

linear_extrude(height = 10, center = false, convexity = 10, twist = 90, $fn = 100)
    translate([0, 0, 0])
    circle(r = 1);
