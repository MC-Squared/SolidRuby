translate(v = [0, 0, -10])
difference(){rotate_extrude(convexity = 3, $fn = 0, fa = 12, fs = 2){import(file="example007.dxf",layer="dorn");
}
rotate(a = [0, 0, 0])
render(){intersection(){rotate(a = [90, 0, 0])
translate(v = [0, 0, -50])
linear_extrude(height = 100){import(file="example007.dxf",layer="cutout1");
}
rotate(a = [90, 0, 90])
translate(v = [0, 0, -50])
linear_extrude(height = 100){import(file="example007.dxf",layer="cutout2");
}
}
}
rotate(a = [0, 0, 90])
render(){intersection(){rotate(a = [90, 0, 0])
translate(v = [0, 0, -50])
linear_extrude(height = 100){import(file="example007.dxf",layer="cutout1");
}
rotate(a = [90, 0, 90])
translate(v = [0, 0, -50])
linear_extrude(height = 100){import(file="example007.dxf",layer="cutout2");
}
}
}
}
