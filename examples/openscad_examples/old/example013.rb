#!/usr/bin/env ruby

require 'solidruby'
include SolidRuby

r = import(f: 'example013.dxf')
  .linear_extrude(h: 100, center: true, co: 3)

r *= import(f: 'example013.dxf')
  .linear_extrude(h: 100, ce: true, co: 3)
  .rotate(y: 90)

r *= import(f: 'example013.dxf')
  .linear_extrude(h: 100, ce: true, co: 3)
  .rotate(x: 90)

r.save('example013.scad')

# echo(version=version());
#
# intersection() {
#   linear_extrude(height = 100, center = true, convexity= 3)
#     import(file = "example013.dxf");
#   rotate([0, 90, 0])
#     linear_extrude(height = 100, center = true, convexity= 3)
#       import(file = "example013.dxf");
#   rotate([90, 0, 0])
#     linear_extrude(height = 100, center = true, convexity= 3)
#       import(file = "example013.dxf");
# }
