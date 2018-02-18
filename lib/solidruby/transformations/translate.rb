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
module SolidRuby::Transformations
  attr_accessor :x, :y, :z
  class Translate < Transformation
    def initialize(args={})
      super(args)
      @x = args[:x] || 0
      @y = args[:y] || 0
      @z = args[:z] || 0
    end

    def to_rubyscad
      #ignore empty transformations
      return '' if @x == 0 && @y == 0 && @z == 0
      RubyScadBridge.new.translate({x: @x, y: @y, z: @z}).delete('"')
    end
  end
end
