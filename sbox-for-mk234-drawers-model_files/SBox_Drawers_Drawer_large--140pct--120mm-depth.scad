module part() {

    translate([140, -47.25, 36.1915])
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
            translate([0, 0, 23/2])    
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
            translate([0, 0, 23/2])
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
            translate([0, 0, 23/2])
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


module drawer(extra_interior_height = 0) {

    translate([0, 0, (extra_interior_height / 2)]) top();
    scale([1,1, 0.02 + (extra_interior_height / 10)]) slice();
    translate([0, 0, 0 -(extra_interior_height / 2)]) bottom();

}

    
module emboss_text(txt = "Text", size = 5, pos = [0, 0, 0], depthofcut = 1) {

    $fn = 90;
    rotate([90, 0, 0])
    translate([pos[0], pos[1], pos[2] - depthofcut / 2]) {
        linear_extrude(height = depthofcut + 0.01) {
            text(txt, size   = size, halign = "center", valign = "center");
        }
    }
}



module part_a(extra_height = 0) {
color("royalblue")
    intersection() {
        union() {
            translate([0, 256.2/2, 0]) {
                drawer(extra_height);
            }
        }
        union() {
            emboss_text(txt = "Desiccant", size = 15, depthofcut = 5);
        }
    }
}

module part_b(extra_height = 0) {
    difference() {
        union() {
            translate([0, 256.2/2, 0]) {
                drawer(extra_height);
            }
        }
        union() {
            emboss_text(txt = "Desiccant", size = 15, depthofcut = 5);
        }
    }
}

extra_height = 0;
part_a(extra_height);
//part_b(extra_height);

//color("red") cube([303.761, 10,200], center = true);
//color("red") cube([10, 256.2, 200], center = true);





