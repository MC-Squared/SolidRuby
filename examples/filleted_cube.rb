#!/usr/bin/env ruby

require 'solidruby'
include SolidRuby

def filleted_cube
  edges = [:top, :bottom, :left, :right]
  faces = [:top, :bottom, :left, :right, :front, :back]

  res = nil
  x = 0
  y = 0

  faces.each do |f|
    edges.each do |e|
      res += cube(x: 5, y: 5, z: 10).fillet({f => e, :r => 1})
        .translate(x: x, y: y)

        y += 10
    end

    x += 10
    y = 0
  end

  res += cube(x: 5, y: 5, z: 10)
    .fillet(edges: :vertical, r: 1)
    .translate(x: -10)

  res += cube(x: 5, y: 5, z: 10)
    .fillet(edges: :horizontal, r: 1)
    .translate(x: -10, y: 10)

  res += cube(x: 5, y: 5, z: 10)
    .fillet(edges: :all, r: 1)
    .translate(x: -10, y: 20)
end

filleted_cube.save('filleted_cube.scad')
