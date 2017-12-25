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
  class Text < Primitive
    alias_attr :text
    alias_attr :size
    alias_attr :font
    alias_attr :valign, :va
    alias_attr :halign, :ha
    alias_attr :spacing, :sp
    alias_attr :direction
    alias_attr :language
    alias_attr :script, :sc

    def initialize(attributes)
      if attributes.is_a? String
        attributes = {text: attributes}
      end
      super(attributes)
    end

    def to_rubyscad
      RubyScadBridge.new.text(@attributes)
    end
  end

  def text(args = {})
    Text.new(args)
  end
end
