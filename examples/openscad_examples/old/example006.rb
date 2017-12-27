#!/usr/bin/env ruby

require 'solidruby'
include SolidRuby

def example006
  # 9x9 grid of points on a dice
  pos = [
    [0, 0, 0, 0, 1, 0, 0, 0, 0],
    [0, 0, 1, 0, 0, 0, 1, 0, 0],
    [1, 0, 0, 0, 1, 0, 0, 0, 1],
    [1, 0, 1, 0, 0, 0, 1, 0, 1],
    [1, 0, 1, 0, 1, 0, 1, 0, 1],
    [1, 0, 1, 1, 0, 1, 1, 0, 1],
  ]

  faces = [:top, :left, :front, :back, :right, :bottom]

  # only used for placement, because we can't place_onto a rounded_cube
  c = cube(100, 100, 100)
  # we use the rounded cube helper rather than the edge profile
  # this is actually a hull of 8 spheres
  res = rounded_cube(x: 100, y: 100, z: 100, r: 10)

  faces.each_with_index do |f, i|
    pos[i].each_with_index do |use, j|
      if use != 0
        edge_offset = -30 + -20 * (j % 3)
        corner_offset = -25 + -25 * (j / 3)
        res -= sphere(r: 10).place onto: c, face: f, edge: :left, corner: :top, edge_offset: edge_offset, corner_offset: corner_offset
      end
    end
  end

  res
end

example006.save('example006.scad')

# module example006()
# {
#   module edgeprofile()
#   {
#     render(convexity = 2) difference() {
#       cube([20, 20, 150], center = true);
#       translate([-10, -10, 0])
#         cylinder(h = 80, r = 10, center = true);
#       translate([-10, -10, +40])
#         sphere(r = 10);
#       translate([-10, -10, -40])
#         sphere(r = 10);
#     }
#   }
#
#   difference() {
#     cube(100, center = true);
#     for (rot = [ [0, 0, 0], [1, 0, 0], [0, 1, 0] ]) {
#       rotate(90, rot)
#         for (p = [[+1, +1, 0], [-1, +1, 90], [-1, -1, 180], [+1, -1, 270]]) {
#           translate([ p[0]*50, p[1]*50, 0 ])
#             rotate(p[2], [0, 0, 1])
#               edgeprofile();
#         }
#     }
#     for (i = [
#       [ 0, 0, [ [0, 0] ] ],
#       [ 90, 0, [ [-20, -20], [+20, +20] ] ],
#       [ 180, 0, [ [-20, -25], [-20, 0], [-20, +25], [+20, -25], [+20, 0], [+20, +25] ] ],
#       [ 270, 0, [ [0, 0], [-25, -25], [+25, -25], [-25, +25], [+25, +25] ] ],
#       [ 0, 90, [ [-25, -25], [0, 0], [+25, +25] ] ],
#       [ 0, -90, [ [-25, -25], [+25, -25], [-25, +25], [+25, +25] ] ]
#     ]) {
#     rotate(i[0], [0, 0, 1])
#       rotate(i[1], [1, 0, 0])
#         translate([0, -50, 0])
#           for (j = i[2]) {
#             translate([j[0], 0, j[1]]) sphere(10);
#           }
#     }
#   }
# }
#
# echo(version=version());
#
# example006();
