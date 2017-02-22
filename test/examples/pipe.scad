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
polygon(points = [[0, 0], [0, 35.0], [30.31088913245535, 17.500000000000004]]);
}
}
}
translate(v = [25.980762113533157, 14.999999999999996])
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
polygon(points = [[0, 0], [0, 35.0], [32.88924172750679, 11.970705016398409]]);
}
}
}
translate(v = [28.19077862357725, 19.739395700229935])
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
polygon(points = [[0, 0], [0, 35.0], [35.0, 2.1431318985078682e-15]]);
}
}
}
translate(v = [30.0, 29.999999999999996])
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
polygon(points = [[0, 0], [0, 35.0], [24.74873734152916, 24.748737341529164]]);
}
}
}
translate(v = [21.213203435596423, 8.786796564403573])
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
polygon(points = [[0, 0], [0, 35.0], [30.31088913245535, 17.500000000000004]]);
}
}
}
translate(v = [25.980762113533157, -14.999999999999996])
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
polygon(points = [[0, 0], [0, 25.0], [12.499999999999998, 21.65063509461097]]);
}
}
}
translate(v = [9.999999999999998, 2.6794919243112254])
rotate(a = [0, 0, 30])
rotate(a = [0, 90, 0])
rotate(a = [0, 0, 30])
difference(){linear_extrude(height = 10){circle($fn = 6, r = 5.000);
}
translate(v = [0, 0, -0.1])
linear_extrude(height = 10.200){circle(r = 3.000);
}
}
}
rotate(a = [0, 90, 0])
rotate(a = [0, 0, 30])
difference(){linear_extrude(height = 30){circle($fn = 6, r = 5.000);
}
translate(v = [0, 0, -0.1])
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
translate(v = [0, 0, -0.1])
linear_extrude(height = 3.200){circle(r = 3.000);
}
}
}
}
}
}
