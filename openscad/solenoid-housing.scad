module box() {
difference() {
    // box
    cube([13+4,15+4,29+4]);
    translate([2,2,2]) {
      // inside
      cube([13,15,29+3]);
    }
    
    // hole for pin
    translate ([(13+4)/2,(15+4)/2,-1]) {
        cylinder(r1=4,r2=4,h=6);
    }
    
    // hole for wire
    translate([-1,((15+4)/2)-2,2]) {
       cube([3.5,4,3.5]);
    }
};
};

module halfbox() {
    difference() {
        box();
        translate([((13+4)/2),-1,-1]) {
            cube([13+4,15+4+2,29+4+2]);
        }
    }
}

halfbox();

translate ([(13+4)/2,(15+4)/2,-17]) {
   cylinder(r1=3,r2=3,h=20);
}

translate([0,0,-40]) {
    cube([13+4,15+4,10+4]);
    translate([2,2,2]) {
        cube([13,15+4,10+4]);
    };
}