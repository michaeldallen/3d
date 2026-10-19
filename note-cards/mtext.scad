// BOF

// extends: https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Text
// text(text = "string", size = 10, font = "", ...);
//
// mtext(text, size, height) renders `text` uniformly scaled so it fits
// inside a bounding box of [size.x, size.y], centered within the box, and
// extruded to `height`.  If size has 3 elements, size.z is used as height.
//
// requires OpenSCAD >= 2021.01 (uses textmetrics)

include <mdefaults.scad>;

use <mutil.scad>;

module mtext(text = "text", size = default_size, height = 1, center = false, font = undef, spacing = 1, frame = false, color = undef, manifold_underlap = false, manifold_overlap = false) {

    assert(is_string(text) && len(text) > 0,                  "text must be a non-empty 'string'");
    assert(is_num(size) || (is_list(size) && len(size) >= 2), "size must be 'num', 'array[2]' or 'array[3]'");
    assert(is_num(height) && height > 0,                      "height must be 'num' > 0");

    _font   = is_undef(font) ? "" : font;
    _box    = is_num(size) ? [size, size] : [size.x, size.y];
    _height = (is_list(size) && len(size) == 3 ? size.z : height)
            + (manifold_overlap  ? default_manifold_overlap : 0)
            - (manifold_underlap ? default_manifold_overlap : 0);

    // measure the text at a large base size, then scale uniformly into the box
    _base   = 100;
    _tm     = textmetrics(text = text, size = _base, font = _font, spacing = spacing, halign = "left", valign = "baseline");
    _fitted = min(_box.x / _tm.size.x, _box.y / _tm.size.y) * _base;

    mcenter(center, [_box.x, _box.y, _height]) {
        mcolor(color) {

            translate([_box.x / 2, _box.y / 2, 0]) {
                linear_extrude(height = _height) {
                    text(text = text, size = _fitted, font = _font, spacing = spacing, halign = "center", valign = "center");
                }
            }

            if (frame) {
                linear_extrude(height = _height) {
                    difference() {
                        square([_box.x, _box.y]);
                        offset(delta = -max(_box.x, _box.y) / 100) {
                            square([_box.x, _box.y]);
                        }
                    }
                }
            }
        }
    }
}


// test parts
                mtext("hello", size = [40, 15], height = 1,                            frame = true, color =  "green");
translate([0,  25, 0]) mtext("world", size = [40, 15], height = 1, center =        true, frame = true, color =   "pink");
translate([0,  50, 0]) mtext("todo",  size = 20,       height = 2, center = [-1, -1, 0], frame = true, color = "orange");



// EOF
