dxf_linear_extrude(file="outfile.dxf", height=8);

translate([50,50,-3])
  cylinder(r1=52,r2=50,h=3); 
  
translate([50,24,0])
sphere(10);