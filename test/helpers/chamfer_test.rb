require 'test_helper'

class ChamferTest < Minitest::Test
  def test_chamfer_scad
    vals = {
      chamfer(l: 20, h: 5) => "linear_extrude(height = 20){\npolygon(points = [[0.000, 0.000], [3.536, 0.000], [0.000, 3.536], [0.000, 0.000]]);\n}",
      chamfer(l: 10, h: 2) => "linear_extrude(height = 10){\npolygon(points = [[0.000, 0.000], [1.414, 0.000], [0.000, 1.414], [0.000, 0.000]]);\n}"

    }

    vals.each do |val, exp|
      assert_equal exp, val.to_rubyscad
    end
  end
end
