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

module SolidRuby
  class SolidRubyPhysical < SolidRuby::SolidRubyObject
    attr_accessor :transformations

    def initialize(*attributes)
      @transformations = []
      super(attributes)
    end

    def rotate(args)
      # always make sure we have a z parameter; otherwise RubyScad will produce a 2-dimensional output
      # which can result in openscad weirdness
      args[:z] = 0 if args[:z].nil?
      @transformations ||= []
      @transformations << Rotate.new(args)
      self
    end

    def rotate_around(point, args)
      x = point.x
      y = point.y
      z = point.z
      translate(x: -x, y: -y, z: -z).rotate(args).translate(x: x, y: y, z: z)
    end

    def translate(args)
      return self if (args[:x] || 0) == 0 && (args[:y] || 0) == 0 && (args[:z] || 0) == 0
      @transformations ||= []
      @transformations << Translate.new(args)
      self
    end

    def union(args)
      @transformations ||= []
      @transformations << Union.new(args)
      self
    end

    def mirror(args)
      @transformations ||= []
      @transformations << Mirror.new(args)
      self
    end

    def scale(args)
      args = { v: args } if args.is_a?(Numeric) || args.is_a?(Array)
      @transformations ||= []
      @transformations << Scale.new(args)
      self
    end

    def place(args={})
      return self if args.nil? || self.nil? || args[:onto].nil?

      onto = args[:onto]
      face = args[:face] || :top
      edge = args[:edge] || :center
      corner = args[:corner] || :center
      face_offset = args[:face_offset] || 0
      edge_offset = args[:edge_offset] || 0
      corner_offset = args[:corner_offset] || 0

      if onto.respond_to? :get_point_on
        move_to = onto.get_point_on(
          face: face,
          edge: edge,
          corner: corner,
          face_offset: face_offset,
          edge_offset: edge_offset,
          corner_offset: corner_offset
        )

        if (self.respond_to? :get_point_on)
          move_me = self.get_point_on(face: :center, edge: :center, corner: :center)
          move_to[:x] -= move_me[:x]
          move_to[:y] -= move_me[:y]
          move_to[:z] -= move_me[:z]
        end

        self.translate(move_to)
      end

      self
    end

    def to_rubyscad
      res = ''

      @transformations.reverse.each do |trans|
        res += trans.walk_tree
      end

      #res + super
      # res += '#' if self.debug?
      # res += to_rubyscad.to_s + "\n"
      # @siblings.each do |s|
      #   res += s.walk_tree
      # end
      # res
    end
  end
end
