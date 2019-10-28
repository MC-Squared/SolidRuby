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
    attr_accessor :x, :y, :z

    def initialize(args={}, y = nil, z = nil)
      if args.is_a? Array
        args = { x: args[0], y: args[1], z: args[2] }
      elsif args.is_a?(Hash) && args[:size]
        args[:x] ||= args[:size][0] || 0
        args[:y] ||= args[:size][1] || 0
        args[:z] ||= args[:size][2] || 0
      elsif args.is_a? Numeric
        x = args
        y ||= x
        z ||= y# = x if y.nil? && z.nil?
        args = { x: x, y: y, z: z }
      end
      @x = args[:x]
      @y = args[:y] || @x
      @z = args[:z] || @y

      centered = args.delete(:center) || args.delete(:c)
      super(args)

      if centered == true || centered == [:x, :y, :z]
        @centered = true
      else
        @centered = false
        centered = [centered].flatten
        center_x if centered.include?(:x)
        center_y if centered.include?(:y)
        center_z if centered.include?(:z)
      end
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
      @centered = true
      self
    end

    def centered?
      @centered
    end

    def chamfer(args = {})
      faces = normalise_edges(args)
      height = args[:h] || args[:height]
      trans = translations_for_edge(onto: self, faces: faces, x: @x, y: @y, z: @z)
      res = self
      trans.each do |t|
        res -= Helpers::chamfer(l: t[:length] + 0.02, h: height)
          .rotate(z: (t[:z_rot] - 180))
          .rotate(x: t[:x_rot], y: t[:y_rot])
          .translate(x: t[:x_trans], y: t[:y_trans], z: t[:z_trans])
      end
      res
    end

    def get_point_on(args = {})
      args[:x] = @x
      args[:y] = @y
      args[:z] = @z
      args[:centered] = @centered
      args[:centered_z] = @centered
      args[:transformations] = @transformations
      calculate_point_on(args)
    end

    def fillet(args = {})
      faces = normalise_edges(args)
      radius = args[:r] || args[:radiusg]
      trans = translations_for_edge(onto: self, faces: faces, x: @x, y: @y, z: @z, tolerance: 0)
      res = self
      trans.each do |t|
        res -= Helpers::fillet(h: t[:length], r: radius)
          .rotate(z: t[:z_rot])
          .rotate(x: t[:x_rot], y: t[:y_rot])
          .translate(x: t[:x_trans], y: t[:y_trans], z: t[:z_trans])
      end
      res
    end

    def to_rubyscad
      args = { size: [@x, @y, @z] }
      args[:center] = @centered if @centered
      RubyScadBridge.new.cube(args)
    end
  end

  def cube(args = {}, y = nil, z = nil)
    if args.is_a? Numeric
      args = {x: args}
      args[:y] = y if y
      args[:z] = z if z
    end
    Cube.new(args)
  end
end
