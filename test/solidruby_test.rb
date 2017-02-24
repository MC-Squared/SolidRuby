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
      Rotate.new(q: 3) => 'rotate(q = 3, a = [0, 0])'
    }

    vals.each do |val, exp|
      assert_equal exp, val.to_rubyscad
    end
  end

  def test_translate_scad
    vals = {
      Translate.new(x: 1) => 'translate(v = [1, 0])',
      Translate.new(y: 2) => 'translate(v = [0, 2])',
      Translate.new(z: 3) => 'translate(v = [0, 0, 3])',
      Translate.new(x: 2, z: 3) => 'translate(v = [2, 0, 3])',
      Translate.new(x: 1, y: 2, z: 3) => 'translate(v = [1, 2, 3])',
      Translate.new(q: 3) => 'translate(q = 3, v = [0, 0])'
    }

    vals.each do |val, exp|
      assert_equal exp, val.to_rubyscad
    end
  end

  def test_mirror_scad
    vals = {
      Mirror.new(x: 1) => 'mirror(v = [1, 0])',
      Mirror.new(y: 2) => 'mirror(v = [0, 2])',
      Mirror.new(z: 3) => 'mirror(v = [0, 0, 3])',
      Mirror.new(x: 2, z: 3) => 'mirror(v = [2, 0, 3])',
      Mirror.new(x: 1, y: 2, z: 3) => 'mirror(v = [1, 2, 3])',
      Mirror.new(q: 3) => 'mirror(q = 3, v = [0, 0])'
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

class PrimitiveTest < Minitest::Test
  def test_cylinder_scad
    vals = {
      Cylinder.new(h: 1) => 'cylinder(h = 1);',
      Cylinder.new(r: 2) => 'cylinder(r = 2);',
      Cylinder.new(d: 3) => 'cylinder(r = 1.500);',
      Cylinder.new(h: 2, r: 3) => 'cylinder(h = 2, r = 3);',
      Cylinder.new(h: 1, r: 2, d: 3) => 'cylinder(h = 1, r = 1.500);',
      Cylinder.new(h: 20, d: 15, fn: 20) => 'cylinder(h = 20, $fn = 20, r = 7.500);',
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
      cylinder(h: 10, d: 20, fn: 15) => 'cylinder(h = 10, $fn = 15, r = 10.000);',
      cylinder(q: 15) => 'cylinder(q = 15);',

      cylinder(id: 10, h: 10) =>
        "difference(){cylinder(h = 10);\n" \
        "translate(v = [0, 0, -0.01])\n" \
        "cylinder(h = 10.020, r = 5.000);\n"\
        '}',

      cylinder(id: 10, h: 12, ih: 10) =>
          "difference(){cylinder(h = 12);\n" \
          "translate(v = [0, 0, -0.01])\n" \
          "cylinder(h = 10.010, ih = 10, r = 5.000);\n"\
          '}',

      cylinder(id: 10, h: 12, ih: 10, ifn: 20) =>
            "difference(){cylinder(h = 12);\n" \
            "translate(v = [0, 0, -0.01])\n" \
            "cylinder(h = 10.010, ih = 10, ifn = 20, $fn = 20, r = 5.000);\n"\
            '}'
    }

    vals.each do |val, exp|
      assert_equal exp, val.to_rubyscad
    end
  end

  def test_cube_scad
    vals = {
      Cube.new(size: [1]) => 'cube(size = [1]);',
      Cube.new(size: [1, 2]) => 'cube(size = [1, 2]);',
      Cube.new(size: [1, 2, 3]) => 'cube(size = [1, 2, 3]);',
      Cube.new(q: 5, size: [1, 2]) => 'cube(q = 5, size = [1, 2]);',
      Cube.new(size: [10, 10, 10], center: true) => 'cube(size = [10, 10, 10], center = true);'
    }

    vals.each do |val, exp|
      assert_equal exp, val.to_rubyscad
    end
  end

  def test_cube_center
    args = { size: [1, 2, 3] }

    vals = {
      Cube.new(args).center_xy => { x: -0.5, y: -1.0 },
      Cube.new(args).center_x => { x: -0.5 },
      Cube.new(args).center_y => { y: -1.0 },
      Cube.new(args).center_z => { z: -1.5 },
      Cube.new(args).center => { x: -0.5, y: -1.0, z: -1.5 }
    }

    vals.each do |val, exp|
      assert_equal 1, val.transformations.count
      assert_equal exp, val.transformations.first.args
    end
  end

  def test_cube_helper
    vals = {
      cube(10) => 'cube(size = [10, nil, nil]);',
      cube(10, 20) => 'cube(size = [10, 20, nil]);',
      cube(10, 20, 30) => 'cube(size = [10, 20, 30]);',
      cube([1, 2, 3]) => 'cube(size = [1, 2, 3]);',
      cube(x: 5, y: 10, z: 15) => 'cube(size = [5, 10, 15]);'
    }

    vals.each do |val, exp|
      assert_equal exp, val.to_rubyscad
    end
  end

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
      sphere(r: 10) => 'sphere(r = 10);',
      sphere(d: 15) => 'sphere(r = 7.500);',
      sphere(q: 5, r: 10) => 'sphere(q = 5, r = 10);',
      sphere(q: 5, r: 10, center: true) => 'sphere(q = 5, r = 10, center = true);'
    }

    vals.each do |val, exp|
      assert_equal exp, val.to_rubyscad
    end
  end

  def test_polyhedron_scad
    # From OpenSCAD docs
    points = [
      [0,  0, 0], # 0
      [10,  0,  0],  # 1
      [10,  7,  0],  # 2
      [0,  7,  0],  # 3
      [0,  0,  5],  # 4
      [10,  0,  5],  # 5
      [10,  7,  5],  # 6
      [0, 7, 5], # 7
    ]

    faces = [
      [0, 1, 2, 3],  # bottom
      [4, 5, 1, 0],  # front
      [7, 6, 5, 4],  # top
      [5, 6, 2, 1],  # right
      [6, 7, 3, 2],  # back
      [7, 4, 0, 3],  # left
    ]

    p = Polyhedron.new(points: points, triangles: faces)

    scad = 'polyhedron(points = [' \
           '[0, 0, 0], ' \
           '[10, 0, 0], ' \
           '[10, 7, 0], ' \
           '[0, 7, 0], ' \
           '[0, 0, 5], ' \
           '[10, 0, 5], ' \
           '[10, 7, 5], ' \
           '[0, 7, 5]], ' \
           'triangles = [' \
           '[0, 1, 2, 3], ' \
           '[4, 5, 1, 0], ' \
           '[7, 6, 5, 4], ' \
           '[5, 6, 2, 1], ' \
           '[6, 7, 3, 2], ' \
           '[7, 4, 0, 3]' \
           ']);'

    assert_equal scad, p.to_rubyscad

    helper = polyhedron(points: points, triangles: faces)
    assert_equal scad, helper.to_rubyscad
  end
end

class Primitive2DTest < Minitest::Test
  def test_square_scad
    vals = {
      Square.new(size: 10) => 'square(size = 10);',
      Square.new(size: [1]) => 'square(size = [1]);',
      Square.new(size: [1, 2]) => 'square(size = [1, 2]);',
      Square.new(q: 5, size: [1, 2]) => 'square(q = 5, size = [1, 2]);',
      Square.new(size: [10, 10, 10], center: true) => 'square(size = [10, 10, 10], center = true);'
    }

    vals.each do |val, exp|
      assert_equal exp, val.to_rubyscad
    end
  end

  def test_square_center
    args = { size: [1, 2] }

    vals = {
      Square.new(args).center_xy => { x: -0.5, y: -1.0 },
      Square.new(args).center_x => { x: -0.5 },
      Square.new(args).center_y => { y: -1.0 },
      Square.new(args).center => { x: -0.5, y: -1.0 }
    }

    vals.each do |val, exp|
      assert_equal 1, val.transformations.count
      assert_equal exp, val.transformations.first.args
    end
  end

  def test_square_helper
    vals = {
      square(10) => 'square(size = [10, nil]);',
      square(10, 20) => 'square(size = [10, 20]);',
      square([1, 2, 3]) => 'square(size = [1, 2, 3]);',
      square(x: 5, y: 10, z: 15) => 'square(size = [5, 10]);'
    }

    vals.each do |val, exp|
      assert_equal exp, val.to_rubyscad
    end
  end

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

class AdvancedPrimitiveTest < Minitest::Test
  def test_text_scad
    t = Text.new(text: 'testing')
    exp = 'text(text = "testing");'

    assert_equal exp, t.to_rubyscad

    t = text(text: 'testing')
    assert_equal exp, t.to_rubyscad
  end
end

class CSGModellingTest < Minitest::Test
  def test_union_scad
    c1 = cube(10,10,10)
    c2 = cube(20,20,20)

    u = Union.new(c1, c2)
    exp = "union(){cube(size = [10, 10, 10]);\n" \
          "cube(size = [20, 20, 20]);\n" \
          '}'

    assert_equal exp, u.to_rubyscad
  end

  def test_difference_scad
    c1 = cube(10,10,10)
    c2 = cube(20,20,20)

    u = Difference.new(c1, c2)
    exp = "difference(){cube(size = [10, 10, 10]);\n" \
          "cube(size = [20, 20, 20]);\n" \
          '}'

    assert_equal exp, u.to_rubyscad
  end

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

  def test_optimize_union
    #two cases,
    #case: top is a union,
    #     child is not a union
    #     top has no transformations
    # child becomes top's child
    # case 2:
    #     anything else
    #     create new union of (top, child)


    c1 = cube(10,10,10)
    c2 = cube(20,20,20)
    top_u = Union.new(c1, c2)

    c3 = cube(30,30,30)
    c4 = cube(40,40,40)
    child_u = Union.new(c3, c4)

    res_2u = optimize_union(top_u, child_u)
    exp_2u = "union(){union(){cube(size = [10, 10, 10]);\n" \
          "cube(size = [20, 20, 20]);\n" \
          "}\n" \
          "union(){cube(size = [30, 30, 30]);\n" \
          "cube(size = [40, 40, 40]);\n" \
          "}\n" \
          "}"

    assert_equal exp_2u, res_2u.to_rubyscad

    res_1u = optimize_union(top_u, c3)
    exp_1u = "union(){cube(size = [10, 10, 10]);\n" \
              "cube(size = [20, 20, 20]);\n" \
              "cube(size = [30, 30, 30]);\n" \
              "}"

    assert_equal exp_1u, res_1u.to_rubyscad
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
    #case 1: nil + obj = Union(nil, obj)
    cube = cube(10, 10, 10)
    res = nil + cube
    exp = "union(){cube(size = [10, 10, 10]);\n}"

    assert_equal exp, res.to_rubyscad

    #case 2: obj + array = Union(obj, array.last)
    cube1 = cube(20, 20, 20)
    cube2 = cube(30, 30, 30)
    res = cube + [cube1, cube2]
    exp = "union(){union(){cube(size = [10, 10, 10]);\n" \
            "cube(size = [20, 20, 20]);\n" \
            "}\n" \
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

class ImportTest < Minitest::Test
  def test_import_scad
    filepath = File.expand_path('filename')
    #case 1: filename is a string
    i = Import.new('filename')
    exp = "import(file=\"#{filepath}\");"

    assert_equal exp, i.to_rubyscad

    #case 2: args is a hash
    i = Import.new(file: 'filename', layer: 2)
    exp = "import(file=\"#{filepath}\",layer=\"2\");"

    assert_equal exp, i.to_rubyscad

    #helper
    i = import('filename')
    exp = "import(file=\"#{filepath}\");"

    assert_equal exp, i.to_rubyscad
  end
end

class RenderTest < Minitest::Test
  def test_render_scad
    #TODO: I don't think render() works correctly,
    cube = cube(10, 10, 10)
    r = Render.new(cube, {layer: 1})
    exp = "cube(size = [10, 10, 10]);\nrender()"

    assert_equal exp, r.to_rubyscad

    r = cube.render(layer: 1)
    assert_equal exp, r.to_rubyscad
  end
end

class ColorTest < Minitest::Test
  def test_color_scad
    cube = cube(10, 10, 10)
    c = Color.new(cube, 'red')
    exp = "color(\"red\"){cube(size = [10, 10, 10]);\n}"

    assert_equal exp, c.to_rubyscad

    #Currently broken - SolidRuby.to_rubyscad expects attributes to be a string
    #c = Color.new(cube, r: 1, g: 2, b: 3)

    #exp = 'color([0.00392156862745098, 0.00784313725490196, ' \
    #      "0.011764705882352941, 1.0]){cube(size = [10, 10, 10]);\n" \
    #      '}'

    #assert_equal exp, c.to_rubyscad

    #c = cube.color(r: 1, b: 3, g: 2, a: 255)
    #assert_equal exp, c.to_rubyscad
  end
end

class LinearExtrudeTest < Minitest::Test
  def test_linear_extrude_scad
    cube = cube(10, 10, 10)
    l = LinearExtrude.new(cube, 'height = 10')
    exp = "linear_extrude(height = 10){cube(size = [10, 10, 10]);\n}"

    assert_equal exp, l.to_rubyscad

    l = cube.linear_extrude(h: 10)
    exp = "linear_extrude(height = 10){cube(size = [10, 10, 10]);\n}"
    assert_equal exp, l.to_rubyscad
  end
end

class RotateExtrudeTest < Minitest::Test
  def test_rotate_extrude_scad
    cube = cube(10, 10, 10)
    r = RotateExtrude.new(cube, 'height = 10')
    exp = "rotate_extrude(height = 10){cube(size = [10, 10, 10]);\n}"

    assert_equal exp, r.to_rubyscad

    r = cube.rotate_extrude(h: 10)
    exp = "rotate_extrude(height = 10){cube(size = [10, 10, 10]);\n}"
    assert_equal exp, r.to_rubyscad
  end
end

class ProjectionTest < Minitest::Test
  def test_projection_scad
    cube = cube(10, 10, 10)
    p = Projection.new(cube, 'height = 10, $fn = 20')
    exp = "projection(height = 10, $fn = 20){cube(size = [10, 10, 10]);\n}"

    assert_equal exp, p.to_rubyscad

    p = cube.projection(h: 10)
    exp = "projection(h = 10){cube(size = [10, 10, 10]);\n}"
    assert_equal exp, p.to_rubyscad
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
            "union(){translate(v = [0, 0, 0])\n" \
            "color(\"Gainsboro\"){cylinder(h = 3.200, $fn = 6, r = 4.215);\n" \
            "}\n" \
            "translate(v = [0, 0, 8.2])\n" \
            "color(\"Gainsboro\"){cylinder(h = 3.200, $fn = 6, r = 4.215);\n" \
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
    exp = "hull(){cylinder(r = 5.000, h = 20);\n" \
          "translate(v = [nil, 0])\n" \
          "cylinder(r = 5.000, h = 20);\n" \
          "}"

    assert_equal exp, ls.to_rubyscad
  end

  #save!, save_all, and get_classes_from_file are designed to be called
  #in a generated project, not here
end
