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

    def chamfer(args = {})
      faces = normalise_edges(args)
      height = args[:h] || args[:height]
      trans = translations_for_edge(onto: self, faces: faces, x: @x, y: @y, z: @z)
      chamfers = nil
      trans.each do |t|
        chamfers += Helpers::chamfer(l: t[:length] + 0.02, h: height)
          .rotate(z: (t[:z_rot] - 180))
          .rotate(x: t[:x_rot], y: t[:y_rot])
          .translate(x: t[:x_trans], y: t[:y_trans], z: t[:z_trans])
      end

      self - chamfers
    end

    def get_point_on(args = {})
      face = args[:face] || :top
      edge = args[:edge] || :center
      corner = args[:corner] || :center
      face_offset = args[:face_offset] || 0
      edge_offset = args[:edge_offset] || 0
      corner_offset = args[:corner_offset] || 0

      vert_axis = :z
      horiz_axis = :x
      vert_dir = 1
      horiz_dir = 1

      pos = case face
      when :top
        vert_axis = :y
        horiz_dir = -1
        {x: @x / 2.0, y: @y / 2.0, z: @z + face_offset}
      when :bottom
        vert_axis = :y
        horiz_dir = -1
        vert_dir = -1
        { x: @x / 2.0, y: @y / 2.0, z: -face_offset}
      when :left
        horiz_axis = :y
        { x: face_offset, y: @y / 2.0, z: @z / 2.0 }
      when :right
        horiz_axis = :y
        horiz_dir = -1
        { x: @x + face_offset, y: @y / 2.0, z: @z / 2.0 }
      when :front
        horiz_dir = -1
        { x: @x / 2.0, y: -face_offset, z: @z / 2.0 }
      when :back
        { x: @x / 2.0, y: @y + face_offset, z: @z / 2.0 }
      when :center
        horiz_dir = -1
        { x: @x / 2.0, y: @y / 2.0, z: @z / 2.0 }
      end

      return pos if pos.nil?

      pos[:x] -= @x / 2.0 if @center
      pos[:y] -= @y / 2.0 if @center
      pos[:z] -= @z / 2.0 if @center

      @transformations.each do |t|
        pos[:x] += t.x
        pos[:y] += t.y
        pos[:z] += t.z
      end

      #pos is now center of the given face, move to the given side
      h_change = case horiz_axis
      when :x
        @x / 2.0
      when :y
        @y / 2.0
      end

      v_change = case vert_axis
      when :y
        @y / 2.0
      else
        @z / 2.0
      end

      case edge
      when :top
        pos[vert_axis] += (v_change * vert_dir)
        pos[vert_axis] += (edge_offset * vert_dir)
      when :bottom
        pos[vert_axis] -= (v_change * vert_dir)
        pos[vert_axis] -= (edge_offset * vert_dir)
      when :left
        pos[horiz_axis] += (h_change * horiz_dir)
        pos[horiz_axis] += (edge_offset * horiz_dir)
      when :right
        pos[horiz_axis] -= (h_change * horiz_dir)
        pos[horiz_axis] -= (edge_offset * horiz_dir)
      end

      case corner
      when :top
        pos[vert_axis] += (v_change * vert_dir)
        pos[vert_axis] += (corner_offset * vert_dir)
      when :bottom
        pos[vert_axis] -= (v_change * vert_dir)
        pos[vert_axis] -= (corner_offset * vert_dir)
      when :left
        pos[horiz_axis] += (h_change * horiz_dir)
        pos[horiz_axis] += (corner_offset * horiz_dir)
      when :right
        pos[horiz_axis] -= (h_change * horiz_dir)
        pos[horiz_axis] -= (corner_offset * horiz_dir)
      end

      pos
    end

    def fillet(args = {})
      faces = normalise_edges(args)
      radius = args[:r] || args[:radiusg]
      trans = translations_for_edge(onto: self, faces: faces, x: @x, y: @y, z: @z, tolerance: 0)
      fillets = nil
      trans.each do |t|
        fillets += Helpers::fillet(h: t[:length], r: radius)
          .rotate(z: t[:z_rot])
          .rotate(x: t[:x_rot], y: t[:y_rot])
          .translate(x: t[:x_trans], y: t[:y_trans], z: t[:z_trans])
      end

      self - fillets
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
