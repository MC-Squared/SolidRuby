require 'test_helper'

class RulerTest < Minitest::Test
  def test_ruler_scad
    r = Ruler.new(x: 20, y: 2, height: 2, mm_mark: 5)

    exp = "union(){color(\"Gainsboro\"){cube(size = [20, 2, 2]);
}
color(\"black\"){translate(v = [0, 0])
cube(size = [0.100, 5, 2.100]);
}
color(\"black\"){translate(v = [0, 0])
cube(size = [0.100, 5, 2.100]);
}
color(\"black\"){translate(v = [1, 0])
cube(size = [0.100, 5, 2.100]);
}
color(\"black\"){translate(v = [2, 0])
cube(size = [0.100, 5, 2.100]);
}
color(\"black\"){translate(v = [3, 0])
cube(size = [0.100, 5, 2.100]);
}
color(\"black\"){translate(v = [4, 0])
cube(size = [0.100, 5, 2.100]);
}
color(\"black\"){translate(v = [5, 0])
cube(size = [0.100, 5, 2.100]);
}
color(\"black\"){translate(v = [5, 0])
cube(size = [0.100, 4, 2.100]);
}
color(\"black\"){translate(v = [6, 0])
cube(size = [0.100, 5, 2.100]);
}
color(\"black\"){translate(v = [7, 0])
cube(size = [0.100, 5, 2.100]);
}
color(\"black\"){translate(v = [8, 0])
cube(size = [0.100, 5, 2.100]);
}
color(\"black\"){translate(v = [9, 0])
cube(size = [0.100, 5, 2.100]);
}
color(\"black\"){translate(v = [10, 0])
cube(size = [0.100, 5, 2.100]);
}
color(\"black\"){translate(v = [10, 0])
cube(size = [0.100, 5, 2.100]);
}
color(\"black\"){translate(v = [11, 0])
cube(size = [0.100, 5, 2.100]);
}
color(\"black\"){translate(v = [12, 0])
cube(size = [0.100, 5, 2.100]);
}
color(\"black\"){translate(v = [13, 0])
cube(size = [0.100, 5, 2.100]);
}
color(\"black\"){translate(v = [14, 0])
cube(size = [0.100, 5, 2.100]);
}
color(\"black\"){translate(v = [15, 0])
cube(size = [0.100, 5, 2.100]);
}
color(\"black\"){translate(v = [15, 0])
cube(size = [0.100, 4, 2.100]);
}
color(\"black\"){translate(v = [16, 0])
cube(size = [0.100, 5, 2.100]);
}
color(\"black\"){translate(v = [17, 0])
cube(size = [0.100, 5, 2.100]);
}
color(\"black\"){translate(v = [18, 0])
cube(size = [0.100, 5, 2.100]);
}
color(\"black\"){translate(v = [19, 0])
cube(size = [0.100, 5, 2.100]);
}
color(\"black\"){translate(v = [20, 0])
cube(size = [0.100, 5, 2.100]);
}
color(\"black\"){translate(v = [20, 0])
cube(size = [0.100, 5, 2.100]);
}
}"

    assert_equal exp, r.show.to_rubyscad
  end
end
