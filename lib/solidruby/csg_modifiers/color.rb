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
module SolidRuby::CSGModifiers
  class Color < CSGModifier
    def initialize(object, attributes)
      @operation = 'color'
      if attributes.is_a? String
        attributes = "\"#{attributes}\""
      elsif attributes.is_a? Hash
        attributes[:a] ||= 255

        r = attributes[:r].to_f / 255.0
        g = attributes[:g].to_f / 255.0
        b = attributes[:b].to_f / 255.0
        a = attributes[:a].to_f / 255.0
        attributes = [r, g, b, a]
      end

      super(object, attributes)
    end
  end

  def color(args)
    Color.new(self, args)
  end
end
