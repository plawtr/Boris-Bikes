require_relative 'bike_container'
require_relative 'fix_extension'

class DockingStation

	include BikeContainer
	prepend FixExtension 

	def initialize(options = {})	
		self.capacity = options.fetch(:capacity, capacity)
	end

	
end
