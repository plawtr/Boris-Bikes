require_relative 'bike_container'

class Van

	include BikeContainer
	include Loader
	
	def initialize(options = {})	
		self.capacity = options.fetch(:capacity, capacity)
	end


end
