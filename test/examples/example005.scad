translate(v = [0, 0, -120])
union(){difference(){cylinder(h = 50, r = 100.000);
translate(v = [0, 0, 10])
cylinder(h = 50, r = 80.000);
translate(v = [100, 0, 35])
cube(size = [50, 50, 50], center = true);
}
translate(v = [0.000, 80.000])
cylinder(h = 200, r = 10.000);
translate(v = [69.282, 40.000])
cylinder(h = 200, r = 10.000);
translate(v = [69.282, -40.000])
cylinder(h = 200, r = 10.000);
translate(v = [0.000, -80.000])
cylinder(h = 200, r = 10.000);
translate(v = [-69.282, -40.000])
cylinder(h = 200, r = 10.000);
translate(v = [-69.282, 40.000])
cylinder(h = 200, r = 10.000);
translate(v = [0, 0, 200])
cylinder(h = 80, r1 = 120.000, r2 = 0.000);
}
