#!/usr/bin/env ruby

require 'solidruby'
include SolidRuby

r1 = import(f: "example008.dxf", l: "G")
  .linear_extrude(h: 50, co: 3)
  .translate(x: -25, y: -25, z: -25)

r1 *= import(f: "example008.dxf", l: "E")
  .linear_extrude(h: 50, co: 3)
  .translate(x: -25, y: -125, z: -25)
  .rotate(x: 90)

r1 *= import(f: "example008.dxf", l: "B")
  .linear_extrude(h: 50, co: 3)
  .translate(x: -125, y: -125, z: -25)
  .rotate(y: 90)

r2 = import(f: "example008.dxf", l: "X")
  .linear_extrude(h: 52, co: 1)
  .translate(x: -125, y: -25, z: -26)

r2 *= import(f: "example008.dxf", l: "X")
  .linear_extrude(h: 52, co: 1)
  .translate(x: -125, y: -25, z: -26)
  .rotate(y: 90)

(r1 - r2).save("example008.scad")

# echo(version=version());
#
# difference() {

#   intersection() {
#     translate([ -25, -25, -25])
#       linear_extrude(height = 50, convexity = 3)
#         import(file = "example008.dxf", layer = "G");
#
#     rotate(90, [1, 0, 0])
#       translate([ -25, -125, -25])
#         linear_extrude(height = 50, convexity = 3)
#           import(file = "example008.dxf", layer = "E");
#
#     rotate(90, [0, 1, 0])
#       translate([ -125, -125, -25])
#         linear_extrude(height = 50, convexity = 3)
#           import(file = "example008.dxf", layer = "B");
#   }
#
#   intersection() {
#     translate([ -125, -25, -26])
#       linear_extrude(height = 52, convexity = 1)
#         import(file = "example008.dxf", layer = "X");
#
#     rotate(90, [0, 1, 0])
#       translate([ -125, -25, -26])
#         linear_extrude(height = 52, convexity = 1)
#           import(file = "example008.dxf", layer = "X");
#   }
# }
