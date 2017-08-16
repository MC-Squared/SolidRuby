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
  def rounded_cube(args = {}, y = nil, z = nil)
    c = cube(args, y, z)
    r = args[:r]
    sx = c.x - r * 2
    sy = c.y - r * 2
    sz = c.z - r

    res = hull(
      sphere(r: r).translate(z: r),
      sphere(r: r).translate(z: sz),
      sphere(r: r).translate(x: sx, z: sz),
      sphere(r: r).translate(x: sx, y: sy, z: sz),
      sphere(r: r).translate(y: sy, z: sz),
      sphere(r: r).translate(x: sx, z: r),
      sphere(r: r).translate(y: sy, z: r),
      sphere(r: r).translate(x: sx, y: sy, z: r)
    ).translate(x: r, y: r)

    res
  end
end
