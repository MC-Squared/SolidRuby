require 'thor'

class SolidRuby::ProjectCli < Thor

  def method_missing(method, *args, &block)
    # Split args that look like options (i.e start with - or --) into a separate array
    _, opts = Thor::Options.split(args)
    # add all parameter options
    yml = SolidRuby::Parameters::Parameters.load_yml
    yml_options = { "--variant" => Thor::Option.new("--variant") }
    yml.each do |_, params|
      params.each do |name, _|
        yml_options["--#{name.gsub('_', '-')}"] = Thor::Option.new("--#{name.gsub('_', '-')}")
      end
    end

    parser = Thor::Options.new(yml_options)

    # The options hash is frozen in #initialize so you need to merge and re-assign
    self.options = options.merge(parser.parse(opts)).freeze

    # Dispatch the command
    send(:dynamic_params, options)
  end

  desc "output OPTIONS", "generate SCAD output, overriding any parameters in parameters.yml"
  default_task :output

  private

  def dynamic_params(options)
    options.each do |name, value|
      name = name.gsub('-', '_')
      if name == "variant"
        SolidRuby::Parameters::Parameters.variant = value
      else
        SolidRuby::Parameters::Parameters.add_overrides(name => value)
      end
    end
  end
end
