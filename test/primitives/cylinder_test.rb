require 'test_helper'

class CylinderTest < Minitest::Test
  def test_cylinder_scad
    vals = {
      Cylinder.new(h: 1) => 'cylinder(h = 1);',
      Cylinder.new(r: 2) => 'cylinder(r = 2);',
      Cylinder.new(d: 3) => 'cylinder(r = 1.500);',
      Cylinder.new(h: 2, r: 3) => 'cylinder(h = 2, r = 3);',
      Cylinder.new(h: 1, r: 2, d: 3) => 'cylinder(h = 1, r = 1.500);',
      Cylinder.new(h: 20, d: 15, fn: 20) => 'cylinder(h = 20, r = 7.500, $fn = 20);',
      Cylinder.new(q: 5) => 'cylinder(q = 5);'
    }

    vals.each do |val, exp|
      assert_equal exp, val.to_rubyscad
    end
  end

  def test_cylinder_helper
    vals = {
      cylinder(h: 1) => 'cylinder(h = 1);',
      cylinder(r: 2) => 'cylinder(r = 2);',
      cylinder(d: 3) => 'cylinder(r = 1.500);',
      cylinder(h: 2, r: 3) => 'cylinder(h = 2, r = 3);',
      cylinder(h: 1, r: 2, d: 3) => 'cylinder(h = 1, r = 1.500);',
      cylinder(h: 10, d: 20, fn: 15) => 'cylinder(h = 10, r = 10.000, $fn = 15);',
      cylinder(q: 15) => 'cylinder(q = 15);',

      cylinder(id: 10, h: 10) =>
        "difference(){cylinder(h = 10);\n" \
        "translate(v = [0, 0, -0.010])\n" \
        "cylinder(h = 10.020, r = 5.000);\n"\
        '}',

      cylinder(id: 10, h: 12, ih: 10) =>
          "difference(){cylinder(h = 12);\n" \
          "translate(v = [0, 0, -0.010])\n" \
          "cylinder(h = 10.010, ih = 10, r = 5.000);\n"\
          '}',

      cylinder(id: 10, h: 12, ih: 10, ifn: 20) =>
            "difference(){cylinder(h = 12);\n" \
            "translate(v = [0, 0, -0.010])\n" \
            "cylinder(h = 10.010, ifn = 20, ih = 10, r = 5.000, $fn = 20);\n"\
            '}'
    }

    vals.each do |val, exp|
      assert_equal exp, val.to_rubyscad
    end
  end

  def test_place_on
    c = cylinder(d: 15, h: 10)

    r = cube(10).place onto: c, face: :top, edge: :bottom

    assert_equal 1, r.transformations.count
    assert_equal(-5.0, r.transformations[0].x)
    assert_in_delta(-10.303, r.transformations[0].y)
    assert_equal(5.0, r.transformations[0].z)

    r = cylinder(d: 10, h: 2).place onto: c, face: :front, edge: :left

    assert_equal 1, r.transformations.count
    assert_in_delta(-5.303, r.transformations[0].x)
    assert_in_delta(-5.303, r.transformations[0].y)
    assert_equal(4.0, r.transformations[0].z)
  end
end
