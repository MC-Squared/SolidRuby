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
  class Import < Primitive
    alias_attr :file
    alias_attr :layer
    alias_attr :center, :ce
    alias_attr :convexity, :co

    def initialize(attributes)
      if attributes.is_a? String
        attributes = {file: attributes}
      end
      abs_path = attributes.delete(:absolue_path) || false

      super(attributes)
      @attributes[:file] = File.expand_path(@attributes[:file]) if abs_path
    end

    def to_rubyscad
      RubyScadBridge.new.import(@attributes)
    end
  end

  def import(args)
    Import.new(args)
  end
end
