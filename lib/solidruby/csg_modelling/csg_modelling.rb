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
module SolidRuby::CSGModelling
  class CSGModelling < SolidRuby::SolidRubyObject
    def initialize(*list)
      super(list)
      @transformations = []
      @children = list
      @operation = self.class.name.split('::').last.downcase
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
      # puts @children.map{|l| l.walk_tree_classes}.inspect

      ret += '}'
    end

    def get_point_on(args = {})
      @children[0].get_point_on(args) if @children.count > 0
    end
  end
end
