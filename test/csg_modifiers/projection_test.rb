require 'test_helper'

class ProjectionTest < Minitest::Test
  def test_projection_construct
    c = cube(10)
    l = Projection.new(c, c: true)

    att = {cut: true}

    assert_equal 1, l.children.count
    assert_equal c, l.children[0]
    assert_equal att, l.attributes
  end

  def test_projection_helper
    c = cube(10)
    l = c.projection(cut: false)
    att = {cut: false}

    assert_equal 1, l.children.count
    assert_equal c, l.children[0]
    assert_equal att, l.attributes
  end

  def test_projection_scad
    o = SolidRubyObject.new
    exp = "projection(cut = true){\n}"

    assert_equal exp, o.projection(c: true).to_rubyscad
  end
end
