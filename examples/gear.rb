#!/usr/bin/env ruby

require 'solidruby'
include SolidRuby

g1 = Gear.new(module: 0.5, teeth: 80, bore: 5, height: 4)
#g2 = Gear.new(module: 0.5, teeth: 14, bore: 5, height: 8)

g1.save('gear.scad')
# puts g1.distance_to(g2)
# puts g1.show.scad_output
