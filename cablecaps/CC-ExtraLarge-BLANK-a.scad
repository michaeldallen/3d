// NOSTL

use <libmose/mcube.scad>;

x_offset = -113.601;
y_offset = -151.4475;
z_offset = 0;

x_part_size = 138.2;
y_part_size = 57.11;
z_part_size = 1.524;


module blank_xl() {
    translate([x_offset - x_part_size / 2, y_offset - y_part_size / 2, z_offset]) {
        color("salmon")
        import("CC-ExtraLarge-BLANK-flattened.STL");
    }
}


module smiley() {
// Smiley Face "Ink" Only (2D Profile for Linear Extrusion)
// Adjust the scale or dimensions below as needed for your 3D printed surface.

$fn = 60; // Smooths out the circles and arcs

module smiley_face_ink() {
    // 1. THE EYES
    // Left Eye
    translate([-15, 10]) 
        circle(r = 5);
    
    // Right Eye
    translate([15, 10]) 
        circle(r = 5);
    
    // 2. THE SMILE
    // Created by subtracting a smaller circle from a larger one, 
    // then cutting it in half to leave a perfect bottom arc.
    difference() {
        // Outer smile arc radius and thickness
        difference() {
            circle(r = 20);          // Outer edge of smile
            circle(r = 16);          // Inner edge (yields a 4mm thick smile)
        }
        
        // Mask to cut off the top half of the circle
        translate([-25, 0]) 
            square([50, 25]);
    }
}

// Example usage:
// Un-comment the line below to test the extrusion locally
// linear_extrude(height = 2) smiley_face_ink();

linear_extrude(height = 0.5) smiley_face_ink();


}

/*
difference() {
blank_xl();
translate([0, 0, -0.01]) {
    smiley();
}

}
*/
smiley();

//debug = 1;

if(!is_undef(debug) && debug) {
    mcube([100, 100, 100], center = [0, 0, -1], color = "red");
}

