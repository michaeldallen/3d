//NOSTL

use <libmose/mcube.scad>;

module large_drawer(center = [0, 0, 0], color = "lightblue") {
    
    x = 303.761; // wall-to-wall, not faceplace
    y = 256.2;
    z = 78.4;
    
    x_offset = 71.88;
    y_offset = -85.65;
    z_offset = 53.85;
    

    translate([(center.x / 2) * x, (center.y / 2) * y, (center.z / 2) * z]) {
        translate([x_offset - (x/2), y_offset - (y/2), z_offset - (z/2)]) {
            color(color) {
                import("../140pct-SBox_Drawers_Drawer_large_1x.stl");
            }
        }
    }
    if(!is_undef(debug) && debug) {
        translate([0, 0, 0]) {
            color("red") {
                cube([100, 100, 100]);
            }
        }
    }
}





module positioned_drawer() {
    rotate([-90, 0, 0]) {
        large_drawer([0, 1, -0.67]);
    }
}

module part_a(display_text, color = "blue") {

    color(color) {
        emboss_text(
            txt        = display_text, 
            size       = 15, 
            depthofcut = 15.05
        ) {
            positioned_drawer();
        }
    }
    
    module emboss_text(txt = "Text", size = 5, pos = [0, 0, 0], depthofcut = 1) {
        difference() {
            children(); 
            translate([pos[0], pos[1], pos[2] - depthofcut]) {
                linear_extrude(height = depthofcut + 0.01) {
                    text(txt, size   = size, halign = "center", valign = "center");
                }
            }
        }
    }
}

module part_b(display_text, color = "red") {

    color(color) {
        difference() {
            positioned_drawer();
            part_a(display_text);
        }
    }
}

display_text = str("PRUSA XL TOOLS");

//part_a(display_text);
//part_b(display_text);
