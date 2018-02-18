#!/usr/bin/env ruby

require 'solidruby'
include SolidRuby

def blk1
  cube(65, 28, 28).center
end

def blk2
  cube(60, 28, 14).center
    .translate(z: 7.5) -
  cube(8, 32, 32).center
end

def chop
  import(f: 'example016.stl', co: 12)
    .translate(x: -18)
end

r = blk1
[0, 90, 180, 270].each do |a|
  r -= (blk2 - chop)
    .render(co: 12)
    .rotate(x: a)
end




# difference() {
#   blk1();
#   for (alpha = [0, 90, 180, 270]) {
#     rotate(alpha, [ 1, 0, 0])
#       render(convexity = 12)
#         difference() {
#           blk2();
#           chop();
#         }
#   }

r.save('example016.scad')

# // chopped_blocks.stl is derived from Basics/LetterBlock.scad
# // The exported STL was converted to binary using MeshLab
#
# module blk1() {
#   cube([ 65, 28, 28 ], center = true);
# }
#
# module blk2() {
#   difference() {
#     translate([ 0, 0, 7.5 ]) cube([ 60, 28, 14 ], center = true);
#     cube([ 8, 32, 32 ], center = true);
#   }
# }
#
# module chop() {
#   translate([ -18, 0, 0 ])
#     import(file = "example016.stl", convexity = 12);
# }
#
# echo(version=version());
#
# difference() {
#   blk1();
#   for (alpha = [0, 90, 180, 270]) {
#     rotate(alpha, [ 1, 0, 0])
#       render(convexity = 12)
#         difference() {
#           blk2();
#           chop();
#         }
#   }
# }
