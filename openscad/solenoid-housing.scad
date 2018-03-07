module box(w,h,d,wall) {
difference() {
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
    translate([-1,((h+wall*2)/2)-2,2]) {
       cube([3.5,4,3.5]);
    }
};
};

module halfbox(w,h,d,wall) {
    difference() {
        box(w,h,d,wall);
        translate([((w+(wall*2))/2),-1,-1]) {
            cube([w+(wall*2),
                  h+(wall*2)+2,
                  d+(wall*2)+2]);
        }
    }
}

bw = 13;
bh = 15;
bd = 29;
bwall=2;

union() {
halfbox(bw,bh,bd,bwall);
l=25;
h=bh/2+bwall+bwall/2+bwall;
translate([0-bwall,0-bwall,0-(l+bwall*2)-0]) {
    difference() {
        cube([h,bh+bwall*4,l+bwall*2]);
        translate([bwall,bwall,bwall]) {
            cube([h,bh+bwall*2,l]);
        };
    };
}
}

// path of pin
translate ([(bw+bwall*2)/2,(bh+bwall*2)/2,-17]) {
   cylinder(r1=3,r2=3,h=20);
}











