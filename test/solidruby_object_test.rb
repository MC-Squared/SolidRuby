require 'test_helper'

class SolidRubyObjectTest < Minitest::Test
  def test_place_onto
    o = SolidRubyObject.new

    assert_nil o.place_onto(nil)
    assert_nil o.place_onto({})

    on_cube = cube(10, 20, 30)
    vals = {
      {object: on_cube, face: :top, edge: :right, corner: :top} \
        => {x: 10, y: 20, z: 30},
      {object: on_cube, face: :top, edge: :center, corner: :center} \
        => {x: 5, y: 10, z: 30}
    }

    vals.each do |val, exp|
      o = SolidRubyObject.new
      val = o.place_onto(val)
      assert_equal exp, val.transformations.first.args
    end

    #now try with cube (responds to get_point_on)
    vals = {
      {object: on_cube, face: :top, edge: :right, corner: :top} \
        => {x: 10 - 0.5, y: 20 - 1, z: 30 - 1.5},
      {object: on_cube, face: :top, edge: :center, corner: :center} \
        => {x: 5 - 0.5, y: 10 - 1, z: 30 - 1.5}
    }

    vals.each do |val, exp|
      c = cube(1, 2, 3)
      val = c.place_onto(val)
      assert_equal exp, val.transformations.first.args
    end
  end

end
