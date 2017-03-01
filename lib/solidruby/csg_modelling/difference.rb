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
module SolidRuby::CSGModelling
  class Difference < CSGModelling
  end

  def -(args)
    return args if nil?
    if args.is_a? Array
      r = self
      args.each do |a|
        # if a.respond_to? :output
        #	r = Difference.new(r,a.output)
        # else
        r = Difference.new(r, a)
        # end
      end
      r
    else
      optimize_difference(self, args)
    end
  end

  def optimize_difference(top, child)
    if top.is_a?(Difference) && (!child.is_a? Difference)
      top.children << child
      top
    else
      Difference.new(top, child)
    end
  end
end
