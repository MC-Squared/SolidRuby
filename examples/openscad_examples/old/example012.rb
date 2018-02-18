#!/usr/bin/env ruby

require 'solidruby'
include SolidRuby

r = sphere(r: 20) - import(f: 'example012.stl', co: 5)
  .rotate(x: 180, z: 180)
  .translate(x: -2.92, y: 0.5, z: 20)

r.save('example012.scad')

# // example012.stl is generated from Basics/LetterBlock.scad
#
# echo(version=version());
#
# difference() {
#   sphere(20);
#
#   translate([ -2.92, 0.5, +20 ])
#     rotate([180, 0, 180])
#       import("example012.stl", convexity = 5);
# }
