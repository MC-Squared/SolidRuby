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
  class Import < Primitive
    attr_accessor :filename, :layer

    def initialize(attributes)
      @transformations = []
      @children = []

      if attributes.is_a? String
        @filename = attributes
      else # assume hash otherwise
        @filename = attributes[:f] || attributes[:file]
        @layer = attributes[:l] || attributes[:layer]

        # we need to convert relative to absolute paths if the openscad output is not in the same directory
        # as the solidruby program.
        @filename = File.expand_path(@filename) if attributes[:absolue_path] && @filename
      end
      super(attributes)
    end

    def to_rubyscad
      @layer ||= nil
      layer = ''
      layer = ",layer=\"#{@layer}\"" if @layer
      res = children.map(&:walk_tree)
      res = '' if res == []
      res += RubyScadBridge.new.import('file="' + @filename.to_s + "\"#{layer}") # apparently the quotes get lost otherwise
      res
    end
  end

  def import(args)
    Import.new(args)
  end
end
