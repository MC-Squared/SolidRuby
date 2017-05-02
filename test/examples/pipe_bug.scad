$fn=64;
union(){translate(v = [20, 0])
union(){color("yellow"){translate(v = [0, -20])
intersection(){rotate_extrude($fn = 128){translate(v = [20, 0])
circle($fn = 64, r = 5.000);
}
translate(v = [0, 0, -50])
linear_extrude(height = 100){scale(v = 2)
polygon(points = [[0, 0], [0, 25.000], [3.479, 24.757]]);
}
}
}
translate(v = [2.783, -0.195])
rotate(a = [0, 0, -8])
rotate(a = [0, 90, 0])
rotate(a = [0, 0, 0])
color("red"){linear_extrude(height = 5){circle($fn = 64, r = 5.000);
}
}
}
rotate(a = [0, 90, 0])
rotate(a = [0, 0, 0])
color("blue"){linear_extrude(height = 20){circle($fn = 64, r = 5.000);
}
}
}
