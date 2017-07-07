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
  def fillet(args)
    @radius = args[:r] || args[:radius]
    @height = args[:h] || args[:height]
    @fn = args[:fn] || 64

    cube(@radius*2, @radius*2, @height+0.02).translate(z: -0.01) -
    cylinder(r: @radius, h: @height + 0.04, fn: @fn)
      .translate(z: -0.02)
  end
end
