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
   #Helper method for creating chamfers - basically just an extruded triangle
   #that can be subtracted from an edge
  def chamfer(args={})
    height = args[:height] || args[:h] || 0
    length = args[:length] || args[:l] || 0

    t = triangle(a: height, alpha: 90, beta: 45)

    return t.linear_extrude(height: length)
  end
end
