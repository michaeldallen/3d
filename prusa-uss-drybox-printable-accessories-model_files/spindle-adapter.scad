use <libmose/mtube.scad>;

$fn = 180;

h = 64;
od = 55;
id = 51;

peg_height = 20;
peg_width = 10;
peg_depth = 6;

peg_elevation = -((h / 2) - (peg_height / 2));

chamfer = peg_depth;
        
        pd2 = 3;
        ph2 = 18 + 6;
        po2 = 2;
difference() {

    union() {
        color("lightblue") {
            cylinder(d = od, h = h, center = true);
        }

/*
        color("lightgreen")
        translate([0, (id / 2) - peg_depth / 2, peg_elevation]) {
            hull() {
                color("orange") cube([peg_width, (2 * peg_depth) - chamfer, peg_height], center = true);
                color("pink") cube([peg_width, 2 * peg_depth, peg_height - chamfer], center = true); 
            }
        }
*/
        
        
        


        //translate([0, 0, 100])
        translate([0, 0, -h/2])
        translate([0, 0, ph2 / 2])
        translate([0, 0, po2]) {
//            intersection() { 
                color("lavender") 
                hull() {
                    color("cyan")
                    cylinder(h = ph2 - pd2, d = od + pd2 , center = true);

                    color("orange")
                    cylinder(h = ph2, d = od, center = true);
                }
                /*    
                color("red") {
                    cube([10, 100, ph2], center = true);
                    cube([100, 10, ph2], center = true);
                }
                */
//            }
        }

    }
    
    union() {
        color("red") {
            cylinder(d = id, h = h + 1, center = true);
        }
    }
}

translate([0, 0, 0])
mtube(od = od - 0.01, id = id - 1, h = 20, center = true, chamfer = 1);
    