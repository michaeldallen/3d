use <libmose/mcube.scad>;
use <libmose/mcylinder.scad>;
use <libmose/mtube.scad>;



module part() {

    translate([-100, -1150, -320])
    scale([1.4, 1.4, 1.4])
    color("royalblue")
    import("sbox_drawers_middle_bigger_1x.STL");
    
}

//color("red") cube(300);

module slice() {

    translate([0, 0, 5])
    color("lightblue")
    intersection() {
    union() {
        translate([0, 0, 7])    
        part();
    }
    union() {
        color("red")
        translate([0, 0, -5])
        cube([1000, 1000, 10], center = true);
    }
}
}

// at 140%, 78.4mm top-to-bottom, 77mm usable depth



module bottom() {

    // chop off the top 7mm

    color("lightgreen")
    intersection() {
        union() {
            translate([0, 0, 7])
            part();
        }
        union() {
            color("red")
            translate([0, 0, -500])
            cube([1000, 1000, 1000], center = true);
        }
    }
}

module top() {

    // chop off all but the top 7mm
    
    color("pink")
    intersection() {
        union() {
            translate([0, 0, 7])
            part();
        }
        union() {
            color("red")
            translate([0, 0, 500])
            cube([1000, 1000, 1000], center = true);
        }
    }
}

/*
// baseline model: bottom() + top() = 80mm usable depth

translate([0, 0,  20]) top();
translate([0, 0,   0]) scale([1,1,4.01]) slice();
translate([0, 0, -20]) bottom();
*/


module frame(extra_interior_height = 0) {

    translate([0, 0, (extra_interior_height / 2)]) top();
    scale([1,1, 0.02 + (extra_interior_height / 10)]) slice();
    translate([0, 0, 0 -(extra_interior_height / 2)]) bottom();

}



frame(extra_interior_height = 40);

$fn = 90;

//color("red") cube([303.761, 10,200], center = true);
//color("red") cube([10, 256.2, 200], center = true);


/*
difference() {

    union() {
        part();
    }
    
    
    union() {




        translate([319.9/2 + 7.7/2 + 7.350, 0, 0]) {
        union() {
        color("salmon") 
        hull() {
            mcube([11.876, 10, 10], color = "pink", chamfer = .350);
            mcube([1, 10, 11.876 * 2], color = "green", chamfer = 0.350);
        }
        }
        union() {
        translate([7.7/2, 0, 7.7/2])
        rotate([90, 0, 0])
        difference() {
            mcylinder(h = 30, d = 7.7, color = "green", center = [0, 0, 0]);
            mcylinder(h = 40, d = 3.92, color = "white", center = [0, 0, 0]);
        }
        }
        }


        //color("red") cube([303.761, 10,200], center = true);
        //color("red") cube([10, 256.2, 200], center = true);

        translate([319.9/2 + 7.7 * 2, 0, -70]) {
        rotate([90, 0, 0])
        color("grey")
        hull() {
            mcylinder(h = 400, d = 7.7, color = "grey", center = [0, 0, 0]);
            mcylinder(h = 400, d = 7.7, color = "grey", center = [0, 5, 0]);
        }
        }
 
}
}
*/