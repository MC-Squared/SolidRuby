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
module SolidRuby::Helpers
  class Triangle < SolidRuby::Primitives::Polygon
    attr_accessor :alpha, :beta, :gamma, :a, :b, :c
    def initialize(args = {})
      @alpha = args[:alpha]
      @beta = args[:beta]
      @gamma = args[:gamma]
      @a = args[:a]
      @b = args[:b]
      @c = args[:c]
      #solve
      super(args)
    end

    def to_rubyscad
      super.to_rubyscad
    end
  end

  def triangle(args)
    Triangle.new(args)
  end
end
