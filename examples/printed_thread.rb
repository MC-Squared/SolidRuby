#!/usr/bin/env ruby

require 'crystalscad'
include CrystalScad

t1 = PrintedThread.new
res = t1.show

res.save('printed_thread.scad')
