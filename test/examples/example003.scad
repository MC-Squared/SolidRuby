difference(){union(){translate(v = [-15.0, -15.0, -15.0])
cube(size = [30, 30, 30]);
translate(v = [-20.0, -7.5, -7.5])
cube(size = [40, 15, 15]);
translate(v = [-7.5, -20.0, -7.5])
cube(size = [15, 40, 15]);
translate(v = [-7.5, -7.5, -20.0])
cube(size = [15, 15, 40]);
}
union(){translate(v = [-25.0, -5.0, -5.0])
cube(size = [50, 10, 10]);
translate(v = [-5.0, -25.0, -5.0])
cube(size = [10, 50, 10]);
translate(v = [-5.0, -5.0, -25.0])
cube(size = [10, 10, 50]);
}
}
