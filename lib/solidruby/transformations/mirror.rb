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
module SolidRuby::Transformations
  class Mirror < Transformation
    attr_accessor :x, :y, :z

    def initialize(*args)
      if args.first.is_a? Hash
        args = args.first
        @x = args[:x]
        @y = args[:y]
        @z = args[:z]
      else
        args = [args].flatten
        @x = args.include?(:x) ? 1 : nil
        @y = args.include?(:y) ? 1 : nil
        @z = args.include?(:z) ? 1 : nil

        args = {x: @x, y: @y, z: @z}
      end

      super(args)
    end

    def to_rubyscad
      RubyScadBridge.new.mirror(@args)
    end
  end
end
