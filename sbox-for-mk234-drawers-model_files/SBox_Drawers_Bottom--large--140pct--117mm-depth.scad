module part() {

    translate([140,-50.925,67.5])
    scale([1.4, 1.4, 1.4])
    color("royalblue")
    import("SBox_Drawers_Bottom_1x.STL");
    
}

//color("red") cube(300);

module slice() {

    translate([0, 0, 5])
    color("lightblue")
    intersection() {
    union() {
        translate([0, 0, 0])    
        part();
    }
    union() {
        color("red")
        translate([0, 0, -5])
        cube([1000, 1000, 1], center = true);
    }
}
}

// at 140%, 78.4mm top-to-bottom, 77mm usable depth



module bottom() {

    // chop off the top 7mm

    color("lightgreen")
    intersection() {
        union() {
            translate([0, 0, 0])
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
            translate([0, 0, 0])
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
    scale([1,1, 0.02 + (extra_interior_height / 1)]) slice();
    translate([0, 0, 0 -(extra_interior_height / 2)]) bottom();

}



frame(extra_interior_height = 40);

//translate([0,0,7]) part();

/*
color("red") cube([303.761, 10,200], center = true);
color("red") cube([10, 256.2, 200], center = true);
*/

/*
color("fuchsia") cube([319.9, 10, 200], center = true);
color("fuchsia") cube([10, 263.55, 200], center = true);
*/
//part();


