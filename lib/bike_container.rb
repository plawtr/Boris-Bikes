module BikeContainer

	DEFAULT_CAPACITY = 10
	
	def bikes
		@bikes ||= [] 
	end

	def capacity
		@capacity ||= DEFAULT_CAPACITY
	end

	def capacity=(value)
		@capacity = value
	end

	def bike_count
		bikes.count	
	end

	def dock(bike)
		raise "You have not asked to dock anything" if bike.nil?
		raise "There is no more room for bikes" if full?
		bikes << bike
	end

	def release(bike)	
		raise "You have not asked to release anything." if bike.nil?
		raise "Not available to release." unless available_bikes.include?(bike)
		bikes.delete(bike)
	end

	def full?
		bike_count == capacity
	end

	def available_bikes 
		bikes.reject {|bike| bike.broken? }
	end

	def broken_bikes
		bikes.reject {|bike| !bike.broken? }
	end

	def empty?
		@bikes.empty?
	end

	def release_broken 
		container = broken_bikes
		@bikes-=broken_bikes
		container	
	end

	def release_working
		container = available_bikes
		@bikes-=available_bikes
		container
	end
end
