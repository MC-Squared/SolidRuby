begin
  require 'pry'
rescue LoadError
end

require 'solidruby/version'
require 'solidruby/bill_of_material'
require 'solidruby/solidruby_object'
require 'solidruby/rubyscad_bridge'
require 'solidruby/parameters'
require 'solidruby/project_cli'

require 'solidruby/primitives/primitive'
require 'solidruby/primitives/cylinder'
require 'solidruby/primitives/cube'
require 'solidruby/primitives/sphere'
require 'solidruby/primitives/cylinder'
require 'solidruby/primitives/circle'
require 'solidruby/primitives/polygon'
require 'solidruby/primitives/square'
require 'solidruby/primitives/render'
require 'solidruby/primitives/import'
require 'solidruby/primitives/surface'
require 'solidruby/primitives/text'

require 'solidruby/helpers/chamfer'
require 'solidruby/helpers/fillet'
require 'solidruby/helpers/position'
require 'solidruby/helpers/rounded_cube'
require 'solidruby/helpers/triangle'

require 'solidruby/primitives/polyhedron' # not tested

require 'solidruby/csg_modifiers/csg_modifier'
require 'solidruby/csg_modifiers/color'
require 'solidruby/csg_modifiers/linear_extrude'
require 'solidruby/csg_modifiers/rotate_extrude'
require 'solidruby/csg_modifiers/projection'

require 'solidruby/csg_modelling/csg_modelling'
require 'solidruby/csg_modelling/difference'
require 'solidruby/csg_modelling/hull'
require 'solidruby/csg_modelling/intersection'
require 'solidruby/csg_modelling/minkowski'
require 'solidruby/csg_modelling/union'

require 'solidruby/assemblies/assembly'
require 'solidruby/assemblies/linear_bearing'
require 'solidruby/assemblies/gear'
require 'solidruby/assemblies/pipe'
require 'solidruby/assemblies/ruler'

require 'solidruby/assemblies/bolt'
require 'solidruby/assemblies/nut'
require 'solidruby/assemblies/washer'

require 'solidruby/transformations/transformation'
require 'solidruby/transformations/translate'
require 'solidruby/transformations/rotate'
require 'solidruby/transformations/mirror'
require 'solidruby/transformations/scale'

require 'solidruby/screw_thread'
require 'solidruby/printed_thread'
require 'solidruby/extra'

require 'solidruby/solidruby'