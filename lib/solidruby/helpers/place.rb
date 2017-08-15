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
module SolidRuby::Helpers
  def place(obj, args={})
    return obj if args.nil? || obj.nil? || args[:onto].nil?

    onto = args[:onto]
    face = args[:face] || :top
    edge = args[:edge] || :center
    corner = args[:corner] || :center
    face_offset = args[:face_offset] || 0
    edge_offset = args[:edge_offset] || 0
    corner_offset = args[:corner_offset] || 0

    if onto.respond_to? :get_point_on
      move_to = onto.get_point_on(
        face: face,
        edge: edge,
        corner: corner,
        face_offset: face_offset,
        edge_offset: edge_offset,
        corner_offset: corner_offset
      )

      if (obj.respond_to? :get_point_on)
        move_me = self.get_point_on(face: :center, edge: :center, corner: :center)
        move_to[:x] -= move_me[:x]
        move_to[:y] -= move_me[:y]
        move_to[:z] -= move_me[:z]
      end

      obj.translate(move_to)
    end

    obj
  end
end
