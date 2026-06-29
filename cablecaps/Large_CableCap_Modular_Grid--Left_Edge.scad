include <libcablecap-large-left_edge.scad>;

use <libmose/mcube.scad>;


module CableCap_Modular_Grid__Part(part) {
    
    difference() {
        
        union() {    
            intersection() {
                union() {
                    translate([x_offset, y_offset, z_offset])  // align the part to [0,0,0]
                    translate([-x_part_size / 2, -y_part_size / 2, 0]) // center the part
                    color("salmon")
                    import(part);

                    mcube([x_part_size - 20, y_part_size - 20, 5], center = [0, 0, 1], color = "lightgreen");  // fill magnet sockets
                }

                translate([0, 0, -0.01])      
                mcube([x_part_size + 0.02, y_part_size + 0.02, z_part_size + 0.02], color = "red", center = [0, 0, 1]);

            }

        }
        
        union() {
            bumper_size = 9;
            bumper_crop = 1;
            upper_bumper = .4;
            for(y = [-1, 1]) { 
                translate([0, y * ((y_part_size / 2) + 0.01), 0])
                translate([0, 0, -bumper_size * sqrt(2) / 2 + bumper_crop])
                rotate([45, 0, 0])
                mcube([x_part_size + 1, bumper_size, bumper_size], center = [0, 0, 0], color = "red");
                
                translate([0, y * ((y_part_size / 2) + bumper_size / 2), 20.024 - upper_bumper])
                translate([0, 0, -bumper_size * sqrt(2) / 2 + bumper_crop])
                mcube([x_part_size + 1, bumper_size, bumper_size], center = [0, 0, 0], color = "lightblue");
                
            }
            for(x = [-1, 1]) { 
                translate([x * ((x_part_size / 2) + 0.01), 0, 0])
                translate([0, 0, -bumper_size * sqrt(2) / 2 + bumper_crop])
                rotate([0, 45, 0])
                mcube([bumper_size, y_part_size + 1, bumper_size], center = [0, 0, 0], color = "blue");

                translate([x * ((x_part_size / 2) + bumper_size / 2), 0, 20.024 - upper_bumper])
                translate([0, 0, -bumper_size * sqrt(2) / 2 + bumper_crop])
                mcube([bumper_size, y_part_size + 1, bumper_size], center = [0, 0, 0], color = "orange");
                
            }
        }
    }
}


CableCap_Modular_Grid__Part(part);


module chamfer_dovetail() {

    intersection() {  // a
        union() { // b
            difference() { // c
                union() {
                    translate([x_offset, y_offset, z_offset])  // align the part to [0,0,0]
                    translate([-x_part_size / 2, -y_part_size / 2, 0]) // center the part
                    color("salmon")
                    import(part);
                }
                union() {

                    translate([0, 0, -0.01])
                    mcube([x_part_size + 0.02, y_part_size + 0.02, z_part_size + 0.02], color = "red", center = [0, 0, 1]);

                    union() {
                        bumper_size = 9;
                        bumper_crop = 2;
                        bumper_bump = 4.75;
                        upper_bumper = .4;
                        for(y = [-1, 1]) { 
                            translate([0, y * ((y_part_size / 2) + 0.01 + bumper_bump), 0])
                            translate([0, 0, -bumper_size * sqrt(2) / 2 + bumper_crop])
                            rotate([45, 0, 0])
                            mcube([x_part_size + 1, bumper_size, bumper_size], center = [0, 0, 0], color = "red");
                        }
                        for(x = [-1, 1]) { 
                            translate([x * ((x_part_size / 2) + 0.01 + bumper_bump), 0, 0])
                            translate([0, 0, -bumper_size * sqrt(2) / 2 + bumper_crop])
                            rotate([0, 45, 0])
                            mcube([bumper_size, y_part_size + 1, bumper_size], center = [0, 0, 0], color = "blue");
                        }
                    }
                }
            } // c
            
            // fill main chamfer at dovetail base
            if(dovetail_on_long_axis == true) {
                mcube([10.160, y_part_size / 2 + 0.01, 5], center = [0, 1, 1], color = "cyan");
            }
            if(dovetail_on_short_axis == true) {
                mcube([x_part_size / 2 + 0.01, 10.160, 5], center = [-1, 0, 1], color = "cyan");
            }
        } // b



        union() { // bb
            
            // chamfer flange
            
            translate([0, 0, 9.5])
            rotate([45, 0, 0]) 
            mcube([x_part_size * 2, 20, 20], center = [-1, 0, 0], color = "green");

            translate([0, 0, 9.5])
            rotate([0, 45, 0]) 
            mcube([20, y_part_size * 2, 20], center = [0, 1, 0], color = "lightgreen");
        } // bb

    }  // a
}

chamfer_dovetail();
