require 'test_helper'

class MirrorTest < Minitest::Test
  def test_mirror_constructor
    m = Mirror.new(x: 1, y: 2, z: 3)

    assert_equal 1, m.x
    assert_equal 2, m.y
    assert_equal 3, m.z

    m = Mirror.new(:x)
    assert_equal 1, m.x
    assert_nil m.y
    assert_nil m.z

    m = Mirror.new(:y)
    assert_nil m.x
    assert_equal 1, m.y
    assert_nil m.z

    m = Mirror.new(:z)
    assert_nil m.x
    assert_nil m.y
    assert_equal 1, m.z

    m = Mirror.new(:x, :y)
    assert_equal 1, m.x
    assert_equal 1, m.y
    assert_nil m.z

    m = Mirror.new(:y, :z)
    assert_nil m.x
    assert_equal 1, m.y
    assert_equal 1, m.z
  end

  def test_object_mirror
    o = SolidRuby::SolidRubyObject.new.mirror(x: 1, y: 2, z: 3)

    assert_equal 1, o.transformations.count
    m = o.transformations.first

    assert_equal 1, m.x
    assert_equal 2, m.y
    assert_equal 3, m.z

    o = SolidRuby::SolidRubyObject.new.mirror(:x, :z)
    m = o.transformations.first
    assert_equal 1, m.x
    assert_nil m.y
    assert_equal 1, m.z
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
end
