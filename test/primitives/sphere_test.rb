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
end
