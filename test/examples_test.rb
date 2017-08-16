require 'test_helper'
require 'fileutils'

# HACK: SolidRuby::import collides with Rake::DSL::import when running
# tests using rake. To prevent this, we override it here
module Rake
  module DSL
    def import(args)
      SolidRuby::Import.new(args)
    end
  end
end

class ExamplesTest < Minitest::Test
  def test_example_scad
    FileUtils.rm_rf('test-tmp')
    FileUtils.mkdir('test-tmp')
    FileUtils.cd('test-tmp')
    #generate all example files and comapre them
    #against the 'gold standards' in test/examples
    Dir.glob('../examples/**/*.rb').map do |f|
      require_relative("#{f}")
    end

    FileUtils.cd('..')

    Dir.glob('./test-tmp/*.scad').map do |f|
      gold_f = './test/examples/' + f.gsub('./test-tmp/', '')

      gold_c = File.read(gold_f)
      test_c = File.read(f)

      assert_equal gold_c, test_c, "Comparing: #{gold_f} with #{f}"
    end

    FileUtils.rm_rf('test-tmp')
  end
end
