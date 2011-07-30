# Answer to:
# http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/385984

module Chemistry
	class Element
		attr_reader :name
		attr_reader :mass
		attr_reader :symbol

		def initialize(name,mass,symbol)
			@name = name
			@mass = mass
			@symbol = symbol
		end
	end
end

elements = [
	Chemistry::Element.new("hydrogen", 1.0079, "H"),
	Chemistry::Element.new("lithium", 6.941, "Li")
]

elements.each do |element|
	Chemistry.const_set(element.symbol, element)
end

include Chemistry
puts Li.name