require 'test_helper'

class DifferenceTest < Minitest::Test
  def test_difference_construct
    c1 = cube(10)
    c2 = cube(20)

    d = Difference.new(c1, c2)

    assert_equal 0, d.transformations.count
    assert_equal 2, d.children.count
    assert_equal c1, d.children[0]
    assert_equal c2, d.children[1]
  end

  def test_difference_helper
    c1 = cube(10)
    c2 = cube(20)

    d = c1 - c2

    assert_equal 0, d.transformations.count
    assert_equal 2, d.children.count
    assert_equal c1, d.children[0]
    assert_equal c2, d.children[1]
  end

  # unions should be combined if they have no translations
  def test_difference_optmize
    c1 = cube(10)
    c2 = cube(20)
    c3 = cube(30)

    d = c1 - c2 - c3

    # combined together
    assert_equal 0, d.transformations.count
    assert_equal 3, d.children.count
    assert_equal c1, d.children[0]
    assert_equal c2, d.children[1]
    assert_equal c3, d.children[2]

    # not combined, due to transformation
    d1 = c1 - c2
    d1.translate(z: 10)
    d2 = d1 - c3

    assert_equal 1, d1.transformations.count
    assert_equal 2, d1.children.count
    assert_equal c1, d1.children[0]
    assert_equal c2, d1.children[1]

    assert_equal 0, d2.transformations.count
    assert_equal 2, d1.children.count
    assert_equal d1, d2.children[0]
    assert_equal c3, d2.children[1]


    d1 = c1 - c2
    d2 = c2 - c3
    d3 = d1 - d2

    assert_equal 4, d3.children.count
    assert_equal c1, d3.children[0]
    assert_equal c2, d3.children[1]
    assert_equal c2, d3.children[2]
    assert_equal c3, d3.children[3]
  end

  def test_difference_scad
    c1 = cube(10)
    c2 = cube(20)

    d = Difference.new(c1, c2)
    exp = "difference(){cube(size = [10, 10, 10]);\n" \
          "cube(size = [20, 20, 20]);\n" \
          '}'

    assert_equal exp, d.to_rubyscad
  end
end
