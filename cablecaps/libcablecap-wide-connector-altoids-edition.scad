//NOSTL

include <libcablecap-wide.scad>;

use <libmose/mcylinder.scad>;


module altoids_arctic_slug() {
    
    fudge_factor = [1, 1];
    x_part_size = 40 + fudge_factor.x;
    
    y_part_size_min = 21;
    y_part_size_max = 23;
    y_part_fudge = 1;
    y_part_size = 23 + fudge_factor.y;
    
    z_part_size = 76;
    
    part_corner_radius = 3/16 * 25.4;

    union() {

        translate([0, 0, part_floor_height]) {

            //union() { 
            color("lightblue") 
            hull() {

                for(x = [-1, 1]) {
                    for(y = [-1, 1]) {
                        translate([x * ((x_part_size / 2) - part_corner_radius), y * ((y_part_size / 2) - part_corner_radius), 0])
                        mcylinder(d = part_corner_radius * 2, h = 100);



                    }
                }
            }
        }
    }
}


//altoids_arctic_slug();
