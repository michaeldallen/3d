// BOF

// extends: https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Text
// text(text = "string", size = 10, font = "", ...);
//
// mtext(text, size, height) renders `text` uniformly scaled so it fits
// inside a bounding box of [size.x, size.y], centered within the box, and
// extruded to `height`.  If size has 3 elements, size.z is used as height.
//
// wrap = true (default) breaks long text into multiple lines at word
// boundaries whenever that makes the rendered text larger.  line_spacing
// sets the line pitch as a multiple of the font size.
//
// requires OpenSCAD >= 2021.01 (uses textmetrics)

include <mdefaults.scad>;

use <mutil.scad>;

// --- word wrap helpers -----------------------------------------------------

function mtext_is_space(c) = c == " " || c == "\t" || c == "\n";

// split `s` into a list of words
function mtext_words(s, i = 0, cur = "", acc = []) =
    i >= len(s) ? (cur == "" ? acc : concat(acc, [cur]))
    : mtext_is_space(s[i]) ? mtext_words(s, i + 1, "", cur == "" ? acc : concat(acc, [cur]))
                           : mtext_words(s, i + 1, str(cur, s[i]), acc);

// join words[from .. to - 1] into a single-space separated string
function mtext_join(words, from, to) =
    from >= to - 1 ? words[from]
                   : str(words[from], [for (i = [from + 1 : to - 1]) str(" ", words[i])]);

// width of words[from .. to - 1] rendered at `size`
function mtext_linewidth(words, from, to, size, font, spacing) =
    textmetrics(text = mtext_join(words, from, to), size = size, font = font, spacing = spacing,
                halign = "left", valign = "baseline").size.x;

// one greedy line: the most words starting at `i` that fit within `limit` at `size`
function mtext_wrapline(words, i, j, limit, size, font, spacing) =
    j >= len(words) ? len(words)
    : mtext_linewidth(words, i, j + 1, size, font, spacing) <= limit
        ? mtext_wrapline(words, i, j + 1, limit, size, font, spacing)
        : j;

// greedy word wrap at `size`: a list of [from, to] word index pairs
function mtext_wraplines(words, limit, size, font, spacing, i = 0) =
    i >= len(words) ? []
                    : let(j = mtext_wrapline(words, i, i + 1, limit, size, font, spacing))
                      concat([[i, j]], mtext_wraplines(words, limit, size, font, spacing, j));

// largest font size, >= `best`, at which `words` wrapped to width `box.x`
// also fits `box.y`; probes wraps at sizes box.y / (n * line_spacing)
function mtext_wrapfit(words, box, font, spacing, line_spacing, best, n = 2) =
    n > len(words) || box.y / (n * line_spacing) <= best ? best :
    let(f     = box.y / (n * line_spacing),
        lines = mtext_wraplines(words, box.x, f, font, spacing),
        m     = len(lines),
        wmax  = max([for (r = lines) mtext_linewidth(words, r[0], r[1], f, font, spacing)]),
        cand  = m < 2 ? 0 : min(f * box.x / wmax, box.y / (m * line_spacing)))
    m < 2 ? best
          : mtext_wrapfit(words, box, font, spacing, line_spacing, max(best, cand), n + 1);

module mtext(text = "text", size = default_size, height = 1, center = false, font = undef, spacing = 1, wrap = true, line_spacing = 1.2, frame = false, color = undef, manifold_underlap = false, manifold_overlap = false) {

    assert(is_string(text) && len(text) > 0,                  "text must be a non-empty 'string'");
    assert(is_num(size) || (is_list(size) && len(size) >= 2), "size must be 'num', 'array[2]' or 'array[3]'");
    assert(is_num(height) && height > 0,                      "height must be 'num' > 0");
    assert(is_num(line_spacing) && line_spacing > 0,          "line_spacing must be 'num' > 0");

    _font   = is_undef(font) ? "" : font;
    _box    = is_num(size) ? [size, size] : [size.x, size.y];
    _height = (is_list(size) && len(size) == 3 ? size.z : height)
            + (manifold_overlap  ? default_manifold_overlap : 0)
            - (manifold_underlap ? default_manifold_overlap : 0);

    // measure the text at a large base size, then scale uniformly into the box
    _base  = 100;
    _words = mtext_words(text);

    // font size fitting the whole text on a single line
    _tm1   = textmetrics(text = text, size = _base, font = _font, spacing = spacing, halign = "left", valign = "baseline");
    _fit1  = min(_box.x / _tm1.size.x, _box.y / _tm1.size.y) * _base;

    // wrapped into multiple lines when that makes the text larger
    _fit   = wrap ? mtext_wrapfit(_words, _box, _font, spacing, line_spacing, _fit1) : _fit1;
    _lines = wrap ? mtext_wraplines(_words, _box.x, _fit, _font, spacing) : [[0, len(_words)]];
    _n     = len(_lines);

    // exact bounding box of the line block at size _fit, then scale to fit the box
    _tms   = [for (r = _lines) textmetrics(text = mtext_join(_words, r[0], r[1]), size = _fit, font = _font, spacing = spacing, halign = "left", valign = "baseline")];
    _pitch = _fit * line_spacing;
    _block = [max([for (t = _tms) t.size.x]), (_n - 1) * _pitch + max([for (t = _tms) t.size.y])];
    _fitb  = _fit * min(_box.x / _block.x, _box.y / _block.y);

    mcenter(center, [_box.x, _box.y, _height]) {
        mcolor(color) {

            translate([_box.x / 2, _box.y / 2, 0]) {
                linear_extrude(height = _height) {
                    for (i = [0 : _n - 1]) {
                        translate([0, ((_n - 1) / 2 - i) * _pitch * (_fitb / _fit), 0]) {
                            text(text = mtext_join(_words, _lines[i][0], _lines[i][1]), size = _fitb, font = _font, spacing = spacing, halign = "center", valign = "center");
                        }
                    }
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
translate([0,  75, 0]) mtext("the quick brown fox jumps over the lazy dog", size = [40, 15], height = 1, frame = true, color =  "cyan");
translate([0, 100, 0]) mtext("pack my box with five dozen liquor jugs",   size = [20, 40], height = 1, frame = true, color =  "plum");



// EOF
