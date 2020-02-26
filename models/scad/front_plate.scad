$fn = 50;

// Customizable settings
front_plate_thickness = 4;
front_plate_units = 3;

// Constants
m4_screw_hole_loose_diam = 4.2;
unit_len = 10; // 1U = 10mm
v_slot_size = 20; // 20x20mm V-Slot
rack_width = 200;
edge_offset = 0.6; // Top/bottom edge additional empty space

// Front plate generation
front_plate(front_plate_units, front_plate_thickness);

module front_plate(unit_count, thickness){
    difference(){
        union(){
            plate_height = unit_len*unit_count - edge_offset*2;
            cube([plate_height,rack_width,thickness]);
        }                        
        for(i=[1:unit_count]){ // Screw holes
            translate([-edge_offset,0,0])
            union(){
            translate([unit_len*i-unit_len/2,v_slot_size/2,-1]){
                cylinder(d=m4_screw_hole_loose_diam,h=thickness+2);
            } 
            translate([unit_len*i-unit_len/2,rack_width-v_slot_size/2,-1]){
                cylinder(d=m4_screw_hole_loose_diam,h=thickness+2);
            }       
            }               
        }
    }
}