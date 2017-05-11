#    This file is part of SolidRuby.
#
#    SolidRuby is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    SolidRuby is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with SolidRuby.  If not, see <http://www.gnu.org/licenses/>.
#
module SolidRuby::Primitives
  class Cube < Primitive
    attr_accessor :x, :y, :z, :center

    def initialize(args={})
      super(args)

      @x = args[:x]
      @y = args[:y]
      @z = args[:z]
      @center = args[:center]
    end

    def center_xy
      @transformations << Translate.new(x: -@x / 2.0, y: -@y / 2.0)
      self
    end

    def center_x
      @transformations << Translate.new(x: -@x / 2.0)
      self
    end

    def center_y
      @transformations << Translate.new(y: -@y / 2.0)
      self
    end

    def center_z
      @transformations << Translate.new(z: -@z / 2.0)
      self
    end

    def center
      @center = true
      self
    end

    def centered?
      @center
    end

    def to_rubyscad
      args = { size: [@x, @y, @z] }
      args[:center] = @center if @center
      RubyScadBridge.new.cube(args)
    end
  end

  def cube(args = {}, y = nil, z = nil)
    if args.is_a? Array
      args = { x: args[0], y: args[1], z: args[2] }
    elsif args.is_a? Hash
      args[:x] ||= args[:size][0] || 0
      args[:y] ||= args[:size][1] || 0
      args[:z] ||= args[:size][2] || 0
    elsif args.is_a? Numeric
      x = args
      z = y = x if y.nil? && z.nil?
      args = { x: x, y: y, z: z }
    end
    Cube.new(args)
  end
end
