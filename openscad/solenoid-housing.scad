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
halfbox(bw,bh,bd,bwall);

// path of pin
translate ([(bw+bwall*2)/2,(bh+bwall*2)/2,-17]) {
   cylinder(r1=3,r2=3,h=20);
}

translate([0,0,-40]) {
    difference() {
        cube([bw+bwall*2,bh+bwall*2,10+bwall*2]);
        translate([bwall,bwall,bwall]) {
            cube([bw+4,bh,10+4]);
        };
    };
}










