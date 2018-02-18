require 'test_helper'

class LinearExtrudeTest < Minitest::Test
  def test_linear_extrude_construct
    c = cube(10)
    l = LinearExtrude.new(c, h: 10)

    att = {height: 10}

    assert_equal 1, l.children.count
    assert_equal c, l.children[0]
    assert_equal att, l.attributes
  end

  def test_linear_extrude_helper
    c = cube(10)
    l = c.linear_extrude(height: 20)
    att = {height: 20}

    assert_equal 1, l.children.count
    assert_equal c, l.children[0]
    assert_equal att, l.attributes
  end

  def test_linear_extrude_scad
    o = SolidRubyObject.new
    exp = "linear_extrude(height = 10){\n}"

    assert_equal exp, o.linear_extrude(h: 10).to_rubyscad
  end
end
