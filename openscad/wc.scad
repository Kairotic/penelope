translate ([0,0,3]) {

dxf_linear_extrude(file="outfile.dxf", height=4);

difference() {
translate([50,50,-3])
  cylinder(r1=52,r2=50,h=3); 

translate([50.5,21,21.5])
sphere(24); 
};
}