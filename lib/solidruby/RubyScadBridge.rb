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
#
# This code is based on RubyScad (https://github.com/cjbissonnette/RubyScad)
# which is GPLv3
#
require 'matrix'

module SolidRuby
  class RubyScadBridge
    START_BLOCK = '{'.freeze
    END_BLOCK   = '}'.freeze
    TAB_SIZE    = 3
    PAD         = 0.01
    FP_P        = 3

    CUBE_STR            = 'cube(%<args>s);'.freeze
    SPHERE_STR          = 'sphere(%<args>s);'.freeze
    CYLINDER_STR        = 'cylinder(%<args>s);'.freeze
    POLYHEDRON_STR      = 'polyhedron(%<args>s);'.freeze
    SQUARE_STR          = 'square(%<args>s);'.freeze
    CIRCLE_STR          = 'circle(%<args>s);'.freeze
    POLYGON_STR         = 'polygon(%<args>s);'.freeze
    TRANSLATE_STR       = 'translate(%<args>s)'.freeze
    ROTATE_STR          = 'rotate(%<args>s)'.freeze
    SCALE_STR           = 'scale(%<args>s)'.freeze
    MIRROR_STR          = 'mirror(%<args>s)'.freeze
    MULTMATRIX_STR      = 'multmatrix(%<args>s)'.freeze
    COLOR_STR           = 'color(%<args>s)'.freeze
    UNION_STR           = 'union(%<args>s)'.freeze
    DIFFERENCE_STR      = 'difference(%<args>s)'.freeze
    INTERSECTION_STR    = 'intersection(%<args>s)'.freeze
    RENDER_STR          = 'render(%<args>s)'.freeze
    MINKOWSKI_STR       = 'minkowski(%<args>s)'.freeze
    HULL_STR            = 'hull(%<args>s)'.freeze
    BACKGROUND_STR      = '%'.freeze
    DEBUG_STR           = '#'.freeze
    ROOT_STR            = '!'.freeze
    DISABLE_STR         = '*'.freeze
    IMPORT_STR          = 'import(%<args>s);'.freeze
    SURFACE_STR         = 'surface(%<args>s);'.freeze
    LINEAR_EXTRUDE_STR  = 'linear_extrude(%<args>s)'.freeze
    ROTATE_EXTRUDE_STR  = 'rotate_extrude(%<args>s)'.freeze
    PROJECTION_STR      = 'projection(%<args>s)'.freeze

    INCLUDE_STR = 'include <%<file>s>'.freeze
    USE_STR     = 'use <%<file>s>'.freeze
    ECHO_STR    = 'echo(%<string>s);'.freeze
    FA_STR      = '$fa = %<value>s;'.freeze
    FS_STR      = '$fs = %<value>s;'.freeze
    FN_STR      = '$fn = %<value>s;'.freeze

    def fa(value)
      format_output FA_STR % { value: value }
    end

    def fs(value)
      format_output FS_STR % { value: value }
    end

    def fn(value)
      format_output FN_STR % { value: value }
    end

    def include_scad(file)
      format_output INCLUDE_STR % { file: file }
    end

    def use(file)
      format_output USE_STR % { file: file }
    end

    def echo(*args)
      format_output ECHO_STR % { string: args.join(', ') }
    end

    def projection(args = {}, &block)
      format_command PROJECTION_STR, args, &block
    end

    def linear_extrude(args = {}, &block)
      str_end = args.include?(:file) ? ';' : ''
      format_command LINEAR_EXTRUDE_STR.concat(str_end), args, &block
    end

    def rotate_extrude(args = {}, &block)
      str_end = args.include?(:file) ? ';' : ''
      format_command ROTATE_EXTRUDE_STR.concat(str_end), args, &block
    end

    def import(args = {})
      format_command IMPORT_STR, args
    end

    def difference(&block)
      format_command DIFFERENCE_STR, &block
    end

    def union(&block)
      format_command UNION_STR, &block
    end

    def intersection(&block)
      format_command INTERSECTION_STR, &block
    end

    def render(args = {}, &block)
      format_command RENDER_STR, args, &block
    end

    def minkowski(&block)
      format_command MINKOWSKI_STR, &block
    end

    def hull(&block)
      format_command HULL_STR, &block
    end

    def background
      format_output BACKGROUND_STR
      yield if block_given?
    end

    def debug
      format_output DEBUG_STR
      yield if block_given?
    end

    def root
      format_output ROOT_STR
      yield if block_given?
    end

    def disable
      format_output DISABLE_STR
      yield if block_given?
    end

    def cube(args = {})
      format_command CUBE_STR, args
    end

    def sphere(args = {})
      if args.include?(:d)
        args[:r] = args[:d] / 2.0
        args.delete(:d)
      end
      format_command SPHERE_STR, args
    end

    def polyhedron(args = {})
      format_command POLYHEDRON_STR, args
    end

    def square(args = {})
      format_command SQUARE_STR, args
    end

    def circle(args = {})
      if args.include?(:d)
        args[:r] = args[:d] / 2.0
        args.delete(:d)
      end
      format_command CIRCLE_STR, args
    end

    def polygon(args = {})
      format_command POLYGON_STR, args
    end

    def surface(args = {})
      format_command SURFACE_STR, args
    end

    def cylinder(args = {})
      if args.include?(:d)
        args[:r] = args[:d] / 2.0
        args.delete(:d)
      end
      if args.include?(:d1)
        args[:r1] = args[:d1] / 2.0
        args.delete(:d1)
      end
      if args.include?(:d2)
        args[:r2] = args[:d2] / 2.0
        args.delete(:d2)
      end
      format_command CYLINDER_STR, args
    end

    def rotate(args = {}, &block)
      vector_input(args, :a)
      format_command ROTATE_STR, args, &block
    end

    def translate(args = {}, &block)
      vector_input(args, :v)
      format_command TRANSLATE_STR, args, &block
    end

    def scale(args = {}, &block)
      vector_input(args, :v)
      format_command SCALE_STR, args, &block
    end

    def mirror(args = {}, &block)
      vector_input(args, :v)
      format_command MIRROR_STR, args, &block
    end

    def multmatrix(args = {}, &block)
      format_command MULTMATRIX_STR, args, &block
    end

    def color(args = {}, &block)
      if args.include?(:color)
        args[:color] = "\"#{args[:color]}\""
      else
        args[:color] = [args.fetch(:r, 0), args.fetch(:g, 0), args.fetch(:b, 0), args.fetch(:a, 1)].to_s
      end
      delete_from(args, :r, :g, :b, :a)
      format_command(COLOR_STR, args[:color], &block)
    end

    def format_command(cmd_str, args = {}, &block)
      if args.is_a? String
        arg_str = args
      else
        arg_str = args.collect { |k, v| "#{format_key(k)} = #{format_value(v)}" }.join(', ')
      end
      format_block cmd_str % { args: arg_str }, &block
    end

    def format_key(key)
      key = key.to_s
      key.prepend('$') if key.match('^f[asn]$')
      key
    end

    def format_value(var)
      if var.is_a?(Vector) || var.is_a?(Matrix)
        var.to_a.to_s
      elsif var.is_a? String
        '"' + var + '"'
      elsif var.is_a? Float
        "%.#{FP_P}f" % var.round(FP_P).to_s
      else
        var.to_s
      end
    end

    def delete_from(hash, *keys)
      keys.each { |k| hash.delete(k) }
    end

    def vector_input(args, element)
      unless args.include?(element)
        args[element] = [args.fetch(:x, 0), args.fetch(:y, 0)]
        args[element].push(args[:z]) if args.include?(:z)
        delete_from(args, :x, :y, :z)
      end
    end

    def new_line
      format_output "\n"
    end

    def start_block
      format_output START_BLOCK
    end

    def end_block
      format_output END_BLOCK
    end

    def end_all_blocks
      end_block while @@tab_level > 0
    end

    def space_string(str, tab_level)
      ((' ' * TAB_SIZE) * tab_level) + str
    end

    def raw_output(str)
      str
    end

    def format_output(str)
      str
    end

    def format_block(output_str)
      output_str
    end

    def self.start_output
      @@output_file ||= nil
      if ARGV[0] && ARGV[0].include?('.scad')
        @@output_file = ARGV[0]
        ARGV.shift
      end
      if @@output_file
        File.open(@@output_file, 'w') do |f|
          f.puts "//created with rubyscad #{VERSION}\n\n"
        end
      end
    end

    def self.extended(_mod)
      start_output
    end

    def self.included(_mod)
      start_output
    end

    start_output if __FILE__ == $PROGRAM_NAME

    def lookup(x, points)
      xmin = 0.0
      xmax = 0.0
      points.keys.sort.reverse_each do |k|
        if k <= x
          xmin = k
          break
        end
      end
      points.keys.sort.each do |k|
        if k >= x
          xmax = k
          break
        end
      end
      return points[xmax] if x == xmax
      return points[xmin] if x == xmin
      points[xmin] + (((x - xmin) * (points[xmax] - points[xmin])) / (xmax - xmin))
    end

    def dxf_cross(_args = {})
      0.0
    end

    def dxf_dim(_args = {})
      0.0
    end
  end
end
