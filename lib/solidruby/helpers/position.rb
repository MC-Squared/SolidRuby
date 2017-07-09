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

  def corners(face = :top)
    [
      {face: face, edge: :top, corner: :left},
      {face: face, edge: :top, corner: :right},
      {face: face, edge: :bottom, corner: :left},
      {face: face, edge: :bottom, corner: :right},
    ]
  end

  def is_vertical?(face, edge)
    if [:top, :bottom].include? face
      false
    elsif [:top, :bottom].include? edge
      false
    else
      true
    end
  end

  def is_horizontal?(face, edge)
    !is_vertical?(face, edge)
  end

  def is_x_dir?(face, edge)
    if is_vertical?(face, edge)
      false
    elsif [:front, :back, :top, :bottom].include?(face) &&
          [:top, :bottom].include?(edge)
      true
    else
      false
    end
  end

  def is_y_dir?(face, edge)
    return false if is_x_dir?(face, edge) || is_vertical?(face, edge)
    true
  end
end
