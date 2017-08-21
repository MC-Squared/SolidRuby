#!/usr/bin/env ruby

require 'solidruby'
include SolidRuby

def shape
  (((square(s: 100, c: true) -
  square(s: 50, c: true)) +
  square(s: 15, c: true)
    .translate(x: 50, y: 50)) *
  square(x: 100, y: 30)
    .translate(y: -15)
    .rotate(z: 45)
  ).translate(x: -35, y: -35) -
  circle(r: 5)
    .scale(x: 0.7, y: 1.3)
    .rotate(z: -45) &
  import(f: 'example009.dxf', l: 'body', co: 6, s: 2)
end

shape.save('example015.scad')

# module shape()
# {
#   difference() {
#     translate([ -35, -35 ]) intersection() {
#       union() {
#         difference() {
#           square(100, true);
#           square(50, true);
#         }
#         translate([ 50, 50 ]) square(15, true);
#       }
#       rotate(45) translate([ 0, -15 ]) square([ 100, 30 ]);
#     }
#
#     rotate(-45) scale([ 0.7, 1.3 ]) circle(5);
#   }
#
#   import(file = "example009.dxf", layer = "body", convexity = 6, scale=2);
# }
#
# echo(version=version());
#
# // linear_extrude(convexity = 10, center = true)
# shape();
