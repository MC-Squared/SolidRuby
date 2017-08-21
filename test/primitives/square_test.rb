require 'test_helper'

class SquareTest < Minitest::Test
  def test_square_constructor
    s = Square.new(10)
    assert_equal 0, s.transformations.count
    assert_equal 10, s.size
    assert_equal 10, s.x
    assert_equal 10, s.y
    refute s.centered?

    s = Square.new(size: 100)
    assert_equal 0, s.transformations.count
    assert_equal 100, s.size
    assert_equal 100, s.x
    assert_equal 100, s.y
    refute s.centered?

    s = Square.new(x: 20, y: 30)
    assert_equal 0, s.transformations.count
    assert_equal [20, 30], s.size
    assert_equal 20, s.x
    assert_equal 30, s.y
    refute s.centered?

    s = Square.new(s: 7, c: true)
    assert_equal 0, s.transformations.count
    assert_equal 7, s.size
    assert_equal 7, s.x
    assert_equal 7, s.y
    assert s.centered?
  end

  def test_square_center
    s = Square.new(x: 1, y: 2, c: true)
    assert_equal 0, s.transformations.count
    assert s.center

    s = Square.new(x: 1, y: 2).center
    assert_equal 0, s.transformations.count
    assert s.center

    s = Square.new(x: 1, y: 2).center_xy
    assert_equal 0, s.transformations.count
    assert s.center

    s = Square.new(x: 1, y: 2).center_x
    refute s.centered?
    assert_equal 1, s.transformations.count
    assert_equal ({x: -0.5}), s.transformations.first.args

    s = Square.new(x: 1, y: 2).center_y
    refute s.centered?
    assert_equal 1, s.transformations.count
    assert_equal ({y: -1}), s.transformations.first.args
  end

  def test_square_helper
    s = square(size: [10, 20])
    assert_equal 0, s.transformations.count
    assert_equal 10, s.x
    assert_equal 20, s.y
    refute s.centered?

    s = square([1, 2])
    assert_equal 0, s.transformations.count
    assert_equal 1, s.x
    assert_equal 2, s.y
    refute s.centered?

    s = square(100)
    assert_equal 0, s.transformations.count
    assert_equal 100, s.x
    assert_equal 100, s.y
    refute s.centered?

    s = square(50, 60)
    assert_equal 0, s.transformations.count
    assert_equal 50, s.x
    assert_equal 60, s.y
    refute s.centered?

    s = square(100, true)
    assert_equal 0, s.transformations.count
    assert_equal 100, s.x
    assert_equal 100, s.y
    assert s.centered?
  end

  def test_square_scad
    s = Square.new(x: 10, y: 20, center: true)
    exp = "square(size = [10, 20], center = true);"

    assert_equal exp, s.to_rubyscad
  end
end
