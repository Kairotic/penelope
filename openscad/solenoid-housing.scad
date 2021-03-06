module box(w,h,d,wall) {
difference() {
    // box
    cube([w+wall*2,h+wall*2,d+wall*2]);
    translate([wall,wall,wall]) {
      // inside
      cube([w,h,d]);
    }
    
    // hole for pin 'front'
    translate ([(w+wall*2)/2,(h+wall*2)/2,-1]) {
        cylinder(r1=4,r2=4,h=6);
    }

    // hole for pin 'back'
    translate ([(w+wall*2)/2,(h+wall*2)/2,d]) {
        cylinder(r1=7,r2=7,h=6);
    }
    
    // hole for wire
    /*
    translate([-1,((h+wall*2)/2)-2,2]) {
       cube([3.5,4,3.5]);
    }
    */
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


module outerbox(bw,bh,bd,bwall) {
    l=25;
    h=bw-0.5;
    give = 0.25;

    // outer
    //translate([l+bwall*2,0,-10]) rotate([0,90,0])
    {
        translate([0-bwall,0-bwall,0-(l+bwall*2)]) {
            difference() {
                cube([h,bh+bwall*4,l+bwall*2]);
                translate([bwall-give,bwall-give,bwall]) {
                    cube([h-bwall*2+give*2,bh+bwall*2+give*2,
                        l+4]);
                };
                translate([bwall+3,bwall+bwall,bwall]) {
                    cube([h-bwall*2,bh,l+4]);
                };
                translate ([h/2+bwall*2+give,(bh+bwall*4)/2,5.5]) {
                    sphere(4);
                }
            
            };
        }
    }
    
    // path of pin

    translate ([(bw+bwall*2)/2,(bh+bwall*2)/2,-17]) {
        cylinder(r1=3,r2=3,h=20);
    }
}



module cone(bw,bh,bd,bwall) {
    //translate ([0,-20,0]) rotate ([0,90,0]) {
    translate ([2.5,10,-29]) rotate ([0,180,90]) {
        difference() {
            cylinder(r1=5,r2=1,h=20);
            // rotate([0,10,0]) cylinder(r1=1,r2=1,h=20);
            rotate([0,90,0]) {
                translate([-20,36,0]) rotate_extrude(convexity = 10)
                translate([36, 0, 0])
                circle(r = 1, $fn = 100);
            }
        }
    }
    
    // hat
    /*
    translate ([0,-20,20]) rotate ([0,90,0]) {
    //translate ([2.5,10,-30]) rotate ([0,180,90]) {
        difference() {
            cylinder(r1=6,r2=1,h=5);
            // rotate([0,10,0]) cylinder(r1=1,r2=1,h=20);
            cylinder(r1=1,r2=1,h=6);
            translate([0,0,-17]) cylinder(r1=6,r2=1,h=20);
        }
    }
    */
}

module matchbox() {
    bw = 13;
    bh = 15.5;
    bd = 30.5;
    bwall=2;

    halfbox(bw,bh,bd,bwall);
    outerbox(bw,bh,bd,bwall);
    cone(bw,bh,bd,bwall);
}

matchbox();
translate([0,21,0]) matchbox();