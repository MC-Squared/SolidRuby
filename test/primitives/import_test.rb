require 'test_helper'

class ImportTest < Minitest::Test
  def test_import_construct
    # string filename
    i = Import.new('filename')

    assert_equal 0, i.transformations.count
    assert_equal 'filename', i.filename
    assert_nil i.layer

    # hash params
    i = Import.new(f: 'filename', l: 'layer')

    assert_equal 0, i.transformations.count
    assert_equal 'filename', i.filename
    assert_equal 'layer', i.layer

    #absolute path
    filepath = File.expand_path('filename')
    i = Import.new(f: 'filename', absolue_path: true)
    assert_equal i.filename, filepath
  end

  def test_import_helper
    i = import(f: 'filename', l: 'layer')

    assert_equal 0, i.transformations.count
    assert_equal 'filename', i.filename
    assert_equal 'layer', i.layer
  end

  def test_import_scad
    i = Import.new(file: 'filename', layer: 'lay')
    exp = "import(file=\"filename\",layer=\"lay\");"

    assert_equal exp, i.to_rubyscad
  end
end
