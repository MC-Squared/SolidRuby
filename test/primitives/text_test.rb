require 'test_helper'

class TextTest < Minitest::Test
  def test_text_construct
    # string
    i = Text.new('text')

    assert_equal 0, i.transformations.count
    assert_equal 'text', i.text

    # hash params
    i = Text.new(text: 'text', size: 16, font: 'Times', valign: 'top', halign: 'center',
      spacing: 1.5, direction: 'ltr', language: 'en', script: 'latin')

    assert_equal 0, i.transformations.count
    assert_equal 'text', i.text
    assert_equal 16, i.size
    assert_equal 'Times', i.font
    assert_equal 'top', i.valign
    assert_equal 'center', i.halign
    assert_equal 1.5, i.spacing
    assert_equal 'ltr', i.direction
    assert_equal 'en', i.language
    assert_equal 'latin', i.script
  end

  def test_text_helper
    i = text(t: 'test text', s: 20, f: 'Arial')

    assert_equal 0, i.transformations.count
    assert_equal 'test text', i.text
    assert_equal 20, i.size
    assert_equal 'Arial', i.font
    assert_nil i.valign
    assert_nil i.halign
    assert_nil i.spacing
    assert_nil i.direction
    assert_nil i.language
    assert_nil i.script
  end

  def test_text_scad
    i = Text.new(text: 'testing text scad', valign: 'top')
    exp = "text(text = \"testing text scad\", valign = \"top\");"

    assert_equal exp, i.to_rubyscad
  end
end
