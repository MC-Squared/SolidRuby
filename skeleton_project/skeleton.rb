#!/usr/bin/env ruby

require 'solidruby'
require 'require_all'
require_all 'assemblies'
include SolidRuby

assembly = Example.new.show
subassembly = nil

BillOfMaterial.bom.save

assembly.save(File.expand_path(__FILE__).gsub('.rb', '') + '.scad', '$fn=64;') if assembly
subassembly.save('part.scad', '$fn=64;') if subassembly

Dir.mkdir('output') unless Dir.exist?('output')
parts = [Example]

parts.each do |part|
  name = part.to_s.downcase
  part.new.output.save("output/#{name}.scad", '$fn=64;')
  if ARGV[0] == 'build'
    puts "Building #{name}..."
    system("openscad -o output/#{name}.stl output/#{name}.scad")
  end
end
