require 'test_helper'

class SurfaceTest < Minitest::Test
  def test_surface_construct
    # string filename
    i = Surface.new('filename')

    assert_equal 0, i.transformations.count
    assert_equal 'filename', i.file
    assert_nil i.center
    assert_nil i.convexity
    assert_nil i.invert

    # hash params
    i = Surface.new(f: 'filename', center: true, i: false, co: 5)

    assert_equal 0, i.transformations.count
    assert_equal 'filename', i.file
    assert i.center
    refute i.invert
    assert_equal 5, i.convexity

    #absolute path
    filepath = File.expand_path('filename')
    i = Surface.new(f: 'filename', absolue_path: true)
    assert_equal filepath, i.file
  end

  def test_surface_helper
    i = surface(f: 'filename', i: true)

    assert_equal 0, i.transformations.count
    assert_equal 'filename', i.file
    assert_nil i.center
    assert i.invert
    assert_nil i.convexity
  end

  def test_surface_scad
    i = Surface.new(file: 'filename', center: true)
    exp = "surface(file = \"filename\", center = true);"

    assert_equal exp, i.to_rubyscad
  end
end
