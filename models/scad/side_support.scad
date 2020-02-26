$fn = 50;

// Customizable settings
side_support_unit_count = 6;
side_support_thickness = 3;

// Rack module generation
side_support(
    side_support_unit_count,
    side_support_thickness
);

// Constants
m4_screw_hole_loose_diam = 4.2;
unit_len = 10; // 1U = 10mm
v_slot_size = 20; // 20x20mm V-Slot
rack_width = 200;
edge_offset = 0.6; // Top/bottom edge additional empty space
fillet_radius = 3;

module side_support(
    unit_count,
    thickness 
){
    difference(){
        translate([fillet_radius,fillet_radius,0]){ // Creates main plate
            minkowski(){
                cylinder(r=fillet_radius, h=1);
                cube([
                    unit_len*unit_count-2*fillet_radius-2*edge_offset,
                    rack_width-2*fillet_radius,
                    thickness-1
                ]);
            }
        }
        union(){ // Models to remove from main plate
            hole_count_per_unit = rack_width/unit_len-2;

            translate([
                (m4_screw_hole_loose_diam+unit_len/2)/2,
                v_slot_size/2,
                0
            ])
            for(unit_num=[0:unit_count-1]){
                for(hole_num=[0:hole_count_per_unit]){ 
                    constant_x_offset = (unit_len/2-m4_screw_hole_loose_diam)/2-edge_offset;
                    
                    if(hole_num!=1 && hole_num!=hole_count_per_unit-1){
                        // Holes colliding with V-Slot rail are ignored
                        current_x_offset = constant_x_offset+ unit_num*unit_len;
                        
                        translate([current_x_offset, hole_num*unit_len,-1])
                        cylinder(d=m4_screw_hole_loose_diam,h=thickness+3);
                    }
                }
            }
        }
    }
}