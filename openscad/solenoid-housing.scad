module box() {
difference() {
    // box
    cube([13+4,15+4,29+4]);
    translate([2,2,4]) {
      cube([13,15,29+1]);
    }
    
    // hole for pin
    cube([13+4,15+4,29+4]);
    translate ([(13+4)/2,(15+4)/2,-1]) {
        cylinder(r1=4,r2=4,h=6);
    }
    
    // hole for wire
    translate([-1,((15+4)/2)-2,-1]) {
       cube([2,4,5]);
    }
};
};

box();