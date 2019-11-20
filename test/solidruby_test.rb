require 'test_helper'

include SolidRuby

class TransformationTest < Minitest::Test
  def test_rotation_scad
    vals = {
      Rotate.new(x: 1) => 'rotate(a = [1, 0])',
      Rotate.new(y: 2) => 'rotate(a = [0, 2])',
      Rotate.new(z: 3) => 'rotate(a = [0, 0, 3])',
      Rotate.new(x: 2, z: 3) => 'rotate(a = [2, 0, 3])',
      Rotate.new(x: 1, y: 2, z: 3) => 'rotate(a = [1, 2, 3])',
      Rotate.new(q: 3) => 'rotate(a = [0, 0], q = 3)'
    }

    vals.each do |val, exp|
      assert_equal exp, val.to_rubyscad
    end
  end

  def test_scale_scad
    vals = {
      Scale.new(x: 1) => 'scale(v = [1, 0])',
      Scale.new(y: 2) => 'scale(v = [0, 2])',
      Scale.new(z: 3) => 'scale(v = [0, 0, 3])',
      Scale.new(x: 2, z: 3) => 'scale(v = [2, 0, 3])',
      Scale.new(x: 1, y: 2, z: 3) => 'scale(v = [1, 2, 3])',
      Scale.new(q: 3) => 'scale(q = 3, v = [0, 0])'
    }

    vals.each do |val, exp|
      assert_equal exp, val.to_rubyscad
    end
  end
end

class Primitive2DTest < Minitest::Test
  def test_circle_scad
    vals = {
      Circle.new(d: 10) => 'circle(r = 5.000);',
      Circle.new(r: 10) => 'circle(r = 10);',
      Circle.new(x: 5) => 'circle(x = 5);'
    }

    vals.each do |val, exp|
      assert_equal exp, val.to_rubyscad
    end
  end

  def test_circle_helper
    vals = {
      circle(d: 10) => 'circle(r = 5.000);',
      circle(r: 10) => 'circle(r = 10);',
      circle(x: 5) => 'circle(x = 5);'
    }

    vals.each do |val, exp|
      assert_equal exp, val.to_rubyscad
    end
  end

  def test_polygon_scad
    p = { points: [[0, 10], [10, 10], [10, 0]] }

    poly = Polygon.new(p)
    exp = 'polygon(points = [[0, 10], [10, 10], [10, 0]]);'

    assert_equal exp, poly.to_rubyscad

    poly = polygon(p)
    assert_equal exp, poly.to_rubyscad
  end
end

class RubyScadTest < Minitest::Test
  def test_outputs
    assert_equal 'test', RubyScadBridge.new.raw_output('test')
    assert_equal 'test', RubyScadBridge.new.format_output('test')
    assert_equal 'test', RubyScadBridge.new.format_block('test')
  end
end

class CSGModellingTest < Minitest::Test


  def test_intersection_scad
    c1 = cube(10,10,10)
    c2 = cube(20,20,20)

    u = Intersection.new(c1, c2)
    exp = "intersection(){cube(size = [10, 10, 10]);\n" \
          "cube(size = [20, 20, 20]);\n" \
          '}'

    assert_equal exp, u.to_rubyscad
  end

  def test_hull_scad
    c1 = cube(10,10,10)
    c2 = cube(20,20,20)

    h = Hull.new(c1, c2)
    exp = "hull(){cube(size = [10, 10, 10]);\n" \
          "cube(size = [20, 20, 20]);\n" \
          '}'

    assert_equal exp, h.to_rubyscad

    h = hull(c1, c2)
    assert_equal exp, h.to_rubyscad
  end

  def test_optimize_difference
    #two cases,
    #case: top is a difference,
    #     child is not a difference
    # child becomes top's child
    # case 2:
    #     anything else
    #     create new union of (top, child)


    c1 = cube(10,10,10)
    c2 = cube(20,20,20)
    top_d = Difference.new(c1, c2)

    c3 = cube(30,30,30)
    c4 = cube(40,40,40)
    child_d = Difference.new(c3, c4)

    res_2d = optimize_difference(top_d, child_d)
    exp_2d = "difference(){difference(){cube(size = [10, 10, 10]);\n" \
          "cube(size = [20, 20, 20]);\n" \
          "}\n" \
          "difference(){cube(size = [30, 30, 30]);\n" \
          "cube(size = [40, 40, 40]);\n" \
          "}\n" \
          "}"

    assert_equal exp_2d, res_2d.to_rubyscad

    res_1d = optimize_difference(top_d, c3)
    exp_1d = "difference(){cube(size = [10, 10, 10]);\n" \
              "cube(size = [20, 20, 20]);\n" \
              "cube(size = [30, 30, 30]);\n" \
              "}"

    assert_equal exp_1d, res_1d.to_rubyscad
  end

  def test_plus_scad
    #case 1: nil + obj = obj
    cube = cube(10, 10, 10)
    res = nil + cube
    exp = "cube(size = [10, 10, 10]);"

    assert_equal exp, res.to_rubyscad

    #case 2: obj + array = Union(obj, array.last)
    cube1 = cube(20, 20, 20)
    cube2 = cube(30, 30, 30)
    res = cube + [cube1, cube2]
    exp = "union(){cube(size = [10, 10, 10]);\n" \
            "cube(size = [20, 20, 20]);\n" \
            "cube(size = [30, 30, 30]);\n" \
            "}"

    assert_equal exp, res.to_rubyscad

    #case 3: obj + obj = optimize_union(obj, obj)
    res = cube + cube1
    exp = "union(){cube(size = [10, 10, 10]);\n" \
          "cube(size = [20, 20, 20]);\n" \
          "}"

    assert_equal exp, res.to_rubyscad
  end

  def test_minus_scad
    #case 1: nil - obj = obj
    cube = cube(10, 10, 10)
    res = nil - cube
    exp = "cube(size = [10, 10, 10]);"

    assert_equal exp, res.to_rubyscad

    #case 2: obj - array = difference(obj, array.last)
    cube1 = cube(20, 20, 20)
    cube2 = cube(30, 30, 30)
    res = cube - [cube1, cube2]
    exp = "difference(){difference(){cube(size = [10, 10, 10]);\n" \
            "cube(size = [20, 20, 20]);\n" \
            "}\n" \
            "cube(size = [30, 30, 30]);\n" \
            "}"

    assert_equal exp, res.to_rubyscad

    #case 3: obj + obj = optimize_idfference(obj, obj)
    res = cube - cube1
    exp = "difference(){cube(size = [10, 10, 10]);\n" \
          "cube(size = [20, 20, 20]);\n" \
          "}"

    assert_equal exp, res.to_rubyscad
  end

  def test_star_scad
    #case 1: nil * obj = obj
    cube = cube(10, 10, 10)
    res = nil * cube
    exp = "cube(size = [10, 10, 10]);"

    assert_equal exp, res.to_rubyscad

    #case 2: obj * obj = intersection(obj, obj)
    cube1 = cube(20, 20, 20)
    res = cube * cube1
    exp = "intersection(){cube(size = [10, 10, 10]);\n" \
          "cube(size = [20, 20, 20]);\n" \
          "}"

    assert_equal exp, res.to_rubyscad
  end
end

class SolidRubyTest < Minitest::Test
  def test_radians
    vals = {
      90 => 1.571,
      135 => 2.356,
      -30 => -0.524
    }

    vals.each do |val, exp|
      assert_equal exp, radians(val).round(3)
    end
  end

  def test_deg
    vals = {
      90 => 1.571,
      135 => 2.356,
      -30 => -0.524
    }

    vals.each do |exp, val|
      assert_equal exp, degrees(val).round(0)
    end
  end

  def test_stack
    parts = [
      Washer.new(4.3),
      Nut.new(4),
      Washer.new(4.3),
      Nut.new(4)
    ]

    bolt = Bolt.new(4, 16).show
    bolt_assembly = bolt
    bolt_assembly += stack({ method: 'output', spacing: 5 }, *parts)

    exp = "union(){union(){color(\"Gainsboro\"){translate(v = [0, 0, -4])\n" \
            "cylinder(h = 4, r = 3.500);\n" \
            "}\n" \
            "color(\"DarkGray\"){cylinder(h = 16, r = 2.000);\n" \
            "}\n" \
            "}\n" \
            "union(){color(\"Gainsboro\"){cylinder(h = 3.200, r = 4.215, $fn = 6);\n" \
            "}\n" \
            "translate(v = [0, 0, 8.200])\n" \
            "color(\"Gainsboro\"){cylinder(h = 3.200, r = 4.215, $fn = 6);\n" \
            "}\n" \
            "}\n" \
            "}"

    assert_equal exp, bolt_assembly.to_rubyscad
  end

  def test_get_position_rec
    exp = [0, 0, 0]
    assert_equal exp, get_position_rec(nil)

    c = cube(10, 10, 10).translate(z: 20).rotate(y: 90)
    exp = [0, 0, 20]
    assert_equal exp, get_position_rec([c])

    res = c + cube(20, 20, 20)
    res = position(res)

    assert_equal exp, res
  end

  def test_long_slot
    ls = long_slot(d: 10, h: 20)
    exp = "hull(){cylinder(h = 20, r = 5.000);\n" \
          "cylinder(h = 20, r = 5.000);\n" \
          "}"

    assert_equal exp, ls.to_rubyscad
  end

  #save!, save_all, and get_classes_from_file are designed to be called
  #in a generated project, not here
end
