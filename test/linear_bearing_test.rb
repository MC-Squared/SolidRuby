require 'test_helper'

class LinearBearingTest < Minitest::Test
  def test_lm_uu_scad
    l = Lm_uu.new(inner_diameter: 8)

    exp = "union(){color(\"LightGrey\"){
difference(){cylinder(h = 24, r = 7.500);
translate(v = [0, 0, -0.100])
cylinder(h = 24.200, r = 6.400);
}
}
color(\"DimGray\"){
difference(){cylinder(h = 24, r = 6.400);
translate(v = [0, 0, -0.100])
cylinder(h = 24.200, r = 4.000);
}
}
}"
    assert_equal exp, l.output.to_rubyscad
  end

  def test_lm_luu_scad
    l = Lm_luu.new(inner_diameter: 12)

    exp = "union(){color(\"LightGrey\"){
difference(){cylinder(h = 57, r = 10.500);
translate(v = [0, 0, -0.100])
cylinder(h = 57.200, r = 9.400);
}
}
color(\"DimGray\"){
difference(){cylinder(h = 57, r = 9.400);
translate(v = [0, 0, -0.100])
cylinder(h = 57.200, r = 6.000);
}
}
}"

    assert_equal exp, l.output.to_rubyscad
  end
end
