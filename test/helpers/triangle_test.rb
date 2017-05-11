require 'test_helper'

class TestTriangle
  attr_accessor :a, :b, :c, :alpha, :beta, :gamma, :use_alt_one, :use_alt_two
  def initialize(args)
    @a = args[:a]
    @b = args[:b]
    @c = args[:c]
    @alpha = args[:alpha]
    @beta = args[:beta]
    @gamma = args[:gamma]
    @use_alt_one = args[:use_alt_one] || false
    @use_alt_two = args[:use_alt_one] || false
  end
end

class TriangleTest < Minitest::Test
  def test_triangle_solving
    triangles = [
      TestTriangle.new(a: 10, b: 20, c: 29, alpha: 10.384, beta: 21.131, gamma: 148.484, use_alt_one: true, use_alt_two: true),
      TestTriangle.new(a: 50, b: 40, c: 30, alpha: 90, beta: 53.130, gamma: 36.8698),
      TestTriangle.new(a: 17, b: 25.154, c: 36.556, alpha: 24, beta: 37, gamma: 119, use_alt_one: true),
    ]

    triangles.each do |exp|
      #test all triangle variations
      check_triangle(exp, Triangle.new(a: exp.a, b: exp.b, c: exp.c))
      check_triangle(exp, Triangle.new(a: exp.a, b: exp.b, alpha: exp.alpha))
      check_triangle(exp, Triangle.new(a: exp.a, b: exp.b, beta: exp.beta))
      check_triangle(exp, Triangle.new(a: exp.a, b: exp.b, gamma: exp.gamma))

      check_triangle(exp, Triangle.new(b: exp.b, c: exp.c, alpha: exp.alpha))
      check_triangle(exp, Triangle.new(b: exp.b, c: exp.c, beta: exp.beta, alt_solution: exp.use_alt_one))
      check_triangle(exp, Triangle.new(b: exp.b, c: exp.c, gamma: exp.gamma))

      check_triangle(exp, Triangle.new(a: exp.a, c: exp.c, alpha: exp.alpha, alt_solution: exp.use_alt_two))
      check_triangle(exp, Triangle.new(a: exp.a, c: exp.c, beta: exp.beta))
      check_triangle(exp, Triangle.new(a: exp.a, c: exp.c, gamma: exp.gamma))

      check_triangle(exp, Triangle.new(a: exp.a, alpha: exp.alpha, beta: exp.beta))
      check_triangle(exp, Triangle.new(a: exp.a, alpha: exp.alpha, gamma: exp.gamma))
      check_triangle(exp, Triangle.new(a: exp.a, beta: exp.beta, gamma: exp.gamma))

      check_triangle(exp, Triangle.new(b: exp.b, alpha: exp.alpha, beta: exp.beta))
      check_triangle(exp, Triangle.new(b: exp.b, alpha: exp.alpha, gamma: exp.gamma))
      check_triangle(exp, Triangle.new(b: exp.b, beta: exp.beta, gamma: exp.gamma))

      check_triangle(exp, Triangle.new(c: exp.c, alpha: exp.alpha, beta: exp.beta))
      check_triangle(exp, Triangle.new(c: exp.c, alpha: exp.alpha, gamma: exp.gamma))
      check_triangle(exp, Triangle.new(c: exp.c, beta: exp.beta, gamma: exp.gamma))
    end
  end

  def check_triangle(exp, tri)
    assert_in_delta exp.a, tri.a, 0.5
    assert_in_delta exp.b, tri.b, 0.5
    assert_in_delta exp.c, tri.c, 0.5
    assert_in_delta exp.alpha, tri.alpha, 0.5
    assert_in_delta exp.beta, tri.beta, 0.5
    assert_in_delta exp.gamma, tri.gamma, 0.5
  end
end
