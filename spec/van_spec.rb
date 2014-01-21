require_relative "../lib/van"

describe Van do

	let(:van) {Van.new(:capacity => 20)}
	let(:smallvan) {Van.new(:capacity => 1)}
	let(:bike) {Bike.new}
	let(:station) {DockingStation.new(:capacity => 123)}
	let(:small_station) {DockingStation.new(:capacity => 2)}

	it "should allow setting default capacity on initializing" do
		expect(van.capacity).to eq(20)
	end

	it "should not load bikes if none are broken" do
		bike, bike1, bike2 = Bike.new, Bike.new, Bike.new
		station.dock(bike1)
		station.dock(bike2)
		station.dock(bike)
		expect{van.load_broken(station)}.to raise_error(RuntimeError)
	end

	it "should load up broken bikes" do
		working_bike, broken_bike1, broken_bike2 = Bike.new, Bike.new, Bike.new
		broken_bike1.break
		broken_bike2.break
		station.dock(broken_bike1)
		station.dock(broken_bike2)
		station.dock(working_bike)
		van.load_broken(station)
		expect(station.broken_bikes).to eq([])
		expect(van.bikes).to eq([broken_bike1, broken_bike2])
	end

	it "should make sure that the van does not load broken bikes from docking station beyond capacity" do
		working_bike, broken_bike1, broken_bike2 = Bike.new, Bike.new, Bike.new
		broken_bike1.break
		broken_bike2.break
		station.dock(broken_bike1)
		station.dock(broken_bike2)
		station.dock(working_bike)
		smallvan.load_broken(station)
		expect(station.broken_bikes.size).to eq(1)
		expect(smallvan.bikes.size).to eq(1)
	end

	it "should dock bikes (fixed first) into the station until station capacity" do
		working_bike, broken_bike1, broken_bike2 = Bike.new, Bike.new, Bike.new
		broken_bike1.break
		broken_bike2.break
		van.dock(broken_bike1)
		van.dock(broken_bike2)
		van.dock(working_bike)
		van.unload_to(station)
		expect(station.bikes).to eq([working_bike, broken_bike1, broken_bike2])
	end
end

