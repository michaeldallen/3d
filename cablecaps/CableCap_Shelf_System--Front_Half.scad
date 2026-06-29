use <CableCap_Shelf_System--Front_Extension.scad>
use <CableCap_Shelf_System--Corner_P1.scad>
use <CableCap_Shelf_System--Corner_P2.scad>

use <libmose/mcube.scad>;

intersection() {
    union() {
        mcube([360, 360, 360], center = true, color = "red");
    }
    union() {
        color("lightblue")
        hull() {
            translate([0, 25.4/2, 0])
            CableCap_Shelf_System__Front_Extension();

        }

        color("pink")
        hull() {
            translate([-50, 25.4/2, 0])
            CableCap_Shelf_System__Front_Extension();

        }

        color("lightgreen")
        hull() {
            translate([50, 25.4/2, 0])
            CableCap_Shelf_System__Front_Extension();

        }

        translate([-(138.176 + 83.820) /2, 0, 0])
        CableCap_Shelf_System__Corner_P1();

        translate([(138.176 + 83.820)/2, 0, 0])
        CableCap_Shelf_System__Corner_P2();
    }
}