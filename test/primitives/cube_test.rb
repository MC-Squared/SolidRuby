require 'test_helper'

class CubeTest < Minitest::Test
  def test_cube_scad
    vals = {
      Cube.new(x: 1, y: 2, z: 3) => 'cube(size = [1, 2, 3]);',
      Cube.new(x: 1, y: 2) => 'cube(size = [1, 2, nil]);',
      Cube.new(x: 10, y: 10, z: 10, center: true) => 'cube(size = [10, 10, 10], center = true);'
    }

    vals.each do |val, exp|
      assert_equal exp, val.to_rubyscad
    end
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
    assert_equal true, c.centered?
  end

  def test_cube_helper
    vals = {
      cube(10) => 'cube(size = [10, 10, 10]);',
      cube(10, 20) => 'cube(size = [10, 20, nil]);',
      cube(10, 20, 30) => 'cube(size = [10, 20, 30]);',
      cube([1, 2, 3]) => 'cube(size = [1, 2, 3]);',
      cube(x: 5, y: 10, z: 15) => 'cube(size = [5, 10, 15]);'
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
  end
end
