use <libmose/mcube.scad>;
use <libmose/mcylinder.scad>;
use <libmose/mtube.scad>;



module part() {

    translate([-110.7263, -1160, -320])
    scale([1.4, 1.4, 1.4])
    color("royalblue")
    import("sbox_drawers_middle_bigger_1x.STL");
    
}




$fn = 90;





/*
color("fuchsia") cube([319.9, 10, 200], center = true);
color("fuchsia") cube([10, 263.55, 200], center = true);
*/

intersection() {
//union() {
    union() {
      // drawer
      part();
    }
    union() {
        // intersection block
        translate([-(319.9/2) - 0.01, 0, 0]) 
        mcube([20, 42.7, 100], center = [-1, 0, 0], color = "red");
    }
}