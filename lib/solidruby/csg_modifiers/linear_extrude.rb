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
  class LinearExtrude < CSGModifier
    alias_attr :height
    alias_attr :convexity, :co
    alias_attr :center, :ce
    alias_attr :twist
    alias_attr :slices, :sl

    def initialize(object, args)
      @operation = 'linear_extrude'
      super(object, args)
    end
  end

  def linear_extrude(args)
    LinearExtrude.new(self, args)
  end
end
