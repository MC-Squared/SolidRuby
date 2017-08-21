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
    alias_attr :size

    def initialize(att)
      if att.is_a? Array
        att = { size: att }
      elsif att.is_a? Numeric
        att = { size: att }
      end

      att[:center] ||= att.delete(:c)
      att.delete(:center) unless att[:center]

      super(att)

      unless @attributes[:size]
        x = @attributes.delete(:x) || 0
        y = @attributes.delete(:y) || 0
        @attributes[:size] = [x, y]
      end
    end

    def x
      if @attributes[:size].is_a? Array
        @attributes[:size][0]
      else
        @attributes[:size]
      end
    end

    def y
      if @attributes[:size].is_a? Array
        @attributes[:size][1]
      else
        @attributes[:size]
      end
    end

    def to_rubyscad
      RubyScadBridge.new.square(@attributes)
    end

    def center_xy
      @attributes[:center] = true
      self
    end
    alias center center_xy

    def center_x
      @transformations << Translate.new(x: -self.x / 2.0)
      self
    end

    def center_y
      @transformations << Translate.new(y: -self.y / 2.0)
      self
    end

    def centered?
      return @attributes[:center] || false
    end
  end

  def square(args, y = nil)
    if args.is_a?(Numeric) && !!y == y
      args = { size: args, center: y}
    elsif args.is_a?(Numeric) && y.is_a?(Numeric)
      args = { size: [args, y] }
    end
    Square.new(args)
  end
end
