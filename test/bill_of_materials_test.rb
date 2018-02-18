require 'test_helper'

class BOMTest < Minitest::Test
  def test_bom_output
    b = BillOfMaterial::BillOfMaterial.new

    b.add('part1')
    b.add('part2', 2)

    exp = "1 x part1\n2 x part2"

    assert_equal exp, b.output
  end

  def test_bom_save
    b = BillOfMaterial::BillOfMaterial.new

    b.add('part1')
    b.add('part2', 2)

    exp = "1 x part1\n2 x part2"

    file_mock = Minitest::Mock.new
    file_mock.expect(:puts, nil, [exp])
    file_mock.expect(:close, nil)
    File.stub(:open, file_mock) do
      b.save
    end
    file_mock.verify
  end
end
