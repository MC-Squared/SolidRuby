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
  class Washer < Assembly
    def initialize(size, args = {})
      @args = args
      @size = size
      @args[:type] ||= '125'
      @args[:material] ||= 'steel 8.8'
      @args[:surface] ||= 'zinc plated'

      @chart_din125 = {
        3.2 => { outer_diameter: 7, height: 0.5 },
        3.7 => { outer_diameter: 8, height: 0.5 },
        4.3 => { outer_diameter: 9, height: 0.8 },
        5.3 => { outer_diameter: 10, height: 1.0 },
        6.4 => { outer_diameter: 12, height: 1.6 },
        8.4 => { outer_diameter: 16, height: 1.6 },
        10.5 => { outer_diameter: 20, height: 2.0 },
        13.0 => { outer_diameter: 24, height: 2.5 }
      }
      if @chart_din125[@size].nil?
        @chart_din125.map { |k, _v| k }.sort.reverse.map { |s| s > @size ? size = s : nil }
        @size = size
      end
      @height = @chart_din125[@size][:height]

      @transformations ||= []
    end

    def description
      "Washer #{@args[:size]}, Material #{@args[:material]} #{@args[:surface]}"
    end

    def show
      add_to_bom
      washer = cylinder(d: @chart_din125[@size][:outer_diameter].to_f, h: @chart_din125[@size][:height].to_f)
      washer -= cylinder(d: @size, h: @chart_din125[@size][:outer_diameter].to_f + 0.2).translate(z: -0.1)
      washer.color('Gainsboro')
      transform(washer)
    end
  end
end
