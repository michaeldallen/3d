use <CableCap_Shelf_System--Front_Extension.scad>
use <CableCap_Shelf_System--Rear_Stopper.scad>
use <CableCap_Shelf_System--Corner_P1.scad>
use <CableCap_Shelf_System--Corner_P2.scad>

use <libmose/mcube.scad>;

intersection() {
    union() {
        mcube([360, 360, 360], center = true, color = "red");
    }
    union() {
        translate([0, 25.4/2, 0]) {
            for(x = [-2 : 2]) {
                echo(x);

                translate([60 * x, 0, 0]) {
                color("lightblue")
                    hull() {
                        CableCap_Shelf_System__Front_Extension();
                    }
                    CableCap_Shelf_System__Rear_Stopper();
                }

            }
        }

        translate([-(138.176 + 83.820) /2, 0, 0])
        CableCap_Shelf_System__Corner_P1();

        translate([(138.176 + 83.820)/2, 0, 0])
        CableCap_Shelf_System__Corner_P2();
    }
}


color("lime")
hull() {
    translate([0, -20.32, 25.4])
    mcube([320, 15.240, 12.700], center = [0, 0, -1], color = "lime");

    translate([0, 12.700, -12.700])
    translate([0, -20.32, 25.4])
    mcube([320, 15.240, 12.700], center = [0, 0, -1], color = "fuchsia");
}
