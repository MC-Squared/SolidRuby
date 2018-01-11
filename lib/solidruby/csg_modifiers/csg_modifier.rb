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
module SolidRuby::CSGModifiers
  class CSGModifier < SolidRuby::SolidRubyPhysical
    def initialize(object, attributes)
      super(attributes)
      @children = [object]
    end

    def to_rubyscad
      att = @attributes
      if att.is_a? Hash
        att = @attributes.select {|k, v| !v.nil? }.collect do |k, v|
          sv = RubyScadBridge.new.format_value(v)
          "#{k} = #{sv}"
        end.sort_by{ |x| x[0] == 'f' ? ('z' + x) : x }
      end

      att = att.join(', ') if att.is_a? Array

      #	Apparently this doesn't work for CSGModifiers, like it does for other things in RubyScad?
      # also this is a dirty, dirty hack.
      att = att.gsub('fn', '$fn').gsub('$$', '$')
      ret = "#{@operation}(#{att}){"
      @children ||= []
      @children.each do |child|
        begin
          ret += child.walk_tree
        rescue NoMethodError
        end
      end
      ret += '}'
    end
  end
end
