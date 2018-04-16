
$fn=50;
eps=0.001; // to make sure there's no gap
r=1;
module Ring(r=r){
    rotate_extrude()
    translate( [3,0,0] )circle( r );
}

module Arc(r=r){
    difference(){
        Ring(r);
        translate( [0,0, -2.5] )
        cube( [5,5,5] );
    }
}

module S(r){
    Arc(r=r);
    translate( [-eps,3,0 ] ) // use eps
    rotate( [-90,0,180] )
    translate( [0,-3,0 ] )
    Arc(r=r);
}

difference(){
    S();
    S(r=0.6);
}   