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
  class Union < CSGModelling
  end

  def +(args)
    return args if nil?

    if args.is_a? Array
      r = self
      args.each do |a|
        r = optimize_union(r, a)
      end
      r
    else
      optimize_union(self, args)
    end
  end

  def optimize_union(top, child)
    if top.is_a?(Union) && (!child.is_a? Union) && top.transformations.empty?
      top.children << child
      top
    elsif top.is_a?(Union) && child.is_a?(Union) && child.transformations.empty?
      top += child.children
    else
      Union.new(top, child)
    end
  end
end
