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
    def fillet(args)
      if @children.first.respond_to? :fillet
        @children << @children.first.fillet(args.merge(exclude_self: true))
        self
      else
        Helpers::fillet(args)
      end
    end

    def chamfer(args)
      if @children.first.respond_to? :chamfer
        @children << @children.first.chamfer(args.merge(exclude_self: true))
        self
      else
        Helpers::chamfer(args)
      end
    end
  end

  def -(args)
    return args if nil?
    if args.is_a? Array
      r = self
      args.each do |a|
        r = optimize_difference(r, a)
      end
      r
    else
      optimize_difference(self, args)
    end
  end

  def optimize_difference(top, child)
    if top.is_a?(Difference) && (!child.is_a? Difference) && top.transformations.empty?
      top.children << child
      top
    elsif top.is_a?(Difference) && child.is_a?(Difference) && child.transformations.empty?
      top -= child.children
    else
      Difference.new(top, child)
    end
  end
end
