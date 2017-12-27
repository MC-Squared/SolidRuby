require 'test_helper'

class PositionTest < Minitest::Test
  def test_is_vertical
    faces = [:top, :bottom, :front, :back]
    edges = [:top, :bottom, :left, :right]

    faces.each do |f|
      edges.each do |e|
        if [:front, :back].include?(f) && [:left, :right].include?(e)
          assert is_vertical? f, e
        else
          refute is_vertical? f, e
        end
      end
    end
  end

  def test_is_horizontal
    faces = [:top, :bottom, :front, :back]
    edges = [:top, :bottom, :left, :right]

    faces.each do |f|
      edges.each do |e|
        if [:top, :bottom].include?(f) || [:top, :bottom].include?(e)
          assert is_horizontal? f, e
        else
          refute is_horizontal? f, e
        end
      end
    end
  end

  def test_is_x_dir
    faces = [:top, :bottom, :front, :back]
    edges = [:top, :bottom, :left, :right]

    faces.each do |f|
      edges.each do |e|
        if [:top, :bottom].include?(e)
          assert is_x_dir? f, e
        else
          refute is_x_dir? f, e
        end
      end
    end
  end

  def test_is_y_dir
    faces = [:top, :bottom, :front, :back]
    edges = [:top, :bottom, :left, :right]

    faces.each do |f|
      edges.each do |e|
        if [:top, :bottom].include?(f) && [:left, :right].include?(e)
          assert is_y_dir? f, e
        else
          refute is_y_dir? f, e
        end
      end
    end
  end

  def test_normalize_edges
    vert1 = {front: :right, left: :right, right: [:left, :right], back: :right}
    v_exp1 = {front: [:right], left: [:right], right: [:left, :right], back: [:right]}
    vert2 = {edges: :vertical}
    v_exp2 = {front: [:left, :right], back: [:left, :right]}

    assert_equal v_exp1, normalise_edges(vert1)
    assert_equal v_exp2, normalise_edges(vert2)

    horiz = {edges: :horizontal}
    h_exp = {front: [:top, :bottom], back: [:top, :bottom],
      left: [:top, :bottom], right: [:top, :bottom]}

    assert_equal h_exp, normalise_edges(horiz)

    all = {edges: :all}
    a_exp = {front: [:top, :bottom, :left, :right],
      left: [:top, :bottom],
      right: [:top, :bottom],
      back: [:top, :bottom, :left, :right]}

    assert_equal a_exp, normalise_edges(all)
  end

  def test_tranlations_for_edge
    c = cube(5, 10, 15)
    f = {faces: {top: [:top] }, onto: c, x: c.x, y: c.y, z: c.z}
    t = translations_for_edge(f).first

    assert_equal 0, t[:x_rot]
    assert_equal 90, t[:y_rot]
    assert_equal 90, t[:z_rot]
    assert_in_delta(-0.01, t[:x_trans])
    assert_in_delta c.y + 0.01, t[:y_trans]
    assert_in_delta c.z + 0.01, t[:z_trans]
    assert_equal c.x, t[:length]

    c = cube(5, 10, 15)
    f = {faces: {left: [:top] }, onto: c, x: c.x, y: c.y, z: c.z}
    t = translations_for_edge(f).first

    assert_equal 90, t[:x_rot]
    assert_equal 90, t[:y_rot]
    assert_equal 180, t[:z_rot]
    assert_in_delta(-0.01, t[:x_trans])
    assert_in_delta c.y + 0.01, t[:y_trans]
    assert_in_delta c.z + 0.01, t[:z_trans]
    assert_equal c.y, t[:length]

    c = cube(5, 10, 15)
    f = {faces: {back: [:right] }, onto: c, x: c.x, y: c.y, z: c.z}
    t = translations_for_edge(f).first

    assert_equal 0, t[:x_rot]
    assert_equal 0, t[:y_rot]
    assert_equal 90, t[:z_rot]
    assert_in_delta(-0.01, t[:x_trans])
    assert_in_delta c.y + 0.01, t[:y_trans]
    assert_in_delta(-0.01, t[:z_trans])
    assert_equal c.z, t[:length]
  end

  def test_corners
    c = corners(:top)

    assert_equal 4, c.count
    assert_equal c[0][:face], :top
    assert_equal c[1][:face], :top
    assert_equal c[2][:face], :top
    assert_equal c[3][:face], :top

    assert_equal c[0][:edge], :top
    assert_equal c[1][:edge], :top
    assert_equal c[2][:edge], :bottom
    assert_equal c[3][:edge], :bottom

    assert_equal c[0][:corner], :left
    assert_equal c[1][:corner], :right
    assert_equal c[2][:corner], :left
    assert_equal c[3][:corner], :right
  end
end
