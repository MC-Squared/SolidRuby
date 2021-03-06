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

module SolidRuby::BillOfMaterial
  class BillOfMaterial
    attr_accessor :parts
    def initialize
      @parts = {}
    end

    def add(part, quantity = 1)
      @parts[part] ||= 0
      @parts[part] += quantity
    end

    def output
      @parts.map { |key, qty| "#{qty} x #{key}" }.join("\n")
    end

    def save(filename = 'output/bom.txt')
      file = File.open(filename, 'w')
      file.puts output
      file.close
    end
  end

  @bom = BillOfMaterial.new
  def self.bom
    @bom
  end
end
