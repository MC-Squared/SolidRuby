require 'test_helper'

class PlaceTest < Minitest::Test
  def test_place_no_point_on
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

  def test_place_point_on
    c_move = cube(1, 2, 3)
    c_onto = cube(10, 20, 30)

    pl = place c_move, onto: c_onto, face: :top, edge: :right, corner: :top

    assert_equal 1, pl.transformations.count
    assert pl.transformations.first.is_a? Translate
    t = pl.transformations.first

    assert_in_delta c_onto.x - c_move.x/2.0, t.x
    assert_in_delta c_onto.y - c_move.y/2.0, t.y
    assert_in_delta c_onto.z - c_move.z/2.0, t.z
  end
end
