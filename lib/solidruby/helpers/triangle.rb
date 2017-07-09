#    This file is part of SolidRuby.
#
#    SolidRuby is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    SolidRuby is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with SolidRuby.  If not, see <http://www.gnu.org/licenses/>.
#
module SolidRuby::Helpers
   #Helper class for creating triangles, given three inputs
   # (at least 1 side + angles)
   #The triangle can then either be used as a Polygon,
   #or it can be thrown away and used just for calcuation of the triangle
   #order is assumed as follows:
   # @a is opposite @alpha, @b is opposite @beta, @c is opposite @gamma
   #sides a,b,c go clockwise from 0,0 (x,y)
   class Triangle < SolidRuby::Primitives::Polygon
    attr_accessor :alpha, :beta, :gamma, :a, :b, :c, :has_alt_solution
    def initialize(args = {})
      use_alt_solution = args[:alt_solution] || false

      if args.reject{|k| k == :alt_solution}.count != 3
        raise "Triangle requires exactly 3 inputs"
      elsif args[:a].nil? && args[:b].nil? && args[:c].nil?
        raise "Triangle requires at least 1 side length"
      end

      #try to solve twice to see if we have two solutions
      sol_count = 0
      solution = solve(args, false)
      sol_count += 1 unless solution.nil?
      solution_alt = solve(args, true)
      sol_count += 1 unless solution_alt.nil?

      raise "Could not solve triangle." if sol_count == 0

      @has_alt_solution = sol_count == 2 ? true : false

      if use_alt_solution
        update(solution_alt)
      else
        update(solution)
      end

      mult = @beta / 90.0
      #consturct triangle polygon
      args = {points: [
        [0, 0],
        [@a*mult,@a*(1-mult)],
        [0, @c],
        [0, 0]]}
      super(args)
    end

    def triangle(args)
      Triangle.new(args)
    end

private
    def update(params)
      @alpha = params[:alpha]
      @beta = params[:beta]
      @gamma = params[:gamma]
      @a = params[:a]
      @b = params[:b]
      @c = params[:c]
    end
    #Solve for any missing angles/sides
    def solve(triangle_params, alt_solution)
      alpha = triangle_params[:alpha]
      beta = triangle_params[:beta]
      gamma = triangle_params[:gamma]
      a = triangle_params[:a]
      b = triangle_params[:b]
      c = triangle_params[:c]

      #find side for SAS case
      a = solve_side_from_single_angle(b, c, alpha) if a.nil?
      b = solve_side_from_single_angle(a, c, beta) if b.nil?
      c = solve_side_from_single_angle(a, b, gamma) if c.nil?

      #find one angle (SSS case)
      alpha = solve_angle_from_sides(b, c, a) if alpha.nil?
      beta = solve_angle_from_sides(a, c, b) if beta.nil?
      gamma = solve_angle_from_sides(a, b, c) if gamma.nil?

      #now we know at least one angle, find the next one (SSA case)
      alpha = solve_angle_from_angle(a, b, beta, alt_solution) if alpha.nil?
      alpha = solve_angle_from_angle(a, c, gamma, alt_solution) if alpha.nil?
      beta = solve_angle_from_angle(b, a, alpha, alt_solution) if beta.nil?
      beta = solve_angle_from_angle(b, c, gamma, alt_solution) if beta.nil?
      gamma = solve_angle_from_angle(c, a, alpha, alt_solution) if gamma.nil?
      gamma = solve_angle_from_angle(c, b, beta, alt_solution) if gamma.nil?

      #now we know at least two angles, solve the third one
      alpha = sub_angles(beta, gamma) if alpha.nil?
      beta = sub_angles(alpha, gamma) if beta.nil?
      gamma = sub_angles(alpha, beta) if gamma.nil?

      #we know all the angles, now find any unknown sides
      a = solve_side(alpha, b, beta) if a.nil?
      a = solve_side(alpha, c, gamma) if a.nil?
      b = solve_side(beta, a, alpha) if b.nil?
      b = solve_side(beta, c, gamma) if b.nil?
      c = solve_side(gamma, a, alpha) if c.nil?
      c = solve_side(gamma, b, beta) if c.nil?

      return nil if a.nil? || b.nil? || c.nil? || alpha.nil? || beta.nil? || gamma.nil?
      {a: a, b: b, c: c, alpha: alpha, beta: beta, gamma: gamma}
    end

    def sub_angles(angle1, angle2)
      return nil if angle1.nil? || angle2.nil?
      180 - angle1 - angle2
    end

    def solve_angle_from_sides(adj_side, adj_side2, opp_side)
      return nil if adj_side.nil? || adj_side2.nil? || opp_side.nil? ||
        adj_side == 0 || adj_side2 == 0 || opp_side == 0

      degrees(Math.acos((adj_side**2 + adj_side2**2 - opp_side**2) / (2.0 * adj_side * adj_side2)))
    end

    def solve_angle_from_angle(opp_side, adj_side, adj_angle, alt_solution)
      return nil if opp_side.nil? || adj_side.nil? || adj_angle.nil?

      res = degrees(Math.asin(opp_side * Math.sin(radians(adj_angle)) / adj_side))
      res = 180 - res if alt_solution
      res
    end

    def solve_side_from_single_angle(side1, side2, angle)
      return nil if side1.nil? || side2.nil? || angle.nil?

      Math.sqrt(side1**2 + side2**2 - 2 * side1 * side2 * Math.cos(radians(angle)))
    end

    def solve_side(opp_angle, adj_side, adj_opp_angle)
      return nil if opp_angle.nil? || adj_side.nil? || adj_opp_angle.nil?

      (Math.sin(radians(opp_angle)) * adj_side)/Math.sin(radians(adj_opp_angle))
    end
  end
end
