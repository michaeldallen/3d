module part() {
translate([0, 0, 36.1915])
scale([1.4, 1.4, 1.4])
color("royalblue")
import("SBox_Drawers_Drawer_large_1x.STL");
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

    // raise 7mm to make 70mm usable depth below the line
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

    // raise 10mm to make 10mm top section
    color("pink")
    intersection() {
        union() {
            translate([0, 0, 10])
            part();
        }
        union() {
            color("red")
            translate([0, 0, 500])
            cube([1000, 1000, 1000], center = true);
        }
    }
}


// baseline model: bottom() + top() = 80mm usable depth
translate([0, 0, 20])
top();

translate([0, 0, -20])
bottom();

scale([1,1,4.01])
slice();