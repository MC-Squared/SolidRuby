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
    clearance = args[:clearance] || 0.01
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
        res[:z_trans] = -res[:length]/2.0 - (clearance*2)

        #position on edge
        if Helpers::is_horizontal?(face, edge)
          res[:y_rot] = 90
          res[:z_trans] = 0
        end

        if is_x_dir?(face, edge)
          res[:length] = args[:x]
          res[:x_trans] = -res[:length] / 2.0 - (clearance*2)
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

        if clearance > 0
          point[:x] = point[:x] > 0 ? point[:x] + clearance : point[:x] - clearance
          point[:y] = point[:y] > 0 ? point[:y] + clearance : point[:y] - clearance
          point[:z] = point[:z] > 0 ? point[:z] + clearance : point[:z] - clearance
        end

        res[:x_trans] += point[:x]
        res[:y_trans] += point[:y]
        res[:z_trans] += point[:z]

        trans << res
      end
    end

    trans
  end

  def calculate_point_on(args = {})
    face = args[:face] || :top
    edge = args[:edge] || :center
    corner = args[:corner] || :center
    face_offset = args[:face_offset] || 0
    edge_offset = args[:edge_offset] || 0
    corner_offset = args[:corner_offset] || 0

    vert_axis = :z
    horiz_axis = :x
    vert_dir = 1
    horiz_dir = 1

    pos = case face
    when :top
      vert_axis = :y
      horiz_dir = -1
      {x: args[:x] / 2.0, y: args[:y] / 2.0, z: args[:z] + face_offset}
    when :bottom
      vert_axis = :y
      horiz_dir = -1
      vert_dir = -1
      { x: args[:x] / 2.0, y: args[:y] / 2.0, z: -face_offset}
    when :left
      horiz_axis = :y
      { x: face_offset, y: args[:y] / 2.0, z: args[:z] / 2.0 }
    when :right
      horiz_axis = :y
      horiz_dir = -1
      { x: args[:x] + face_offset, y: args[:y] / 2.0, z: args[:z] / 2.0 }
    when :front
      horiz_dir = -1
      { x: args[:x] / 2.0, y: -face_offset, z: args[:z] / 2.0 }
    when :back
      { x: args[:x] / 2.0, y: args[:y] + face_offset, z: args[:z] / 2.0 }
    when :center
      horiz_dir = -1
      { x: args[:x] / 2.0, y: args[:y] / 2.0, z: args[:z] / 2.0 }
    end

    return pos if pos.nil?

    pos[:x] -= args[:x] / 2.0 if args[:centered]
    pos[:y] -= args[:y] / 2.0 if args[:centered]
    pos[:z] -= args[:z] / 2.0 if args[:centered_z]

    args[:transformations].each do |t|
      pos[:x] += t.x
      pos[:y] += t.y
      pos[:z] += t.z
    end

    #pos is now center of the given face, move to the given side
    h_change = case horiz_axis
    when :x
      args[:x] / 2.0
    when :y
      args[:y] / 2.0
    end

    v_change = case vert_axis
    when :y
      args[:y] / 2.0
    else
      args[:z] / 2.0
    end

    case edge
    when :top
      pos[vert_axis] += (v_change * vert_dir)
      pos[vert_axis] += (edge_offset * vert_dir)
    when :bottom
      pos[vert_axis] -= (v_change * vert_dir)
      pos[vert_axis] -= (edge_offset * vert_dir)
    when :left
      pos[horiz_axis] += (h_change * horiz_dir)
      pos[horiz_axis] += (edge_offset * horiz_dir)
    when :right
      pos[horiz_axis] -= (h_change * horiz_dir)
      pos[horiz_axis] -= (edge_offset * horiz_dir)
    end

    case corner
    when :top
      pos[vert_axis] += (v_change * vert_dir)
      pos[vert_axis] += (corner_offset * vert_dir)
    when :bottom
      pos[vert_axis] -= (v_change * vert_dir)
      pos[vert_axis] -= (corner_offset * vert_dir)
    when :left
      pos[horiz_axis] += (h_change * horiz_dir)
      pos[horiz_axis] += (corner_offset * horiz_dir)
    when :right
      pos[horiz_axis] -= (h_change * horiz_dir)
      pos[horiz_axis] -= (corner_offset * horiz_dir)
    end

    pos
  end
end
