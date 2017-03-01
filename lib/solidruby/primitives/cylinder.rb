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

  class Cylinder < Primitive
    def to_rubyscad
      RubyScadBridge.new.cylinder(@args)
    end
  end

  def cylinder(args)
    # inner diameter handling
    if args[:id]
      id = args.delete(:id)
      args2 = args.dup
      args2[:d] = id

      if args[:ih]
        # if it has an inner height, add a tiny bit to the bottom
        ih = args.delete(:ih)
        args2[:h] = ih + 0.01
      else
        # otherwise add to both bottom and top to make a clear cut in OpenSCAD
        args2[:h] += 0.02
      end

      # if we have a ifn value, change the fn value of the inner cut
      if args[:ifn]
        ifn = args.delete(:ifn)
        args2[:fn] = ifn
      end

      return cylinder(args) - cylinder(args2).translate(z: -0.01)
    end

    Cylinder.new(args)
  end
end
