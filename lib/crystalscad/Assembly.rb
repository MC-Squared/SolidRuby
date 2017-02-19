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
  class Assembly < CrystalScad::Primitive
    attr_accessor	:x, :y, :z, :skip, :color, :hardware, :transformations

    def method_missing(method, *args, &block)
      eval("def #{method}() @#{method}; end")
      send(method, *args, &block)
    end

    def transform(obj)
      return obj if @transformations.nil?
      @transformations.each do |t|
        obj.transformations << t
      end

      obj
    end

    def initialize(args = {})
      @args = args if @args.nil?

      @x = args[:x]
      @y = args[:y]
      @z = args[:z]

      add_to_bom
    end

    def add_to_bom
      unless @bom_added
        BillOfMaterial.bom.add(description) unless @args[:no_bom] == true
        @bom_added = true
      end
    end

    def description
      "No description set for Class #{self.class}"
    end

    def show
      transform(part(true))
    end

    def output
      transform(part(false))
    end

    def part(_show = false)
      CrystalScadObject.new
    end

    def walk_tree
      output.walk_tree
    end

    def +(args)
      output + args
    end

    def -(args)
      output - args
    end

    def *(args)
      output * args
    end

    def scad_output
      output.scad_output
    end

    def threads
      a = []
      [:threads_top, :threads_bottom, :threads_left, :threads_right, :threads_front, :threads_back].each do |m|
        next unless respond_to? m
        ret = send m
        unless ret.nil?
          if ret.is_a? Array
            a += ret
          else
            a << ret
          end
        end
      end

      a
    end

    # Makes the save_all method in CrystalScad skip the specified method(s)
    def self.skip(args)
      @skip = [] if @skip.nil?
      if args.is_a? Array
        args.each do |arg|
          skip(arg)
        end
        return
      end

      @skip << args.to_s
      nil
    end

    def self.get_skip
      @skip
    end

    def self.view(args)
      @added_views = [] if @added_views.nil?
      if args.is_a? Array
        args.each do |arg|
          view(arg)
        end
        return
      end

      @added_views << args.to_s
      nil
    end

    def self.get_views
      @added_views || []
    end

    def color(args = {})
      @color = args
      self
    end

    def colorize(res)
      return res if @color.nil?
      res.color(@color)
    end

    def show_hardware
      return nil if @hardware.nil? || (@hardware == [])
      res = nil
      @hardware.each do |part|
        res += part.show
      end
      transform(res)
    end
  end

  class Printed < Assembly
    def description
      "Printed part #{self.class}"
    end
  end

  class LasercutSheet < Assembly
    def description
      "Laser cut sheet #{self.class}"
    end

    def part(_show)
      square([@x, @y])
    end
  end
end
