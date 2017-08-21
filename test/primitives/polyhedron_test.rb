require 'test_helper'

class PolyhedronTest < Minitest::Test
  def test_polyhedron_construct
    po = Polyhedron.new(faces: [1, 2], points: [3, 4], convexity: 5)

    assert_equal 0, po.transformations.count
    assert_equal [1, 2], po.faces
    assert_equal [3, 4], po.points
    assert_equal 5, po.convexity
  end

  def test_polyhedron_helper
    po = polyhedron(f: [2], p: [4], c: 6)

    assert_equal 0, po.transformations.count
    assert_equal [2], po.faces
    assert_equal [4], po.points
    assert_equal 6, po.convexity
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

    i = Polyhedron.new(p: points, f: faces)
    exp = 'polyhedron(' \
          'faces = [' \
          '[0, 1, 2, 3], ' \
          '[4, 5, 1, 0], ' \
          '[7, 6, 5, 4], ' \
          '[5, 6, 2, 1], ' \
          '[6, 7, 3, 2], ' \
          '[7, 4, 0, 3]' \
          '], '\
          'points = [' \
          '[0, 0, 0], ' \
          '[10, 0, 0], ' \
          '[10, 7, 0], ' \
          '[0, 7, 0], ' \
          '[0, 0, 5], ' \
          '[10, 0, 5], ' \
          '[10, 7, 5], ' \
          '[0, 7, 5]]);'

    assert_equal exp, i.to_rubyscad
  end
end
