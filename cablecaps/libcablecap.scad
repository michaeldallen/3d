//NOSTL

dovetail_depth_measured_in_prusaslicer = 4.191;
dovetail_depth_measured_in_openscad = 4.1923;

dovetail_depth = dovetail_depth_measured_in_openscad;
dovetail_height = 10.160;
dovetail_spacing = 37.592;
dovetail_top_crop = 0.4;


x_dovetail_spacing = 50.292;

part_floor_height = 5.08;

if(!is_undef(debug) && debug) {
    mcube([100, 100, 100], center = [-1,-1, 0], color = "red");
}
