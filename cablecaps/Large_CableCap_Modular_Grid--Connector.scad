include <libcablecap-large-connector.scad>;

use <libmose/mcube.scad>;


module CableCap_Modular_Grid__Part(part) {
    
    difference() {
        
        union() {    
            translate([x_offset, y_offset, z_offset])  // align the part to [0,0,0]
                translate([-x_part_size / 2, -y_part_size / 2, 0]) // center the part
                    color("salmon")
                        import(part);

            mcube([x_part_size - 20, y_part_size - 20, 5], center = [0, 0, 1], color = "lightgreen");  // fill magnet sockets

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

