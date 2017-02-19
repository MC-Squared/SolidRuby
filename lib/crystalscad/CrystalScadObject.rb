#    This file is part of CrystalScad.
#
#    CrystalScad is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    CrystalScad is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with CrystalScad.  If not, see <http://www.gnu.org/licenses/>.

module CrystalScad
  class CrystalScadObject
    attr_accessor :args
    attr_accessor :transformations
    def initialize(*args)
      @transformations = []
      @args = args.flatten
      @args = @args[0] if @args[0].is_a? Hash
    end

    def walk_tree
      res = ''

      @transformations.reverse.each do |trans|
        res += trans.walk_tree
      end
      res += to_rubyscad.to_s + "\n"
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
  end
end
