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
  class Sphere < Primitive
    alias_attr :d, :diameter
    alias_attr :r, :radius

    def initialize(args={})
      d = args[:diameter] || args[:d]
      @r = args[:radius] || args[:r] || d/2.0
      super(args)
    end

    def get_point_on(args = {})
      #approximate a cube the size of this sphere
      args[:x] = @r*Math.sqrt(2)
      args[:y] = @r*Math.sqrt(2)
      args[:z] = @r*Math.sqrt(2)
      args[:centered] = true
      args[:centered_z] = true
      args[:transformations] = @transformations
      calculate_point_on(args)
    end

    def to_rubyscad
      RubyScadBridge.new.sphere(@attributes)
    end
  end

  def sphere(args)
    if args.is_a? Numeric
      args = {r: args}
    end
    Sphere.new(args)
  end
end
