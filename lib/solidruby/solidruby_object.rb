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
    attr_accessor :children
    attr_accessor :siblings

    def initialize(*attributes)
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

      # @transformations.reverse.each do |trans|
      #   res += trans.walk_tree
      # end
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
