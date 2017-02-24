class TestCube < SolidRuby::Printed
  def initialize
    # Here is a good place to define instance variables that make your part parametric.
    # These variables are accessible from outside:
    @x = 25
    @y = 25
    @z = 20
    @hardware = []
    @color = 'BurlyWood'

    # The variable below is not accessible from the outside unless you specify so with attr_accessable
    @diameter = 10
  end

  def part(_show)
    # We start with a cube and center it in x and y direction. The cube starts at z = 0 with this.
    res = cube(@x, @y, @z).center_xy

    # We want a bolt to go through it. It will be facing upwards however, so we will need to mirror it.
    # Also translating it to twice the height, as we want to stack two of these cubes together in the assembly.
    bolt = Bolt.new(4, 40).mirror(z: 1).translate(z: @z * 2)
    @hardware << bolt

    # We also want a nut. And since the printing direction is from the bottom, we decide to add support to it.
    nut = Nut.new(4, support: true, support_layer_height: 0.3)
    @hardware << nut

    # subtracting the @hardware array will call the .output method on each hardware item automatically
    res -= @hardware

    # colorize is a convenience thing to colorize your part differently in assemblies.
    # You can specify @color in initialize (as default color), or set a different color in the assembly this way.
    res = colorize(res)

    # Note: Make sure you do this before adding parts (i.e. hardware) that have their own color and that
    #				you do not want to colorize.

    # You can go ahead and show the hardware when the part produces its 'show' output file by uncommenting this:
    #		res += @hardware if show
    # However, in this example, the Assembly file calls show_hardware in order to not show it twice.

    # always make sure the lowest statement always returns the object that you're working on
    res
  end

  # with view you can define more outputs of a file.
  # This is useful when you are designing subassemblies of an object.
  view :my_subassembly

  def my_subassembly
    res = hull(
      cylinder(d: @diameter, h: @z),
      cube(@x, @y, @z)
    )
    res
  end
end
