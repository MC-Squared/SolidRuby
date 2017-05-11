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

module SolidRuby::Extras

  def knurl(y)
    x = 1.5
    height = 1.5
    res = cube([x, y, height])
    res -= cylinder(d: 0.9, h: height * 1.42, fn: 16).rotate(y: 45).translate(x: 0)
    res -= cylinder(d: 0.9, h: height * 1.42, fn: 16).rotate(y: -45).translate(x: 1.5)
    res
  end

  def knurled_cube(size)
    x = size[0]
    y = size[1]
    z = size[2]
    res = nil

    (x / 1.5).ceil.times do |i|
      (z / 1.5).ceil.times do |f|
        res += knurl(y).translate(x: i * 1.5, z: f * 1.5)
      end
    end

    res *= cube([x, y, z])

    res
  end

  def knurled_cylinder(args = {})
    res = cylinder(args)
    height = args[:h]
    r = args[:d] / 2.0

    24.times do |_i|
      (height / 2).ceil.times do |f|
        res -= cylinder(d: 0.9, h: height * 2).rotate(y: 45).translate(y: -r, z: f * 2)
        res -= cylinder(d: 0.9, h: height * 2).rotate(y: -45).translate(y: -r, z: f * 2)
      end
      res.rotate(z: 15)
    end
    res
  end
end
