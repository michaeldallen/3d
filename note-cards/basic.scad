use <libmose/mcube.scad>;
use <libmose/mcylinder.scad>;
use <libmose/mtube.scad>;
use <mtext.scad>;


inch = 25.4;

//mcube([3 * inch, 5 * inch, 0.2], center = [0, 0, -1], color = "slategrey");

//mcube([2 * inch, 4 * inch, 0.2], center = [0, 0, 1], color = "gainsboro");

mtext("A novice was trying to fix a broken Lisp machine by turning the power off and on.Knight, seeing what the student was doing, spoke sternly: 'You cannot fix a machine by just power-cycling it with no understanding of what is going wrong.' Knight turned the machine off and on. The machine worked.", size = [500, 350], height = 1, frame = true, color =  "green");