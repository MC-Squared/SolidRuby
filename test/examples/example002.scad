intersection(){difference(){union(){translate(v = [-15.000, -15.000, -15.000])
cube(size = [30, 30, 30]);
translate(v = [0, 0, -25])
translate(v = [-7.500, -7.500, -25.000])
cube(size = [15, 15, 50]);
}
union(){translate(v = [-25.000, -5.000, -5.000])
cube(size = [50, 10, 10]);
translate(v = [-5.000, -25.000, -5.000])
cube(size = [10, 50, 10]);
translate(v = [-5.000, -5.000, -25.000])
cube(size = [10, 10, 50]);
}
}
translate(v = [0, 0, 5])
cylinder(r1 = 20, r2 = 5, h = 50, center = true);
}
