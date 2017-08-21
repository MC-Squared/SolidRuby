require 'test_helper'

class CubeTest < Minitest::Test
  def test_cube_constructor
    c = Cube.new(x: 1, y: 2, z: 3)

    assert_equal 1, c.x
    assert_equal 2, c.y
    assert_equal 3, c.z
    refute c.centered?

    c = Cube.new(x: 10, y: 20, z: 30, c: true)

    assert_equal 10, c.x
    assert_equal 20, c.y
    assert_equal 30, c.z
    assert c.centered?

    c = Cube.new(10)

    assert_equal 10, c.x
    assert_equal 10, c.y
    assert_equal 10, c.z
    refute c.centered?

    c = Cube.new(1, 2, 3)

    assert_equal 1, c.x
    assert_equal 2, c.y
    assert_equal 3, c.z
    refute c.centered?

    c = Cube.new(size: [10, 20, 30])

    assert_equal 10, c.x
    assert_equal 20, c.y
    assert_equal 30, c.z
    refute c.centered?
  end

  def test_cube_helper
    c = cube(x: 1, y: 2, z: 3)

    assert_equal 1, c.x
    assert_equal 2, c.y
    assert_equal 3, c.z
    refute c.centered?

    c = cube(x: 10, y: 20, z: 30, c: true)

    assert_equal 10, c.x
    assert_equal 20, c.y
    assert_equal 30, c.z
    assert c.centered?

    c = cube(10)

    assert_equal 10, c.x
    assert_equal 10, c.y
    assert_equal 10, c.z
    refute c.centered?

    c = cube(1, 2, 3)

    assert_equal 1, c.x
    assert_equal 2, c.y
    assert_equal 3, c.z
    refute c.centered?

    c = cube(size: [10, 20, 30])

    assert_equal 10, c.x
    assert_equal 20, c.y
    assert_equal 30, c.z
    refute c.centered?
  end

  def test_cube_center
    args = { x: 1, y: 2, z: 3 }

    vals = {
      Cube.new(args).center_xy => { x: -0.5, y: -1.0 },
      Cube.new(args).center_x => { x: -0.5 },
      Cube.new(args).center_y => { y: -1.0 },
      Cube.new(args).center_z => { z: -1.5 },

    }

    vals.each do |val, exp|
      assert_equal 1, val.transformations.count
      assert_equal exp, val.transformations.first.args
    end

    c = Cube.new(args).center
    assert_equal 0, c.transformations.count
    assert c.centered?
  end

  def test_cube_scad
    vals = {
      Cube.new(x: 1, y: 2, z: 3) => 'cube(size = [1, 2, 3]);',
      Cube.new(size: [4, 5, 6]) => 'cube(size = [4, 5, 6]);',
      Cube.new(x: 10, y: 10, z: 10, center: true) => 'cube(size = [10, 10, 10], center = true);'
    }

    vals.each do |val, exp|
      assert_equal exp, val.to_rubyscad
    end
  end

  def test_cube_get_point_on
    cube_args = {x: 10, y: 20, z: 30}
    vals = {
      #6 faces
      {face: :top, edge: :center, corner: :center} => { x: 5, y: 10, z: 30 },
      {face: :bottom, edge: :center, corner: :center} => { x: 5, y: 10, z: 0 },
      {face: :left, edge: :center, corner: :center} => { x: 0, y: 10, z: 15 },
      {face: :right, edge: :center, corner: :center} => { x: 10, y: 10, z: 15 },
      {face: :front, edge: :center, corner: :center} => { x: 5, y: 0, z: 15 },
      {face: :back, edge: :center, corner: :center} => { x: 5, y: 20, z: 15 },

      #4 edges (top)
      {face: :top, edge: :left, corner: :center} => { x: 0, y: 10, z: 30 },
      {face: :top, edge: :right, corner: :center} => { x: 10, y: 10, z: 30 },
      {face: :top, edge: :top, corner: :center} => { x: 5, y: 20, z: 30 },
      {face: :top, edge: :bottom, corner: :center} => { x: 5, y: 0, z: 30 },

      #4 corners (top)
      {face: :top, edge: :left, corner: :top} => { x: 0, y: 20, z: 30 },
      {face: :top, edge: :right, corner: :bottom} => { x: 10, y: 0, z: 30 },
      {face: :top, edge: :top, corner: :left} => { x: 0, y: 20, z: 30 },
      {face: :top, edge: :bottom, corner: :right} => { x: 10, y: 0, z: 30 },

      #4 corners (left)
      {face: :left, edge: :left, corner: :top} => { x: 0, y: 20, z: 30 },
      {face: :left, edge: :right, corner: :bottom} => { x: 0, y: 0, z: 0 },
      {face: :left, edge: :top, corner: :right} => { x: 0, y: 0, z: 30 },
      {face: :left, edge: :bottom, corner: :left} => { x: 0, y: 20, z: 0 },

      #4 corners (right)
      {face: :right, edge: :left, corner: :top} => { x: 10, y: 0, z: 30 },
      {face: :right, edge: :right, corner: :bottom} => { x: 10, y: 20, z: 0 },
      {face: :right, edge: :top, corner: :right} => { x: 10, y: 20, z: 30 },
      {face: :right, edge: :bottom, corner: :left} => { x: 10, y: 0, z: 0 },

      #4 corners (back)
      {face: :back, edge: :left, corner: :top} => { x: 10, y: 20, z: 30 },
      {face: :back, edge: :right, corner: :bottom} => { x: 0, y: 20, z: 0 },
      {face: :back, edge: :top, corner: :right} => { x: 0, y: 20, z: 30 },
      {face: :back, edge: :bottom, corner: :left} => { x: 10, y: 20, z: 0 },

      #center
      {face: :center, edge: :center, corner: :center} => { x: 5, y: 10, z: 15 },
    }

    vals.each do |val, exp|
      val = Cube.new(cube_args).get_point_on(val)
      assert_equal exp, val
    end

    #check x/y centered cube
    vals = {
      #4 corners (top)
      {face: :top, edge: :left, corner: :top} => { x: -5, y: 10, z: 30 },
      {face: :top, edge: :right, corner: :bottom} => { x: 5, y: -10, z: 30 },
      {face: :top, edge: :top, corner: :right} => { x: 5, y: 10, z: 30 },
      {face: :top, edge: :bottom, corner: :left} => { x: -5, y: -10, z: 30 },
    }

    vals.each do |val, exp|
      val = Cube.new(cube_args).center_xy.get_point_on(val)
      assert_equal exp, val
    end

    #check x/y/z centered cube
    vals = {
      #4 corners (top)
      {face: :left, edge: :left, corner: :top} => { x: -5, y: 10, z: 15 },
      {face: :right, edge: :right, corner: :bottom} => { x: 5, y: 10, z: -15 },
      {face: :top, edge: :top, corner: :right} => { x: 5, y: 10, z: 15 },
      {face: :top, edge: :bottom, corner: :left} => { x: -5, y: -10, z: 15 },
    }

    vals.each do |val, exp|
      val = Cube.new(cube_args).center.get_point_on(val)
      assert_equal exp, val
    end

    vals = {
      #check with face offset
      {face: :left, face_offset: 5 }    => { x: 5, y: 10, z: 15 },
      {face: :left, face_offset: -5 }   => { x: -5, y: 10, z: 15 },
      {face: :right, face_offset: 3}    => { x: 10 + 3, y: 10, z: 15 },
      {face: :right, face_offset: -3}   => { x: 10 - 3, y: 10, z: 15 },
      {face: :top, face_offset: 2}      => { x: 5, y: 10, z: 30 + 2},
      {face: :top, face_offset: -2}     => { x: 5, y: 10, z: 30 - 2},
      {face: :bottom, face_offset: 7}  => { x: 5, y: 10, z: -7 },
      {face: :bottom, face_offset: -7}  => { x: 5, y: 10, z: 7 },
      {face: :front, face_offset: 6}  => { x: 5, y: -6, z: 15 },
      {face: :front, face_offset: -6}  => { x: 5, y: 6, z: 15 },
      {face: :back, face_offset: 4}  => { x: 5, y: 20+4, z: 15 },
      {face: :back, face_offset: -4}  => { x: 5, y: 20-4, z: 15 },

      #edge offset
      {face: :top, edge: :top, edge_offset: 5 } \
        => { x: 5, y: 20+5, z: 30 },
      {face: :top, edge: :left, edge_offset: -5 } \
        => { x: 0+5, y: 10, z: 30 },
      {face: :top, edge: :right, edge_offset: 5 } \
        => { x: 10+5, y: 10, z: 30 },
      {face: :left, edge: :top, edge_offset: -5 } \
        => { x: 0, y: 10, z: 30-5 },
      {face: :left, edge: :top, edge_offset: 5 } \
        => { x: 0, y: 10, z: 30+5 },
      {face: :back, edge: :right, edge_offset: -5 } \
        => { x: 0+5, y: 20, z: 15 },
      {face: :back, edge: :right, edge_offset: 5 } \
        => { x: 0-5, y: 20, z: 15 },

      #corner offset
      {face: :top, edge: :top, corner: :left, corner_offset: 5 } \
        => { x: -5, y: 20, z: 30 },
      {face: :top, edge: :top, corner: :left, corner_offset: -5 } \
        => { x: 5, y: 20, z: 30 },
      {face: :top, edge: :top, corner: :right, corner_offset: 5 } \
        => { x: 15, y: 20, z: 30 },
      {face: :top, edge: :top, corner: :right, corner_offset: -5 } \
        => { x: 5, y: 20, z: 30 },
    }

    vals.each do |val, exp|
      val = Cube.new(cube_args).get_point_on(val)
      assert_equal exp, val
    end
  end

  def test_cube_fillet
    c = Cube.new(x: 10, y: 20, z: 30)
    cf = c.fillet(top: :top, r: 2)

    assert cf.is_a? Difference
    assert_equal 2, cf.children.count
    assert c, cf.children.first

    # actual fillet
    f = cf.children[1]
    assert f.is_a? Difference
    assert_equal 2, f.children.count
    assert f.children[0].is_a? Cube
    assert_equal 4, f.children[0].x
    assert_equal 4, f.children[0].y
    assert_in_delta c.x + 0.02, f.children[0].z

    assert f.children[1].is_a? Cylinder
    assert_equal c.x + 0.04, f.children[1].h
    assert_equal 2, f.children[1].r

    cf = c.fillet(front: :right, r: 3)

    assert cf.is_a? Difference
    assert_equal 2, cf.children.count
    assert c, cf.children.first

    # actual fillet
    f = cf.children[1]
    assert f.is_a? Difference
    assert_equal 2, f.children.count
    assert f.children[0].is_a? Cube
    assert_equal 6, f.children[0].x
    assert_equal 6, f.children[0].y
    assert_in_delta c.z + 0.02, f.children[0].z

    assert f.children[1].is_a? Cylinder
    assert_equal c.z + 0.04, f.children[1].h
    assert_equal 3, f.children[1].r
  end

  def test_cube_chamfer
    c = Cube.new(x: 10, y: 20, z: 30)
    cc = c.chamfer(top: :top, h: 2)

    assert cc.is_a? Difference
    assert_equal 2, cc.children.count
    assert c, cc.children.first

    # actual chamfer
    ch = cc.children[1]
    assert ch.is_a? LinearExtrude
    assert_equal c.x + 0.02, ch.height

    cc = c.chamfer(back: :left, h: 3)

    assert cc.is_a? Difference
    assert_equal 2, cc.children.count
    assert c, cc.children.first

    # actual chamfer
    ch = cc.children[1]
    assert ch.is_a? LinearExtrude
    assert_equal c.z + 0.02, ch.height
  end
end
