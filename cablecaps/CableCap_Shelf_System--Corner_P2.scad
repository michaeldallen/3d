include <libcablecap_shelf_system--corner_p2.scad>;

use <libmose/mcube.scad>;


module CableCap_Shelf_System__Corner_P2(part = part) {

    union() {
        // centered part
        translate([x_offset, y_offset, z_offset])  // align the part to [0,0,0]
        translate([-x_part_size / 2, -y_part_size / 2, 0]) // center the part
        color("salmon")
        import(part);
    }
    
}

if(!is_undef(render_parts) && render_parts) {
    CableCap_Shelf_System__Corner_P2();
}

render_parts = 1;
