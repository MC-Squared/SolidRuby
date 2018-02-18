require 'test_helper'

class RotateExtrudeTest < Minitest::Test
  def test_rotate_extrude_construct
    c = cube(10)
    l = RotateExtrude.new(c, a: 10, c: 2)

    att = {angle: 10, convexity: 2}

    assert_equal 1, l.children.count
    assert_equal c, l.children[0]
    assert_equal att, l.attributes
  end

  def test_rotate_extrude_helper
    c = cube(10)
    l = c.rotate_extrude(angle: 20)
    att = {angle: 20}

    assert_equal 1, l.children.count
    assert_equal c, l.children[0]
    assert_equal att, l.attributes
  end

  def test_rotate_extrude_scad
    o = SolidRubyObject.new
    exp = "rotate_extrude(angle = 10){\n}"

    assert_equal exp, o.rotate_extrude(a: 10).to_rubyscad
  end
end
