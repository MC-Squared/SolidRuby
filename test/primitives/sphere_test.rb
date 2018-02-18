require 'test_helper'

class SphereTest < Minitest::Test
  def test_sphere_scad
    vals = {
      Sphere.new(r: 10) => 'sphere(r = 10);',
      Sphere.new(d: 15) => 'sphere(r = 7.500);',
      Sphere.new(q: 5, r: 10) => 'sphere(q = 5, r = 10);',
      Sphere.new(q: 5, r: 10, center: true) => 'sphere(q = 5, r = 10, center = true);'
    }

    vals.each do |val, exp|
      assert_equal exp, val.to_rubyscad
    end
  end

  def test_sphere_helper
    vals = {
      sphere(12) => 'sphere(r = 12);',
      sphere(r: 10) => 'sphere(r = 10);',
      sphere(d: 15) => 'sphere(r = 7.500);',
      sphere(q: 5, r: 10) => 'sphere(q = 5, r = 10);',
      sphere(q: 5, r: 10, center: true) => 'sphere(q = 5, r = 10, center = true);'
    }

    vals.each do |val, exp|
      assert_equal exp, val.to_rubyscad
    end
  end

  def test_place_on
    s = sphere(d: 15, h: 10)

    r = cube(10).place onto: s, face: :top, edge: :bottom

    assert_equal 1, r.transformations.count
    assert_equal(-5.0, r.transformations[0].x)
    assert_in_delta(-10.303, r.transformations[0].y)
    assert_in_delta(0.303, r.transformations[0].z)

    r = cylinder(d: 10, h: 2).place onto: s, face: :front, edge: :left

    assert_equal 1, r.transformations.count
    assert_in_delta(-5.303, r.transformations[0].x)
    assert_in_delta(-5.303, r.transformations[0].y)
    assert_equal(-1.0, r.transformations[0].z)
  end
end
