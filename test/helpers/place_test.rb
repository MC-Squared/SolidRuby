require 'test_helper'

class PlaceTest < Minitest::Test
  def test_place
    o = SolidRubyObject.new

    assert_equal o, place(o, onto: nil)
    assert_equal o, place(o)

    on_cube = cube(10, 20, 30)
    vals = {
      {onto: on_cube, face: :top, edge: :right, corner: :top} \
        => {x: 10, y: 20, z: 30},
      {onto: on_cube, face: :top, edge: :center, corner: :center} \
        => {x: 5, y: 10, z: 30},
      {onto: on_cube, face: :front, edge: :left} \
        => {x: 0, y: 0, z: 15}
    }

    vals.each do |val, exp|
      o = SolidRubyObject.new
      val = place o, val
      assert_equal exp, o.transformations.first.args
    end
  end
end
