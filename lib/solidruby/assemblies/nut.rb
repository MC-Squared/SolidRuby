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
module SolidRuby::Assemblies
  class Nut < Assembly
    attr_accessor :height
    def initialize(size, args = {})
      @size = size
      @type = args[:type] ||= '934'
      @material = args[:material] ||= '8.8'
      @surface = args[:surface] ||= 'zinc plated'
      @support = args[:support] ||= false
      @support_layer_height = args[:support_layer_height] ||= 0.2
      @margin = args[:margin] ||= 0.3 # default output margin

      @slot = args[:slot] || nil
      @slot_margin = args[:slot_margin] || 0.5
      @slot_direction = args[:slot_direction] || 'z'
      @cylinder_length = args[:cylinder_length] || 0	# for slot only

      @transformations ||= []
      @args = args
      prepare_data
      @height = args[:height] || @height

      @direction = args[:direction] || @slot_direction

      @bolt = nil
    end

    def description
      "M#{@size} Nut, DIN #{@type}, #{@material} #{@surface}"
    end

    def bolt(length = nil, args = {})
      return @bolt if @bolt
      @bolt = Bolt.new(@size, length, args)
      case @direction
      when 'z'
        bolt.transformations << Rotate.new(x: 180)
        bolt.transformations << Translate.new(z: length)
      when '-z'
        bolt.transformations << Translate.new(z: -length + @height)
      when '-x'
        bolt.transformations << Rotate.new(x: 180)
        bolt.transformations << Translate.new(z: length)
      when 'x'
        bolt.transformations << Translate.new(z: -length + @height)
      when '-y'
        bolt.transformations << Rotate.new(x: 180)
        bolt.transformations << Translate.new(z: length)
      when 'y'
        bolt.transformations << Translate.new(z: -length + @height)
      end
      @bolt.transformations += transformations.dup

      @bolt
    end

    def prepare_data
      chart_934 = {
        2.5 => { side_to_side: 5, height: 2, support_diameter: 2.8 },
        3 => { side_to_side: 5.5, height: 2.4, support_diameter: 3.5 },
        4 => { side_to_side: 7, height: 3.2, support_diameter: 4.4 },
        5 => { side_to_side: 8, height: 4, support_diameter: 5.3 },
        6 => { side_to_side: 10, height: 5, support_diameter: 6.3 },
        8 => { side_to_side: 13, height: 6.5, support_diameter: 8.3 },
        10 => { side_to_side: 17, height: 8, support_diameter: 10.3 },
        12 => { side_to_side: 19, height: 10, support_diameter: 12.3 }
      }
      # for securing nuts
      chart_985 = {
        3 => { height: 4 },
        4 => { height: 5 },
        5 => { height: 5 },
        6 => { height: 6 }
      }

      @s = chart_934[@size][:side_to_side]
      @height = chart_934[@size][:height]
      @support_diameter = chart_934[@size][:support_diameter]
      @height = chart_985[@size][:height] if @type == "985"
    end

    def add_support(layer_height = @support_layer_height)
      res = cylinder(d: @support_diameter, h: @height - layer_height)
      # on very small nuts, add a support base of one layer height, so the support won't fall over
      res += cylinder(d:@s-1,h:layer_height) if @size < 6
      res
    end

    def slot
      case @slot_direction
      when 'x'
        pos = { x: @slot }
      when 'y'
        pos = { y: @slot }
      when 'z'
        pos = { z: @slot }
      when '-x'
        pos = { x: -@slot }
      when '-y'
        pos = { y: -@slot }
      when '-z'
        pos = { z: -@slot }
      else
        raise "Invalid slot direction #{@slot_direction}"
      end
      res = hull(
        nut_934(false, @margin, @slot_margin),
        nut_934(false, @margin, @slot_margin).translate(pos)
      )
      res += cylinder(d:@size+@margin,h:@cylinder_length) if @cylinder_length > 0
      res
    end

    def output
      add_to_bom
      if @slot.nil?
        return transform(nut_934(false, @margin))
      else
        return transform(slot)
      end
    end

    def show
      add_to_bom
      transform(nut_934)
    end

    def nut_934(show = true, margin = 0, height_margin = 0)
      @s += margin

      res = cylinder(d: (@s / Math.sqrt(3)) * 2, h: @height + height_margin, fn: 6)
      res -= cylinder(d: @size, h: @height) if show == true
      res -= add_support if @support
      res.color('Gainsboro')
    end
  end
end
