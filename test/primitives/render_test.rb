require 'test_helper'

class RenderTest < Minitest::Test
  def test_render_scad
    vals = {
      Primitive.new.render => "render(){\n}",
      cube(10, 10, 10).render => "render(){cube(size = [10, 10, 10]);\n}"
    }

    vals.each do |val, exp|
      assert_equal exp, val.to_rubyscad
    end
  end
end
