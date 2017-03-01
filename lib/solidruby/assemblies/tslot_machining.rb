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
  class TSlotMachining < TSlot
     def initialize(args = {})
       super(args)
       @args[:holes] ||= 'front,back' # nil, front, back
       @args[:bolt_size] ||= 8
       @args[:bolt_length] ||= 25
       puts 'TSlotMachining is deprecated and will be removed in the 0.4.0 release.'
     end

    alias tslot_output output

    def output(length = nil)
       tslot_output(length) - bolts
    end

    def show(length = nil)
       output(length) + bolts
    end

    def bolts
       bolt = SolidRubyObject.new
      return bolt if @args[:holes].nil?

      if @args[:holes].include?('front')
         @args[:configuration].times do |c|
           bolt += Bolt.new(@args[:bolt_size], @args[:bolt_length]).output.rotate(y: 90).translate(y: @args[:size] / 2 + c * @args[:size], z: @args[:size] / 2)
         end
      end

      if @args[:holes].include?('back')
         @args[:configuration].times do |c|
           bolt += Bolt.new(@args[:bolt_size], @args[:bolt_length]).output.rotate(y: 90).translate(y: @args[:size] / 2 + c * @args[:size], z: @args[:length] - @args[:size] / 2)
         end
      end

      bolt
    end

    def description
       str = "T-Slot #{@args[:size]}x#{@args[:size] * @args[:configuration]}, length #{@args[:length]}mm"
      if !@args[:holes].nil?
         str << " with holes for M#{@args[:bolt_size]} on " + @args[:holes].split(',').join(' and ')
      end
    end
  end
end
