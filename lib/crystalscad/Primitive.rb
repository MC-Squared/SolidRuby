#    This file is part of CrystalScad.
#
#    CrystalScad is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    CrystalScad is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with CrystalScad.  If not, see <http://www.gnu.org/licenses/>.

module CrystalScad
  class Primitive < CrystalScadObject
    attr_accessor :children

    def rotate(args)
      # always make sure we have a z parameter; otherwise RubyScad will produce a 2-dimensional output
      # which can result in openscad weirdness
      args[:z] = 0 if args[:z].nil?
      @transformations ||= []
      @transformations << Rotate.new(args)
      self
    end

    def rotate_around(point, args)
      x = point.x
      y = point.y
      z = point.z
      translate(x: -x, y: -y, z: -z).rotate(args).translate(x: x, y: y, z: z)
    end

    def translate(args)
      @transformations ||= []
      @transformations << Translate.new(args)
      self
    end

    def union(args)
      @transformations ||= []
      @transformations << Union.new(args)
      self
    end

    def mirror(args)
      @transformations ||= []
      @transformations << Mirror.new(args)
      self
    end

    def scale(args)
      args = { v: args } if args.is_a?(Numeric) || args.is_a?(Array)
      @transformations ||= []
      @transformations << Scale.new(args)
      self
    end

    # copies the transformation of obj to self
    def transform(obj)
      @transformations ||= []
      @transformations += obj.transformations
      self
    end
  end
end
