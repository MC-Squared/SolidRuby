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
  class TSlot < Assembly
    # the code in this class is based on code by edef1c
    # Ported to SolidRuby by Jennifer Glauche
    # License: GPLv3
    attr_accessor :args
    def initialize(args = {})
      @args = args

      @args[:size] ||= 20
      @args[:length] ||= 100
      @args[:configuration] ||= 1
      @args[:gap] ||= 8.13
      @args[:thickness] ||= 2.55
      @args[:simple] ||= false
      @machining = SolidRubyObject.new
      @machining_string = ''

      super(args)
    end

    def output
      res = profile
      res - @machining
    end

    alias show output

    def description
      "T-Slot #{@args[:size]}x#{@args[:size] * @args[:configuration]}, length #{@args[:length]}mm #{@machining_string}"
    end

    def length(length)
      @args[:length] = length
      self
    end

    def thread(args = {})
      position = args[:position] || 'front'
      @machining_string += "with thread on #{position} "
      self
    end

    def threads
      thread.thread(position: 'back')
    end

    def holes(args = {})
      args[:position] = 'front'
      res = hole(args)
      args[:position] = 'back'
      res.hole(args)
    end

    def hole(args = {})
      diameter = args[:diameter] || 8
      position = args[:position] || 'front'
      side = args[:side] || 'x'

      if position.is_a? String
        case position
        when 'front'
          z = @args[:size] / 2
          @machining_string += "with #{diameter}mm hole on front "
        when 'back'
          z = @args[:length] - @args[:size] / 2
          @machining_string += "with #{diameter}mm hole on back "
        end
      else
        z = position
        @machining_string += "with #{diameter}mm hole on #{z}mm "
      end

      @args[:configuration].times do |c|
        cyl = cylinder(d: diameter, h: @args[:size])
        if side == 'x'
          @machining += cyl.rotate(x: -90).translate(x: @args[:size] / 2 + c * @args[:size], z: z)
        else
          @machining += cyl.rotate(y: 90).translate(y: @args[:size] / 2 + c * @args[:size], z: z)
        end
      end

      self
    end

    def profile
      BillOfMaterial.bom.add(description) unless args[:no_bom] == true
      return single_profile.color('Silver') if @args[:configuration] == 1
      multi_profile.color('Silver')
    end

    def single_profile
      if @args[:simple] == true
        cube([@args[:size], @args[:size], @args[:length]])
      else
        start = @args[:thickness].to_f / Math.sqrt(2)

        gap = @args[:gap].to_f
        thickness = @args[:thickness].to_f
        size = @args[:size]
        square_size = gap + thickness
        if square_size > 0
          profile = square(size: square_size, center: true)
        else
         profile = nil
        end

        (0..3).each do |d|
          profile += polygon(points: [[0, 0], [0, start], [size / 2 - thickness - start, size / 2 - thickness], [gap / 2, size / 2 - thickness], [gap / 2, size / 2], [size / 2, size / 2], [size / 2, gap / 2], [size / 2 - thickness, gap / 2], [size / 2 - thickness, size / 2 - thickness - start], [start, 0]]).rotate(z: d * 90)
        end
        profile -= circle(r: gap / 2, center: true)
        profile = profile.translate(x: size / 2, y: size / 2)
        profile.linear_extrude(height: @args[:length], convexity: 2)
      end
    end

    def multi_profile
      res = single_profile
      (@args[:configuration] - 1).times do |c|
        c += 1
        res += single_profile.translate(y: c * @args[:size])
      end
        res
    end
  end
end
