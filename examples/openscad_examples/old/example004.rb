#!/usr/bin/env ruby

require 'solidruby'
include SolidRuby

def example004
  cube([30, 30, 30]).center - sphere(d: 40)
end

example004.save('example004.scad')

# module example004()
# {
#   difference() {
#     cube(30, center = true);
#     sphere(20);
#   }
# }
#
# echo(version=version());
#
# example004();
