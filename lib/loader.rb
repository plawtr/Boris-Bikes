module Loader

	def load_broken(station)
		raise "No broken bikes!" if station.broken_bikes.empty?
		station.release_broken.each{|bike| full? ? station.dock(bike) : dock(bike)}
	end

	def unload_to(station)
		raise "Nowhere to unload!" if station.full?
    release_working.each {|bike| !station.full? ? station.dock(bike) : dock(bike)}
		release_broken.each {|bike| !station.full? ? station.dock(bike) : dock(bike)}
	end

end
