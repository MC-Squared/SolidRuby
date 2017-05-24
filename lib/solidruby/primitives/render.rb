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
  class Render < Primitive
    def initialize(object, attributes)
      @operation = 'render'
      @children = [object]
      super(object, attributes)
    end

    def to_rubyscad
      @children ||= []
      ret = "#{@operation}(){"
      @children.each do |child|
        begin
          ret += child.walk_tree
        rescue NoMethodError
        end
      end

      ret += '}'
    end
  end

  def render(args = {})
    Render.new(self, args)
  end
end
