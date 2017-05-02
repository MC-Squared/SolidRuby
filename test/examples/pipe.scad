$fn=64;
union(){color("pink"){translate(v = [0, 30])
mirror(v = [0, 1])
intersection(){difference(){rotate_extrude($fn = 128){translate(v = [30, 0])
circle($fn = 6, r = 5.000);
}
rotate_extrude($fn = 128){translate(v = [30, 0])
circle(r = 3.000);
}
}
translate(v = [0, 0, -50])
linear_extrude(height = 100){scale(v = 2)
polygon(points = [[0, 0], [0, 35.000], [30.311, 17.500]]);
}
}
}
translate(v = [25.981, 15.000])
rotate(a = [0, 0, 60])
union(){color("blue"){translate(v = [0, 30])
mirror(v = [0, 1])
intersection(){difference(){rotate_extrude($fn = 128){translate(v = [30, 0])
circle($fn = 6, r = 5.000);
}
rotate_extrude($fn = 128){translate(v = [30, 0])
circle(r = 3.000);
}
}
translate(v = [0, 0, -50])
linear_extrude(height = 100){scale(v = 2)
polygon(points = [[0, 0], [0, 35.000], [32.889, 11.971]]);
}
}
}
translate(v = [28.191, 19.739])
rotate(a = [0, 0, 70])
union(){color("blue"){translate(v = [0, 30])
mirror(v = [0, 1])
intersection(){difference(){rotate_extrude($fn = 128){translate(v = [30, 0])
circle($fn = 6, r = 5.000);
}
rotate_extrude($fn = 128){translate(v = [30, 0])
circle(r = 3.000);
}
}
translate(v = [0, 0, -50])
linear_extrude(height = 100){scale(v = 2)
polygon(points = [[0, 0], [0, 35.000], [35.000, 0.000]]);
}
}
}
translate(v = [30.000, 30.000])
rotate(a = [0, 0, 90])
union(){translate(v = [3, 0])
union(){color("green"){translate(v = [0, 30])
mirror(v = [0, 1])
intersection(){difference(){rotate_extrude($fn = 128){translate(v = [30, 0])
circle($fn = 6, r = 5.000);
}
rotate_extrude($fn = 128){translate(v = [30, 0])
circle(r = 3.000);
}
}
translate(v = [0, 0, -50])
linear_extrude(height = 100){scale(v = 2)
polygon(points = [[0, 0], [0, 35.000], [24.749, 24.749]]);
}
}
}
translate(v = [21.213, 8.787])
rotate(a = [0, 0, 45])
union(){color("blue"){translate(v = [0, -30])
intersection(){difference(){rotate_extrude($fn = 128){translate(v = [30, 0])
circle($fn = 6, r = 5.000);
}
rotate_extrude($fn = 128){translate(v = [30, 0])
circle(r = 3.000);
}
}
translate(v = [0, 0, -50])
linear_extrude(height = 100){scale(v = 2)
polygon(points = [[0, 0], [0, 35.000], [30.311, 17.500]]);
}
}
}
translate(v = [25.981, -15.000])
rotate(a = [0, 0, -60])
union(){translate(v = [30, 0])
union(){color("yellow"){translate(v = [0, 20])
mirror(v = [0, 1])
intersection(){difference(){rotate_extrude($fn = 128){translate(v = [20, 0])
circle($fn = 6, r = 5.000);
}
rotate_extrude($fn = 128){translate(v = [20, 0])
circle(r = 3.000);
}
}
translate(v = [0, 0, -50])
linear_extrude(height = 100){scale(v = 2)
polygon(points = [[0, 0], [0, 25.000], [12.500, 21.651]]);
}
}
}
translate(v = [10.000, 2.679])
rotate(a = [0, 0, 30])
rotate(a = [0, 90, 0])
rotate(a = [0, 0, 30])
difference(){linear_extrude(height = 10){circle($fn = 6, r = 5.000);
}
translate(v = [0, 0, -0.100])
linear_extrude(height = 10.200){circle(r = 3.000);
}
}
}
rotate(a = [0, 90, 0])
rotate(a = [0, 0, 30])
difference(){linear_extrude(height = 30){circle($fn = 6, r = 5.000);
}
translate(v = [0, 0, -0.100])
linear_extrude(height = 30.200){circle(r = 3.000);
}
}
}
}
}
rotate(a = [0, 90, 0])
rotate(a = [0, 0, 30])
difference(){linear_extrude(height = 3){circle($fn = 6, r = 5.000);
}
translate(v = [0, 0, -0.100])
linear_extrude(height = 3.200){circle(r = 3.000);
}
}
}
}
}
}
