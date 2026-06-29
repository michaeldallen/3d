//NOSTL

include <libcablecap-medium.scad>;

x_offset = x_base_offset  - x_part_size/2 - dovetail_depth/2;
y_offset = y_base_offset;
z_offset = 0;

dovetail_on_long_axis = true;
dovetail_on_short_axis = false;

part = "Ultimate_CableCap_System--STL_Library/4--Shelf_System/CableCap_Shelf_System--Corner_P1.STL";