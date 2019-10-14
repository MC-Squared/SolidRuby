require 'test_helper'
include SolidRuby::Parameters

class ParametersTest < Minitest::Test
  def setup
    SolidRuby::Parameters::Parameters.verbose = false
    SolidRuby::Parameters::Parameters.yml_path = __dir__
  end

  def teardown
    SolidRuby::Parameters::Parameters.verbose = true
    SolidRuby::Parameters::Parameters.clear_overrides
  end

  def test_params_stores_values
    params.x = 1
    params.y = 2
    params.z = 3
    params.blah = 4

    assert_equal 1, params.x
    assert_equal 2, params.y
    assert_equal 3, params.z
    assert_equal 4, params.blah
  end

  def test_params_prevent_overwriting
    # Setting the same value should just be a warning
    params.x = 1
    params.x = 1

    assert_raises RuntimeError do
      params.x = 2
    end
  end

  def test_params_raises_if_missing
    assert_raises RuntimeError do
      params.missing_value
    end
  end

  def test_loads_defaults_from_yml
    SolidRuby::Parameters::Parameters.yml_path = __dir__

    assert_equal 42, params.testvalue
  end

  def test_loads_variant_from_yml
    SolidRuby::Parameters::Parameters.yml_path = __dir__
    SolidRuby::Parameters::Parameters.variant = :extra_large

    assert_equal 42, params.testvalue
    assert_equal 2.0, params.scale
  end

  def test_overrides_yml_settings
    SolidRuby::Parameters::Parameters.add_overrides(testvalue: 52)

    assert_equal 52, params.testvalue
  end
end
