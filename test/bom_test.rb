require 'test_helper'

class BOMTest < Minitest::Test
  def test_bom_output
    b = BillOfMaterial::BillOfMaterial.new

    b.add('part1')
    b.add('part2', 2)

    exp = "1 x part1\n2 x part2"

    assert_equal exp, b.output
  end
end
