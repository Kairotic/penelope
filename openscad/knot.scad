use <path_extrude.scad>;
shift=1;
pi=3.14159;
for(shift = [0, 360/15]){
    myPoints = [ for(t = [0:72:359]) [cos(t),sin(t)] ];
    myPath = [ for(t = [0:10:359]) [
        (10+1.212*pi*sin(5*t))*cos(t+shift),
        (10+1.212*pi*sin(5*t))*sin(t+shift),
        1.212*pi*cos(5*t)
        ] ];
    path_extrude(exShape=myPoints, exPath=myPath, merge=true);
}
