#!/usr/bin/env ruby

require 'solidruby'
include SolidRuby

# The Openscad example uses 'triangles', but this is deprecated as of
# 2014.03, so we use 'faces' here
r = polyhedron(points: [
    [10, 0, 0],
    [0, 10, 0],
    [-10, 0, 0],
    [0, -10, 0],
    [0, 0, 10]
  ],
  faces: [
    [0, 1, 2, 3],
    [4, 1, 0],
    [4, 2, 1],
    [4, 3, 2],
    [4, 0, 3]
   ])

r.save('example011.scad')

# echo(version=version());
#
# polyhedron(
#   points = [
#     [10, 0, 0],
#     [0, 10, 0],
#     [-10, 0, 0],
#     [0, -10, 0],
#     [0, 0, 10]
#   ],
#   triangles = [
#     [0, 1, 2, 3],
#     [4, 1, 0],
#     [4, 2, 1],
#     [4, 3, 2],
#     [4, 0, 3]
#   ]
# );
