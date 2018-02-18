#!/usr/bin/env ruby

require 'solidruby'
include SolidRuby

def cutout
  r = import(f: "example007.dxf", l: "cutout1")
    .linear_extrude(h: 100)
    .translate(z: -50)
    .rotate(x: 90)

  r *= import(f: "example007.dxf", l: "cutout2")
      .linear_extrude(h: 100)
      .translate(z: -50)
      .rotate(x: 90, z: 90)

  r.render
end

def clip
  cl = import(f: "example007.dxf", l: "dorn")
    .rotate_extrude(convexity: 3, fn: 0, fa: 12, fs: 2)

  [0, 90].each do |r|
    cl -= cutout.rotate(z: r)
  end
  cl
end

# :nocov:
def cutview
  clip.translate(z: -10) - cube(30).center
    .translate(x: 18)
    .rotate(y: -20, z: 20) -

    (clip.translate(z: -10) * cube(30).center
      .translate(x: 18)
      .rotate(y: -20, z: 20)
    )
      .render(c: 5)
      .debug

end
# :nocov:

clip.translate(z: -10).save("example007.scad")

#cutview.save("example007.scad")

#
# module cutout()
# {
#     intersection() {
#       rotate(90, [1, 0, 0])
#         translate([0, 0, -50])
#           linear_extrude(height = 100, convexity = 1)
#             import(file = "example007.dxf", layer = "cutout1");
#
#       rotate(90, [0, 0, 1])
#         rotate(90, [1, 0, 0])
#           translate([0, 0, -50])
#             linear_extrude(height = 100, convexity = 2)
#               import(file = "example007.dxf", layer = "cutout2");
#     }
# }
#
# module clip()
# {
#   difference() {
#     rotate_extrude(convexity = 3, $fn = 0, $fa = 12, $fs = 2) {
#       import(file = "example007.dxf", layer = "dorn");
#     }
#     for (r = [0, 90])
#       rotate(r, [0, 0, 1])
#         cutout();
#   }
# }
#
# module cutview()
# {
#   difference() {
#     difference() {
#       translate([0, 0, -10]) clip();
#
#       rotate(20, [0, 0, 1])
#         rotate(-20, [0, 1, 0])
#           translate([18, 0, 0])
#             cube(30, center = true);
#     }
#
#     # render(convexity = 5) intersection() {
#       translate([0, 0, -10])
#         clip();
#
#       rotate(20, [0, 0, 1])
#         rotate(-20, [0, 1, 0])
#           translate([18, 0, 0])
#             cube(30, center = true);
#     }
#   }
# }
#
# echo(version=version());
#
# translate([0, 0, -10]) clip();
#
# // cutview();
