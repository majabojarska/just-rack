$fn = 50;

use <front_plate.scad>

// Customizable settings
front_plate_thickness = 4;
front_plate_units = 2;
base_plate_length = 60;
base_plate_thickness = 4;

// Rack module generation
rack_module(
    front_plate_units, 
    front_plate_thickness, 
    base_plate_length, 
    base_plate_thickness
);

// Constants
m4_screw_hole_loose_diam = 4.2;
unit_len = 10; // 1U = 10mm
v_slot_size = 20; // 20x20mm V-Slot
rack_width = 200;
edge_offset = 0.6; // Top/bottom edge additional empty space
base_plate_side_offset = 1;

module rack_module(
    front_plate_units, 
    front_plate_thickness,
    base_plate_length,
    base_plate_thickness
){
    union(){
        // Front plate
        translate([front_plate_thickness,0,0])
        rotate([0,-90,0])
        front_plate(front_plate_units, front_plate_thickness);

        // Base plate
        base_plate_width = rack_width - 2*v_slot_size - 2*base_plate_side_offset;
        base_plate_left_side_offset = v_slot_size+base_plate_side_offset;
        translate([-base_plate_length,base_plate_left_side_offset,0])
        cube([
            base_plate_length,
            base_plate_width,
            base_plate_thickness
        ]);
    }
}