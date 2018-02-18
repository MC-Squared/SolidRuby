require 'test_helper'

class ExtrasTest < Minitest::Test
  def test_knurled_cylinder_scad
    c = knurled_cylinder(d: 5, h: 2)

    exp = "difference(){rotate(a = [0, 0, 15])
difference(){rotate(a = [0, 0, 15])
difference(){rotate(a = [0, 0, 15])
difference(){rotate(a = [0, 0, 15])
difference(){rotate(a = [0, 0, 15])
difference(){rotate(a = [0, 0, 15])
difference(){rotate(a = [0, 0, 15])
difference(){rotate(a = [0, 0, 15])
difference(){rotate(a = [0, 0, 15])
difference(){rotate(a = [0, 0, 15])
difference(){rotate(a = [0, 0, 15])
difference(){rotate(a = [0, 0, 15])
difference(){rotate(a = [0, 0, 15])
difference(){rotate(a = [0, 0, 15])
difference(){rotate(a = [0, 0, 15])
difference(){rotate(a = [0, 0, 15])
difference(){rotate(a = [0, 0, 15])
difference(){rotate(a = [0, 0, 15])
difference(){rotate(a = [0, 0, 15])
difference(){rotate(a = [0, 0, 15])
difference(){rotate(a = [0, 0, 15])
difference(){rotate(a = [0, 0, 15])
difference(){rotate(a = [0, 0, 15])
difference(){cylinder(h = 2, r = 2.500);
translate(v = [0, -2.500])
rotate(a = [0, 45, 0])
cylinder(h = 4, r = 0.450);
translate(v = [0, -2.500])
rotate(a = [0, -45, 0])
cylinder(h = 4, r = 0.450);
}
translate(v = [0, -2.500])
rotate(a = [0, 45, 0])
cylinder(h = 4, r = 0.450);
translate(v = [0, -2.500])
rotate(a = [0, -45, 0])
cylinder(h = 4, r = 0.450);
}
translate(v = [0, -2.500])
rotate(a = [0, 45, 0])
cylinder(h = 4, r = 0.450);
translate(v = [0, -2.500])
rotate(a = [0, -45, 0])
cylinder(h = 4, r = 0.450);
}
translate(v = [0, -2.500])
rotate(a = [0, 45, 0])
cylinder(h = 4, r = 0.450);
translate(v = [0, -2.500])
rotate(a = [0, -45, 0])
cylinder(h = 4, r = 0.450);
}
translate(v = [0, -2.500])
rotate(a = [0, 45, 0])
cylinder(h = 4, r = 0.450);
translate(v = [0, -2.500])
rotate(a = [0, -45, 0])
cylinder(h = 4, r = 0.450);
}
translate(v = [0, -2.500])
rotate(a = [0, 45, 0])
cylinder(h = 4, r = 0.450);
translate(v = [0, -2.500])
rotate(a = [0, -45, 0])
cylinder(h = 4, r = 0.450);
}
translate(v = [0, -2.500])
rotate(a = [0, 45, 0])
cylinder(h = 4, r = 0.450);
translate(v = [0, -2.500])
rotate(a = [0, -45, 0])
cylinder(h = 4, r = 0.450);
}
translate(v = [0, -2.500])
rotate(a = [0, 45, 0])
cylinder(h = 4, r = 0.450);
translate(v = [0, -2.500])
rotate(a = [0, -45, 0])
cylinder(h = 4, r = 0.450);
}
translate(v = [0, -2.500])
rotate(a = [0, 45, 0])
cylinder(h = 4, r = 0.450);
translate(v = [0, -2.500])
rotate(a = [0, -45, 0])
cylinder(h = 4, r = 0.450);
}
translate(v = [0, -2.500])
rotate(a = [0, 45, 0])
cylinder(h = 4, r = 0.450);
translate(v = [0, -2.500])
rotate(a = [0, -45, 0])
cylinder(h = 4, r = 0.450);
}
translate(v = [0, -2.500])
rotate(a = [0, 45, 0])
cylinder(h = 4, r = 0.450);
translate(v = [0, -2.500])
rotate(a = [0, -45, 0])
cylinder(h = 4, r = 0.450);
}
translate(v = [0, -2.500])
rotate(a = [0, 45, 0])
cylinder(h = 4, r = 0.450);
translate(v = [0, -2.500])
rotate(a = [0, -45, 0])
cylinder(h = 4, r = 0.450);
}
translate(v = [0, -2.500])
rotate(a = [0, 45, 0])
cylinder(h = 4, r = 0.450);
translate(v = [0, -2.500])
rotate(a = [0, -45, 0])
cylinder(h = 4, r = 0.450);
}
translate(v = [0, -2.500])
rotate(a = [0, 45, 0])
cylinder(h = 4, r = 0.450);
translate(v = [0, -2.500])
rotate(a = [0, -45, 0])
cylinder(h = 4, r = 0.450);
}
translate(v = [0, -2.500])
rotate(a = [0, 45, 0])
cylinder(h = 4, r = 0.450);
translate(v = [0, -2.500])
rotate(a = [0, -45, 0])
cylinder(h = 4, r = 0.450);
}
translate(v = [0, -2.500])
rotate(a = [0, 45, 0])
cylinder(h = 4, r = 0.450);
translate(v = [0, -2.500])
rotate(a = [0, -45, 0])
cylinder(h = 4, r = 0.450);
}
translate(v = [0, -2.500])
rotate(a = [0, 45, 0])
cylinder(h = 4, r = 0.450);
translate(v = [0, -2.500])
rotate(a = [0, -45, 0])
cylinder(h = 4, r = 0.450);
}
translate(v = [0, -2.500])
rotate(a = [0, 45, 0])
cylinder(h = 4, r = 0.450);
translate(v = [0, -2.500])
rotate(a = [0, -45, 0])
cylinder(h = 4, r = 0.450);
}
translate(v = [0, -2.500])
rotate(a = [0, 45, 0])
cylinder(h = 4, r = 0.450);
translate(v = [0, -2.500])
rotate(a = [0, -45, 0])
cylinder(h = 4, r = 0.450);
}
translate(v = [0, -2.500])
rotate(a = [0, 45, 0])
cylinder(h = 4, r = 0.450);
translate(v = [0, -2.500])
rotate(a = [0, -45, 0])
cylinder(h = 4, r = 0.450);
}
translate(v = [0, -2.500])
rotate(a = [0, 45, 0])
cylinder(h = 4, r = 0.450);
translate(v = [0, -2.500])
rotate(a = [0, -45, 0])
cylinder(h = 4, r = 0.450);
}
translate(v = [0, -2.500])
rotate(a = [0, 45, 0])
cylinder(h = 4, r = 0.450);
translate(v = [0, -2.500])
rotate(a = [0, -45, 0])
cylinder(h = 4, r = 0.450);
}
translate(v = [0, -2.500])
rotate(a = [0, 45, 0])
cylinder(h = 4, r = 0.450);
translate(v = [0, -2.500])
rotate(a = [0, -45, 0])
cylinder(h = 4, r = 0.450);
}
translate(v = [0, -2.500])
rotate(a = [0, 45, 0])
cylinder(h = 4, r = 0.450);
translate(v = [0, -2.500])
rotate(a = [0, -45, 0])
cylinder(h = 4, r = 0.450);
}"

    assert_equal exp, c.to_rubyscad
  end
end
