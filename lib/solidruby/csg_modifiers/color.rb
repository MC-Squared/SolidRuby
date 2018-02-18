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
    def initialize(object, attributes, opacity = nil)
      @operation = 'color'
      if attributes.is_a? String
        attributes = "\"#{attributes}\""
        attributes += ", #{opacity}" unless opacity.nil?
      elsif attributes.is_a? Hash
        attributes[:a] ||= 255

        r = attributes[:r] / 255.0
        g = attributes[:g] / 255.0
        b = attributes[:b] / 255.0
        a = attributes[:a] / 255.0
        attributes = {c: [r, g, b], alpha: a}
      end

      super(object, attributes)
    end

  end

  def color(args, opacity = nil)
    Color.new(self, args, opacity)
  end
end
