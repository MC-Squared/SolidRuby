difference(){intersection(){intersection(){translate(v = [-25, -25, -25])
linear_extrude(convexity = 3, height = 50){import(file="example008.dxf",layer="G");
}
rotate(a = [90, 0, 0])
translate(v = [-25, -125, -25])
linear_extrude(convexity = 3, height = 50){import(file="example008.dxf",layer="E");
}
}
rotate(a = [0, 90, 0])
translate(v = [-125, -125, -25])
linear_extrude(convexity = 3, height = 50){import(file="example008.dxf",layer="B");
}
}
intersection(){translate(v = [-125, -25, -26])
linear_extrude(convexity = 1, height = 52){import(file="example008.dxf",layer="X");
}
rotate(a = [0, 90, 0])
translate(v = [-125, -25, -26])
linear_extrude(convexity = 1, height = 52){import(file="example008.dxf",layer="X");
}
}
}
