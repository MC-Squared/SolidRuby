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

end
