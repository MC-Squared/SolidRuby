#!/usr/bin/env ruby

require 'solidruby'
include SolidRuby

t1 = PrintedThread.new
res = t1.show

res.save('printed_thread.scad')
