require 'test_helper'

class ColorTest < Minitest::Test
  def test_color_construct
    c = cube(10)
    obj = Color.new(c, 'blue')
    att = "\"blue\""

    assert_equal 1, obj.children.count
    assert_equal c, obj.children[0]
    assert_equal 1, obj.attributes.count
    assert_equal att, obj.attributes[0]

    # optional opacity
    obj = Color.new(c, 'xyz', 0.5)
    att = "\"xyz\", 0.5"

    assert_equal 1, obj.children.count
    assert_equal c, obj.children[0]
    assert_equal 1, obj.attributes.count
    assert_equal att, obj.attributes[0]

    # color also takes a argb hash
    obj = Color.new(c, a: 125, r: 50, g: 20, b: 100)
    att = {r: 50 / 255.0, g: 20/255.0, b: 100/255.0}
    alpha = 125 / 255.0

    assert_equal 1, obj.children.count
    assert_equal c, obj.children[0]
    assert_equal 2, obj.attributes.count
    assert_equal att.count, obj.attributes[:c].count
    assert_in_delta att[:r], obj.attributes[:c][0]
    assert_in_delta att[:g], obj.attributes[:c][1]
    assert_in_delta att[:b], obj.attributes[:c][2]
    assert_in_delta alpha, obj.attributes[:alpha]
  end

  def test_color_helper
    c = cube(10)
    obj = c.color('red')
    att = "\"red\""

    assert_equal 1, obj.children.count
    assert_equal c, obj.children[0]
    assert_equal 1, obj.attributes.count
    assert_equal att, obj.attributes[0]

    # with opacity
    obj = c.color('red', 0.25)
    att = ["\"red\", 0.25"]

    assert_equal att, obj.attributes

    # argb hash
    obj = c.color(r: 100, g: 125, b: 50)
    att = {r: 100 / 255.0, g: 125/255.0, b: 50/255.0}
    alpha = 1.0

    assert_in_delta att[:r], obj.attributes[:c][0]
    assert_in_delta att[:g], obj.attributes[:c][1]
    assert_in_delta att[:b], obj.attributes[:c][2]
    assert_in_delta alpha, obj.attributes[:alpha]
  end

  def test_color_scad
    o = SolidRubyObject.new

    assert_equal "color(\"yellow\"){\n}", o.color('yellow').to_rubyscad
    assert_equal "color(\"xyz\", 0.6){\n}", o.color('xyz', 0.6).to_rubyscad
    assert_equal "color(alpha = 0.196, c = [1.000, 0.490, 0.078]){\n}",
      o.color(r: 255, g: 125, b: 20, a: 50).to_rubyscad
  end
end
