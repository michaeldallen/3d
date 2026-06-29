include <libcablecap_shelf_system--rear_stopper.scad>;

use <libmose/mcube.scad>;


module CableCap_Shelf_System__Rear_Stopper(part = part) {

    union() {
        // centered part

        rotate([90, 180, 0])
        translate([0, -y_part_size/2, 0])
        translate([x_offset, y_offset, z_offset])  // align the part to [0,0,0]
        translate([-x_part_size / 2, -y_part_size / 2, 0]) // center the part
        rotate([90, 0, 90])
        color("salmon")
        import(part);
    }
    
}

if(!is_undef(render_parts) && render_parts) {
    CableCap_Shelf_System__Rear_Stopper();
}

render_parts = 1;
//debug = 1;