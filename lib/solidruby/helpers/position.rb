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

  def normalise_edges(args={})
    faces = {}

    args.each do |key, val|
      if [:front, :back, :left, :right, :top, :bottom].include? key
        val = [val] unless val.is_a? Array
        faces[key] = val
        next
      elsif key == :edges
        if val == :vertical
          faces[:front] = [:left, :right]
          faces[:back] = [:left, :right]
        elsif val == :horizontal
          faces[:front] = [:top, :bottom]
          faces[:right] = [:top, :bottom]
          faces[:left] = [:top, :bottom]
          faces[:back] = [:top, :bottom]
        elsif val == :all
          faces[:front] = [:top, :bottom, :left, :right]
          faces[:right] = [:top, :bottom]
          faces[:left] = [:top, :bottom]
          faces[:back] = [:top, :bottom, :left, :right]
        end
      end
    end
    faces
  end

  def translations_for_edge(args={})
    tolerance = args[:tolerance] || 0.01
    trans = []
    args[:faces].each do |face, edges|
      edges.each do |edge|
        res = {}
        res[:z_rot] = 0
        res[:y_rot] = 0
        res[:x_rot] = 0
        res[:x_trans] = 0
        res[:y_trans] = 0
        res[:length] = args[:z]
        res[:z_trans] = -res[:length]/2.0 - (tolerance*2)

        #position on edge
        if Helpers::is_horizontal?(face, edge)
          res[:y_rot] = 90
          res[:z_trans] = 0
        end

        if is_x_dir?(face, edge)
          res[:length] = args[:x]
          res[:x_trans] = -res[:length] / 2.0 - (tolerance*2)
        elsif is_y_dir?(face, edge)
          res[:length] = args[:y]
          res[:y_trans] = res[:length] / 2.0
          res[:x_rot] = 90
        end

        #rotate to match edge
        rot_matrix = {
          [:top, :top] => 90,
          [:top, :left] => 180,
          [:top, :right] => 90,
          [:top, :bottom] => 180,

          [:bottom, :top] => 270,
          [:bottom, :left] => 270,
          [:bottom, :right] => 0,
          [:bottom, :bottom] => 0,

          [:left, :top] => 180,
          [:left, :left] => 90,
          [:left, :right] => 180,
          [:left, :bottom] => 270,

          [:right, :top] => 90,
          [:right, :left] => 270,
          [:right, :right] => 0,
          [:right, :bottom] => 0,

          [:front, :top] => 180,
          [:front, :left] => 180,
          [:front, :right] => 270,
          [:front, :bottom] => 270,

          [:back, :top] => 90,
          [:back, :left] => 0,
          [:back, :right] => 90,
          [:back, :bottom] => 0,
        }

        res[:z_rot] = rot_matrix[[face, edge]]

        point = args[:onto].get_point_on(face: face, edge: edge)

        if tolerance > 0
          point[:x] = point[:x] > 0 ? point[:x] + tolerance : point[:x] - tolerance
          point[:y] = point[:y] > 0 ? point[:y] + tolerance : point[:y] - tolerance
          point[:z] = point[:z] > 0 ? point[:z] + tolerance : point[:z] - tolerance
        end

        res[:x_trans] += point[:x]
        res[:y_trans] += point[:y]
        res[:z_trans] += point[:z]

        trans << res
      end
    end

    trans
  end
end
