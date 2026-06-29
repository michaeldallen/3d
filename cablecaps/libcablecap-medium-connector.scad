//NOSTL

include <libcablecap-medium.scad>;

x_offset = x_base_offset - x_part_size/2 - dovetail_depth/2;
y_offset = y_base_offset + dovetail_depth/2;
z_offset = 0;

dovetail_on_long_axis = true;
dovetail_on_short_axis = true;

part = "Ultimate_CableCap_System--STL_Library/3--Grid_System/1--Modular_Grids/2--Medium_Grid_Pieces/Medium_CableCap_Modular_Grid--Connector.STL";
