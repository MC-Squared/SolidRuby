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
  class SolidRubyObject
    attr_accessor :attributes
    attr_accessor :transformations
    attr_accessor :children
    attr_accessor :siblings

    def initialize(*attributes)
      @transformations = []
      @siblings = []
      @attributes = attributes.flatten
      @attributes = @attributes[0] if @attributes[0].is_a? Hash
      @debug_obj = false

      @@attr_aliases ||= {}
      @@attr_aliases[self.class.name] ||= {}
      @@attr_aliases[self.class.name].each do |k, v|
        @attributes[v] ||= @attributes.delete(k) unless @attributes[k].nil?
      end
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
      if @transformations.last.is_a? Translate
        @transformations.last.x += args[:x] || 0
        @transformations.last.y += args[:y] || 0
        @transformations.last.z += args[:z] || 0
      else
        @transformations << Translate.new(args)
      end
      self
    end

    def union(args)
      @transformations << Union.new(args)
      self
    end

    def mirror(*args)
      @transformations << Mirror.new(*args)
      self
    end

    def scale(args)
      args = { v: args } if args.is_a?(Numeric) || args.is_a?(Array)
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

    def &(obj)
      @siblings << obj
      self
    end

    def debug
      @debug_obj = true
      self
    end

    def debug?
      @debug_obj
    end

    def walk_tree
      res = ''

      @transformations.reverse.each do |trans|
        res += trans.walk_tree
      end
      res += '#' if self.debug?
      res += to_rubyscad.to_s + "\n"
      @siblings.each do |s|
        res += s.walk_tree
      end
      res
    end

    alias scad_output walk_tree

    def walk_tree_classes
      res = []
      @transformations.reverse.each do |trans|
        res += trans.walk_tree_classes
      end
      res << self.class
      res
    end

    def to_rubyscad
      ''
    end

    def save(filename, start_text = nil)
      file = File.open(filename, 'w')
      file.puts start_text unless start_text.nil?
      file.puts scad_output
      file.close
    end

    def self.alias_attr(long, short=nil)
      short ||= long[0].downcase.to_sym
      @@attr_aliases ||= {}
      @@attr_aliases[self.name] ||= {}
      @@attr_aliases[self.name][short] = long

      self.class_eval {
        define_method long do
          @attributes[long]
        end
      }
    end
  end
end
