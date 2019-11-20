require 'test_helper'

include SolidRuby

class CubeTest < Minitest::Test
  def test_translate_optimization
    obj = SolidRubyObject.new

    obj
      .translate(x: 1)
      .translate(x: 2, y: 1)
      .translate(x: 3, y: 7, z: 3)
      .translate(x: 3, z: 4)

    assert_equal 1, obj.transformations.count
    translate = obj.transformations.first
    assert_equal (1+2+3+3), translate.x
    assert_equal (1+7), translate.y
    assert_equal (3+4), translate.z
  end

  def test_translate_scad
    vals = {
      Translate.new(x: 0, y: 0, z: 0) => '',
      Translate.new(x: 1) => 'translate(v = [1, 0])',
      Translate.new(y: 2) => 'translate(v = [0, 2])',
      Translate.new(z: 3) => 'translate(v = [0, 0, 3])',
      Translate.new(x: 2, z: 3) => 'translate(v = [2, 0, 3])',
      Translate.new(x: 1, y: 2, z: 3) => 'translate(v = [1, 2, 3])',
      Translate.new(q: 3) => ''
    }

    vals.each do |val, exp|
      assert_equal exp, val.to_rubyscad
    end
  end
end
