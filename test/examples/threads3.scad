union(){difference(){translate(v = [-25.000, -25.000])
cube(size = [50, 50, 10]);
color("Gainsboro"){cylinder(h = 3.200, r = 4.215, $fn = 6);
}
translate(v = [10, 0, 7])
color("Gainsboro"){cylinder(h = 3.200, r = 4.215, $fn = 6);
}
translate(v = [-20, 5, 5])
rotate(a = [0, 90, 0])
hull(){color("Gainsboro"){cylinder(h = 3.700, r = 4.215, $fn = 6);
}
translate(v = [-15, 0])
color("Gainsboro"){cylinder(h = 3.700, r = 4.388, $fn = 6);
}
}
translate(v = [20, -8, 5])
rotate(a = [0, -90, 0])
hull(){color("Gainsboro"){cylinder(h = 3.700, r = 4.215, $fn = 6);
}
translate(v = [15, 0])
color("Gainsboro"){cylinder(h = 3.700, r = 4.388, $fn = 6);
}
}
translate(v = [2, -20, 5])
rotate(a = [-90, 0, 0])
hull(){color("Gainsboro"){cylinder(h = 3.700, r = 4.215, $fn = 6);
}
translate(v = [0, -15])
color("Gainsboro"){cylinder(h = 3.700, r = 4.388, $fn = 6);
}
}
translate(v = [-10, 20, 5])
rotate(a = [90, 0, 0])
hull(){color("Gainsboro"){cylinder(h = 3.700, r = 4.215, $fn = 6);
}
translate(v = [0, 15])
color("Gainsboro"){cylinder(h = 3.700, r = 4.388, $fn = 6);
}
}
}
translate(v = [0, 0, -16.800])
union(){color("Gainsboro"){translate(v = [0, 0, -4])
cylinder(h = 4, r = 3.500);
}
color("DarkGray"){cylinder(h = 20, r = 2.150);
}
}
translate(v = [10, 0, 7])
translate(v = [0, 0, 20])
rotate(a = [180, 0])
union(){color("Gainsboro"){translate(v = [0, 0, -4])
cylinder(h = 4, r = 3.500);
}
color("DarkGray"){cylinder(h = 20, r = 2.150);
}
}
translate(v = [-20, 5, 5])
rotate(a = [0, 90, 0])
translate(v = [0, 0, -16.800])
union(){color("Gainsboro"){translate(v = [0, 0, -4])
cylinder(h = 4, r = 3.500);
}
color("DarkGray"){cylinder(h = 20, r = 2.150);
}
}
translate(v = [20, -8, 5])
rotate(a = [0, -90, 0])
translate(v = [0, 0, -16.800])
union(){color("Gainsboro"){translate(v = [0, 0, -4])
cylinder(h = 4, r = 3.500);
}
color("DarkGray"){cylinder(h = 20, r = 2.150);
}
}
translate(v = [2, -20, 5])
rotate(a = [-90, 0, 0])
translate(v = [0, 0, -16.800])
union(){color("Gainsboro"){translate(v = [0, 0, -4])
cylinder(h = 4, r = 3.500);
}
color("DarkGray"){cylinder(h = 20, r = 2.150);
}
}
translate(v = [-10, 20, 5])
rotate(a = [90, 0, 0])
translate(v = [0, 0, -16.800])
union(){color("Gainsboro"){translate(v = [0, 0, -4])
cylinder(h = 4, r = 3.500);
}
color("DarkGray"){cylinder(h = 20, r = 2.150);
}
}
}
