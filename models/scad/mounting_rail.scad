$fn = 50;

// Customizable settings
mounting_rail_length = 500;

// Constants
m4_screw_hole_diam = 3.8;
unit_len = 10; // 1U = 10mm

// Mounting rail generation
mounting_rail(unit_count=mounting_rail_length/unit_len);

module mounting_rail(unit_count){
    difference(){
        union(){
            translate([-2.4,0,4]){ // Top
                cube([4.8,unit_len*unit_count,1.5]);
            }    
            translate([-2.4,unit_len*unit_count,0]){ // Bottom polygon extrusion
                rotate([90,0,0]){
                    linear_extrude(unit_len*unit_count){
                        polygon(points=[[0,0],[4.8,0],[7,4],[-2.2,4]]);
                    }
                }
            }
        }                        
        for(i=[1:unit_count]){ // Screw holes
            translate([0,unit_len*i-unit_len/2,-1]){
                cylinder(d=3.8,h=10);
            }                       
        }
    }
}
