use <path_extrude.scad>;
myPoints = [ for(t = [0:18:359]) 2.5*[cos(t),sin(t)] ];
// https://en.wikipedia.org/wiki/Trefoil_knot
myPath = [ for(t = [0:3.6:359]) [
    4*(sin(t) + 2*sin(2*t)),
    4*(cos(t) - 2*cos(2*t)),
    5*(-sin(3*t))] ];
path_extrude(exPath=myPath, exShape=myPoints, merge=true);
//cylinder(d1=10, d2=2, h=10, $fn=50);
//translate([0,0,9.8]) sphere(d=2, $fn=48);
