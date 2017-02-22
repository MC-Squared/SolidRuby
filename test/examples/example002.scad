intersection(){difference(){union(){translate(v = [-15.0, -15.0, -15.0])
cube(size = [30, 30, 30]);
translate(v = [0, 0, -25])
translate(v = [-7.5, -7.5, -25.0])
cube(size = [15, 15, 50]);
}
union(){translate(v = [-25.0, -5.0, -5.0])
cube(size = [50, 10, 10]);
translate(v = [-5.0, -25.0, -5.0])
cube(size = [10, 50, 10]);
translate(v = [-5.0, -5.0, -25.0])
cube(size = [10, 10, 50]);
}
}
translate(v = [0, 0, 5])
cylinder(r1 = 20, r2 = 5, h = 50, center = true);
}
