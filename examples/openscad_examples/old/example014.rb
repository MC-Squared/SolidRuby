#!/usr/bin/env ruby

require 'solidruby'
include SolidRuby

r = [
  {x: 0, y: 0, z: 0},
  {x: 10, y: 20, z: 300},
  {x: 200, y: 40, z: 57},
  {x: 20, y: 88, z: 57},
]

res = nil #cube(x: 100, y: 20, z: 20, c: true)

r.each do |v|
  res *= cube(x: 100, y: 20, z: 20, c: true)
    .rotate(v)
end

res.save('example014.scad')

# echo(version=version());
#
# intersection_for(i = [
#       [0, 0, 0],
#       [10, 20, 300],
#       [200, 40, 57],
#       [20, 88, 57]
#     ])
#   rotate(i) cube([100, 20, 20], center = true);
