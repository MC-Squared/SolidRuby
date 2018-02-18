SolidRuby
===========

SolidRuby is a framework for programming 2d and 3d OpenSCAD models in Ruby.
It is a fork of [CrystalScad](https://github.com/Joaz/CrystalScad) with the aim to update and improve the codebase.

SolidRuby, like CrystalScad and RubyScad on which it is based, is released under the GPLv3 license.

[![Build Status](https://travis-ci.org/MC-Squared/SolidRuby.svg?branch=master)](https://travis-ci.org/MC-Squared/SolidRuby)

Installation:
===========

Dependencies:

- Ruby 1.9.3+

Install via gem:
```
# gem install solidruby
```

if you have multiple ruby versions, you likely need to use gem1.9.3 instead of gem.

Install via git:

- clone repository
- \# rake install

Getting started
===========
SolidRuby comes with a generator that generates project stubs automatically for you. Run this command from a terminal in the directory that you want to create a project:

```
# solidruby new [my_project_name]
```
Change [my_project_name] to the name of your project

A project named "my_project" will create those files and directories:

- my_project/my_project.rb - the controller
- my_project/lib/assemblies - for putting together assemblies of individual parts
- my_project/lib/electronics - put electronics here
- my_project/lib/hardware - put hardware parts in here
- my_project/lib/printed - put parts that you want to print in here
- my_project/lib/lasercut - put sheets that need to be cut (by laser or other) in here
- my_project/lib/params.rb - place for global parameters
- my_project/lib/assemblies/my_project_assembly.rb  - dummy assembly
- my_project/Guardfile - guard

A Guardfile is created to automatically update the output scad files.

Coding
===========
Nearly all OpenSCAD functions are implemented. You can use the same parameters as in OpenSCAD, although SolidRuby provides some convenient variable names like diameter (d) for cylinders.

Some examples:

CSG Modeling:
```
res = cylinder(d:10, h:10)
# union
res += cube(x:5, y:20, z:20)
# difference
res -= cylinder(d:5, h:10)
# intersection
res *= cylinder(d:10, h:10)
```

Chain transformations:  
```
res = cube(1, 2, 3).rotate(x: 90).translate(x: 20, y: 2, z: 1).mirror(z: 1)
```


Hull:   
```
  res = hull(cylinder(d:10, h:10).cube(20, 10, 10].translate(x: 10)))
```

Center cubes in X/Y direction only:    
```
  cube(10, 10, 10).center_xy # note: only works on cubes and must be put before any transformations
```

Also implemented: center_x, center_y, center_z, center

Helpers:

Some helpers have been implemented to ease modelling.
Where helpers take face/edge/corner the options are:
```
  faces: :top, :bottom, :left, :right, :front, :back, :center
  edges: :top, :bottom, :left, :right, :front, :back, :center
  corners: :left, :right, :center
```
For example:

Triangles - can be either linear_extruded or simply used for calulations
  triangle(alpha: 90, c: 5, b: 3) #a right triangle on the origin, with Y leg 5 units, X leg 3 units
```
triangle(alpha: 45, c: 6, b: 9).beta #get calulated angle from triangle
```

Filleted cubes
Filled cubes can be created by using the .fillet helper:
```
cube(10).fillet(edges: :vertical, r: 2)
cube(10).fillet(top: [:left, :right], front: :bottom, r: 2)
```

Chamfered cubes
Similar to filleted cubes above
```
cube(10).chamfer(edges: :vertical, h: 2)
```

Both the fillet() and chamfer() helper can be used in isolation as well:
```
fillet(h: 10, r: 2)
chamfer(l: 10, h: 2)
```

Rounded cubes:
Due to how fillet is applied, the corners of a cube are not perfect when doing all sides.
In this case you can use rounded_cube:
```
rounded_cube(x: 10, y: 10, z: 10, r: 2) #Actually a hull of 8 spheres
```

Hollow cylinders:
Hollow cylinders can be created by indicating an :id argument (inner diameter)
```
cylinder(d: 10, id: 8, h: 10) #creates a fully hollow cylinder
cylinder(d: 10, id: 8, h: 10, ih: 8) #inner cutout only partial height
```

Placing onto:
For simple primitives you can use .place to place objects onto their faces:
```
  c = cube(10)
  res = c + cube(5).place(onto: c, face: :top, edge: :top, corner: :center)

  cy = cylinder(d: 10, h: 50)
  res = cy + sphere(10).place(onto: cy, face: :top) #edge and corner default to center
```

Long slots:   
```
  # produces a hull of two cylinders, 14mm apart        
  long_slot(d:4.4, h:10, l:14)  
```

Printed threads:
There is a printed thread class for printing threads, i.e. for nuts and bolts:
```
t1 = PrintedThread.new(diameter: 20, pitch: 2.5, length: 22.5, internal: true)
```


A few tips:
- Be visual. By running `guard` you can watch your updates in OpenSCAD

- When porting OpenSCAD code, beware of dividing integers. Example:
```
cylinder(r=11/2, h=10);
```
needs to be ported to
```
cylinder(r:11/2.0, h:10)
```
or
```
cylinder(d:11, h:10)
```


License:
===========
GPLv3
