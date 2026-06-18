require 'test_helper'
require 'fileutils'

class ExamplesTest < Minitest::Test
  def test_example_scad
    return if ENV['SKIP_EXAMPLES']

    FileUtils.rm_rf('test-tmp')
    FileUtils.mkdir('test-tmp')
    FileUtils.cd('test-tmp')
    # generate all example files and compare them
    # against the 'gold standards' in test/examples
    lib = File.expand_path('../lib', __dir__)
    Dir.glob('examples/**/*.rb').each do |f|
      script = File.expand_path(f)
      # run each example in a clean Ruby process so Rake::DSL#import
      # can't shadow SolidRuby's import
      out = `cd test-tmp && ruby -I#{lib} #{script} 2>&1`
      assert $?.success?, "Failed to run #{f}:\n#{out}"
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
