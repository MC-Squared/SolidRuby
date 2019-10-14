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
require 'yaml'

module SolidRuby::Parameters
  class Parameters
    class << self
      @@verbose = true

      def yml_path
        @@yml_path
      end

      def yml_path=(path)
        if File.directory?(path)
          path = File.join(path, "parameters.yml")
        end

        @@yml_path = path
        # force reloading yml
        clear_params
      end

      def variant
        @@variant
      end

      def variant=(name)
        @@variant = name.to_s
      end

      def verbose=(val)
        @@verbose = !!val
      end

      def load_yml
        @@yml_path ||= "parameters.yml"

        if File.file?(@@yml_path)
          YAML.load_file(@@yml_path)
        else
          raise "Could not read paramters yml file at #{@@yml_path}"
        end
      end

      def add_overrides(values={})
        @@overrides ||= {}
        @@overrides.merge!(values)
        clear_params
      end

      def clear_overrides
        @@overrides = {}
        clear_params
      end
    end

    def method_missing(method, *args)
      name = method.to_s
      raise "UnknownParameter #{method}" unless name.end_with?("=")

      name = name.chomp("=").to_sym

      if @@values.keys.include?(name) && @@values[name] != args.first
        raise "ConflictingParameter #{method}"
      elsif @@values.keys.include?(name)
        warn "Duplicate definition of #{name} = #{args} @ #{caller[0]}"
      else
        warn "Adding parameter #{name} = #{args}, it is recommended you place this in a parameters.yml file"
      end

      return if singleton_class.method_defined?(name)

      define_singleton_method(name) { @@values[name] }
      add_parameter(name, args.first)
    end

    def to_s
      "#{super} #{@@variant} #{@@values}"
    end
    alias inspect to_s

    private

    def initialize
      load_yml_settings
    end

    def add_parameter(name, value)
      name = name.to_sym
      @@values[name] = value

      return if singleton_class.method_defined?(name)

      define_singleton_method(name) { @@values[name] }
    end

    def load_yml_settings
      @@values = {}
      @@variant ||= "default"
      @@overrides ||= {}

      yml = self.class.load_yml
      yml_values = yml[@@variant]

      raise "Missing '#{@@variant}' entry in parameters yml" if yml_values.nil?

      yml_values.merge(@@overrides).each do |k, v|
        add_parameter(k, v)
      end
    end

    def warn(str)
      puts str if @@verbose
    end
  end

  def params
    @@params ||= Parameters.new
  end

  private

  def clear_params
    @@params = nil
  end
end
