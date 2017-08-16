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
  class Bolt < Assembly
     def initialize(size, length, args = {})
       @args = args
       @args[:type] ||= '912'
       @args[:material] ||= 'steel 8.8'
       @args[:surface] ||= 'zinc plated'
       # options for output only:
       @args[:additional_length] ||= 0
       @args[:additional_diameter] ||= 0.3
       @args[:head_margin] ||= 0.0

       if @args[:washer] == true
         @washer = Washer.new(size, material: @args[:material], surface: @args[:surface])
       end

       @size = size
       @length = length
       @transformations ||= []
       super(args)
     end

    def description
      norm = ''
      if ['912', '933'].include? @args[:type]
        norm = 'DIN'
      elsif ['7380'].include? @args[:type]
        norm = 'ISO'
      end

       "M#{@size}x#{@length} Bolt, #{norm} #{@args[:type]}, #{@args[:material]} #{@args[:surface]}"
    end

    def output
      add_to_bom
      case @args[:type].to_s
      when '912'
        res = bolt_912(@args[:additional_length], @args[:additional_diameter])
      when '933'
        res = bolt_933(@args[:additional_length], @args[:additional_diameter], @args[:head_margin])
      when '7380'
        res = bolt_7380(@args[:additional_length], @args[:additional_diameter])
      else
        raise "unkown type #{args[:type]} for Bolt!"
      end

      transform(res)
    end

    def show
      add_to_bom
      case @args[:type].to_s
      when '912'
        res = bolt_912(0, 0)
      when '933'
        res = bolt_933(0, 0)
      when '7380'
        res = bolt_7380(0, 0)
      else
        raise "unkown type #{args[:type]} for Bolt!"
      end

      @washer ||= nil
      if @washer
        res += @washer.show
        res = res.translate(z: -@washer.height)
      end

      transform(res)
    end

     # ISO 7380
    def bolt_7380(additional_length = 0, addtional_diameter = 0)
      chart_iso7380 = {
        3 => { head_dia: 5.7, head_length: 1.65 },
        4 => { head_dia: 7.6, head_length: 2.2 },
        5 => { head_dia: 9.5, head_length: 2.75 },
        6 => { head_dia: 10.5, head_length: 3.3 },
        8 => { head_dia: 14, head_length: 4.4 },
        10 => { head_dia: 17.5, head_length: 5.5 },
        12 => { head_dia: 21, head_length: 6.6 }
        }
      res = cylinder(d1: chart_iso7380[@size][:head_dia] / 2.0, d2: chart_iso7380[@size][:head_dia], h: chart_iso7380[@size][:head_length]).translate(z: -chart_iso7380[@size][:head_length]).color('Gainsboro')
      total_length = @length + additional_length
      res += cylinder(d: @size + addtional_diameter, h: total_length).color('DarkGray')
    end

    # DIN 912
    def bolt_912(additional_length = 0, addtional_diameter = 0)
      chart_din912 = {
        2 => { head_dia: 3.8, head_length: 2, thread_length: 16 },
        2.5 => { head_dia: 4.5, head_length: 2.5, thread_length: 17 },
        3 => { head_dia: 5.5, head_length: 3, thread_length: 18 },
        4 => { head_dia: 7.0, head_length: 4, thread_length: 20 },
        5 => { head_dia: 8.5, head_length: 5, thread_length: 22 },
        6	=> { head_dia: 10, head_length: 6, thread_length: 24 },
        8	=> { head_dia: 13, head_length: 8, thread_length: 28 },
        10 => { head_dia: 16, head_length: 10, thread_length: 32 },
        12 => { head_dia: 18, head_length: 12, thread_length: 36 },
        14 => { head_dia: 21, head_length: 14, thread_length: 40 },
        16 => { head_dia: 24, head_length: 16, thread_length: 44 },
        18 => { head_dia: 27, head_length: 18, thread_length: 48 },
        20 => { head_dia: 30, head_length: 20, thread_length: 52 },
        22 => { head_dia: 33, head_length: 22, thread_length: 56 },
        24 => { head_dia: 36, head_length: 24, thread_length: 60 },
        30 => { head_dia: 45, head_length: 30, thread_length: 72 },
        36 => { head_dia: 54, head_length: 36, thread_length: 84 }
      }

      res = cylinder(d: chart_din912[@size][:head_dia], h: chart_din912[@size][:head_length]).translate(z: -chart_din912[@size][:head_length]).color('Gainsboro')

      total_length = @length + additional_length
      thread_length = chart_din912[@size][:thread_length]
      if total_length.to_f <= thread_length
        res += cylinder(d: @size + addtional_diameter, h: total_length).color('DarkGray')
      else
        res += cylinder(d: @size + addtional_diameter, h: total_length - thread_length).color('Gainsboro')
        res += cylinder(d: @size + addtional_diameter, h: thread_length).translate(z: total_length - thread_length).color('DarkGray')
      end
      res
    end

    def bolt_933(additional_length = 0, addtional_diameter = 0, head_margin = 0)
      chart = {
        2 => { head_side_to_side: 4, head_length: 1.4 },
        2.5 => { head_side_to_side: 5, head_length: 1.7 },
        3 => { head_side_to_side: 5.5, head_length: 2 },
        4 => { head_side_to_side: 7, head_length: 2.8 },
        5 => { head_side_to_side: 8, head_length: 3.5 },
        6	=> { head_side_to_side: 10, head_length: 4 },
        8	=> { head_side_to_side: 13, head_length: 5.5 },
        10 => { head_side_to_side: 17, head_length: 7 },
        12 => { head_side_to_side: 19, head_length: 8 },
        14 => { head_side_to_side: 22, head_length: 9 },
        16 => { head_side_to_side: 24, head_length: 10 }
      }
      head_dia = chart[@size][:head_side_to_side].to_f + head_margin.to_f
      res = cylinder(d: (head_dia / Math.sqrt(3)) * 2, fn: 6, h: chart[@size][:head_length]).translate(z: -chart[@size][:head_length]).color('Gainsboro')
      total_length = @length + additional_length
      res += cylinder(d: @size + addtional_diameter, h: total_length).color('DarkGray')
    end
  end
end
