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
    

    translate([-148.91, 0, -40.83])
    brace();
    
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


difference() {
frame(extra_interior_height = 0);

translate([-130, -130, 0])
mcube([100, 100, 100], center = true, color = "lightslategrey");
}



$fn = 90;

//color("red") cube([303.761, 10,200], center = true);
//color("red") cube([10, 256.2, 200], center = true);

//mcube([20, 20, 20], color = "red");

module brace() {
    intersection() {
        union() {
            color("fuchsia")
            translate([159.637, 0, 42.47])
            rotate([180, 0, 0])
            import("SBox_Drawers_Drawer_brace--140pct.STL");
            mcube([2, 42.7, 5], center = [0, 0, 1], color = "cyan");
        }
        union() {
            mcube([50, 42.7, 50], center = [0, 0, 1], color = "blue");
        }
    }
}

