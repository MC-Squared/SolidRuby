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
  class Square < Primitive
    def initialize(*attr)
      super(attr)
      if attr[0][:size].is_a? Array
        @x, @y = attr[0][:size].map(&:to_f)
      else
        @x = attr[0][:size].to_f
        @y = @x
      end
    end

    def to_rubyscad
      RubyScadBridge.new.square(@attributes)
    end

    def center_xy
      @transformations << Translate.new(x: -@x / 2, y: -@y / 2)
      self
    end
    alias center center_xy

    def center_x
      @transformations << Translate.new(x: -@x / 2)
      self
    end

    def center_y
      @transformations << Translate.new(y: -@y / 2)
      self
    end
  end

  def square(args, y = nil)
    if args.is_a? Array
      args = { size: args }
    elsif args.is_a? Numeric
      x = args
      args = { size: [x, y] }
    elsif args.is_a? Hash
      unless args[:size]
        args[:x] ||= 0
        args[:y] ||= 0
        args = { size: [args[:x], args[:y]] }
      end
    end
    Square.new(args)
  end
end
