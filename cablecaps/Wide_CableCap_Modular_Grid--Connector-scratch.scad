include <libcablecap-wide-connector.scad>;

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
            upper_bumper = dovetail_top_crop;
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
                        bumper_crop = 1;
                        bumper_bump = 4.75;
                        upper_bumper = dovetail_top_crop;
                        for(y = [-1, 1]) { 
                            translate([0, y * ((y_part_size / 2) + 0.01 + bumper_bump), 0])
                            translate([0, 0, -bumper_size * sqrt(2) / 2 + bumper_crop])
                            rotate([45, 0, 0])
                            mcube([x_part_size + 1, bumper_size, bumper_size], center = [0, 0, 0], color = "red");
                            
                                          
                translate([0, y * ((y_part_size / 2) + bumper_size / 2), 20.024 - upper_bumper])
                translate([0, 0, -bumper_size * sqrt(2) / 2 + bumper_crop])
                mcube([x_part_size + 1, bumper_size, bumper_size], center = [0, 0, 0], color = "lightblue");
                
                            
                            
                        }
                        for(x = [-1, 1]) { 
                            translate([x * ((x_part_size / 2) + 0.01 + bumper_bump), 0, 0])
                            translate([0, 0, -bumper_size * sqrt(2) / 2 + bumper_crop])
                            rotate([0, 45, 0])
                            mcube([bumper_size, y_part_size + 1, bumper_size], center = [0, 0, 0], color = "blue");
                            
                            
                translate([x * ((x_part_size / 2) + bumper_size / 2), 0, 20.024 - upper_bumper])
                translate([0, 0, -bumper_size * sqrt(2) / 2 + bumper_crop])
                mcube([bumper_size, y_part_size + 1, bumper_size], center = [0, 0, 0], color = "orange");
                        }
                    }
                }
            } // c
          
            // fill main chamfer at dovetail base
            if(dovetail_on_long_axis == true) {
                mcube([dovetail_height, y_part_size / 2 + 0.01, 5], center = [0, 1, 1], color = "cyan");
            }
            if(dovetail_on_short_axis == true) {
                mcube([x_part_size / 2 + 0.01, dovetail_height, 5], center = [-1, 0, 1], color = "cyan");
            }
            
        } // b



        union() { // bb
            
            // chamfer flange
            foo = 14.25;
            
            // left side
            union() {
                translate([0, 0, dovetail_height /2])
                rotate([45, 0, 0]) 
                mcube([x_part_size * 2, foo, foo], center = [-1, 0, 0], color = "green");
            }
            
            // top
            union() {
                translate([x_dovetail_spacing / 2, 0, 0])
                translate([0, 0, dovetail_height /2])
                rotate([0, 45, 0]) 
                mcube([foo, y_part_size * 2, foo], center = [0, 1, 0], color = "lightgreen");
                
                translate([-x_dovetail_spacing / 2, 0, 0])
                translate([0, 0, dovetail_height /2])
                rotate([0, 45, 0]) 
                mcube([foo, y_part_size * 2, foo], center = [0, 1, 0], color = "lightblue");
                
            }
        } // bb

    }  // a
}

/* second try
socket_x_gap = 1;
socket_y_gap = 1;
*/

socket_x_gap = 0.1250;
socket_y_gap = 0.1275;

tin_x_bump = 1.500;
tin_y_bump = 0.500;

difference() {
    union() {
        color("lightblue")
        resize([x_socket_size - socket_x_gap, y_socket_size - socket_y_gap, z_part_size - z_socket_size])
        difference() {
            union() {
                mcube([x_socket_size, y_socket_size, z_part_size], color = "lightblue", center = [0, 0, 1]);
            }
            union() {
                color("red")
                CableCap_Modular_Grid__Part(part);
            }
        }



        color("lavender")
        translate([0, 0, z_part_size - z_socket_size * 2])
        intersection() {
            union() {
                translate([0, 0, z_socket_size * 2])
                mcube([x_socket_size - socket_x_gap, y_socket_size - socket_y_gap, z_part_size], center = [0, 0, 1]);
            }
            union() {
                resize([x_socket_size - socket_x_gap, y_socket_size - socket_y_gap, z_part_size - z_socket_size])
                difference() {
                    union() {
                        mcube([x_socket_size, y_socket_size, z_part_size], color = "lightblue", center = [0, 0, 1]);
                    }
                    union() {
                        color("red")
                        CableCap_Modular_Grid__Part(part);
                    }
                }
            }
        }
    }
    union() {
        //color("red") CableCap_Modular_Grid__Part(part);

        //mcube([x_socket_size, y_socket_size, 10], color = "royalblue", center = [0, 0, 1]);

        translate([0, 0, z_socket_size + 2])
        mcube([61 + tin_x_bump, 21 + tin_y_bump, 95], color = "royalblue", center = [0, 0, 1]);
    }
}


for(x = [-1, 1]) {
    
    translate([x * (61 + 18.295 + tin_x_bump)/2, 0, 15])
    color("fuchsia") 
    sphere(r=5, $fn = 60);


    for(y = [-1, 1]) {
        translate([x * (61 + 18.295 - (6.8075 / 2))/2, y * ((21 + 4.7665 - 10 + tin_y_bump) / 2), 15])
        color("cyan") 
        sphere(r=5, $fn = 60);
    }
    
}