require 'test_helper'

class RenderTest < Minitest::Test
  def test_render_construct
    o = SolidRubyObject.new
    r = Render.new(o)

    assert_equal 0, r.transformations.count
    assert_equal 1, r.children.count
    assert_equal o, r.children.first

    r = Render.new(o, co: 5)

    assert_equal 0, r.transformations.count
    assert_equal 5, r.convexity
    assert_equal 1, r.children.count
    assert_equal o, r.children.first
  end

  def test_render_helper
    o = SolidRubyObject.new
    r = o.render

    assert_equal 0, r.transformations.count
    assert_equal 1, r.children.count
    assert_equal o, r.children.first

    r = render(o)
    assert_equal 0, r.transformations.count
    assert_equal 1, r.children.count
    assert_equal o, r.children.first
  end

  def test_render_scad
    o = SolidRubyObject.new
    r = Render.new(o, co: 5)
    exp = "render(convexity = 5){\n}"

    assert_equal exp, r.to_rubyscad
  end

  # def test_render_scad
  #   vals = {
  #     Primitive.new.render => "render(){\n}",
  #     cube(10, 10, 10).render => "render(){cube(size = [10, 10, 10]);\n}"
  #   }
  #
  #   vals.each do |val, exp|
  #     assert_equal exp, val.to_rubyscad
  #   end
  #end
end
