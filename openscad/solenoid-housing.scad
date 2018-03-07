module box() {
difference() {
    // size of inside
    w = 13;
    h = 15;
    d = 29;
    wall = 2;
    // box
    cube([w+wall*2,h+wall*2,d+wall*2]);
    translate([wall,wall,wall]) {
      // inside
      cube([w,h,d+wall+1]);
    }
    
    // hole for pin
    translate ([(w+wall*2)/2,(h+wall*2)/2,-1]) {
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
    difference() {
        cube([13+4,15+4,10+4]);
        translate([2,2,2]) {
            cube([13+4,15,10+4]);
        };
    };
}