require_relative "../lib/garage"

describe Garage do

	let(:garage) {Garage.new(:capacity => 20)}
	let(:bike) {Bike.new}
	let(:van) {Van.new(:capacity => 20)}
	let(:smallvan) {Van.new(:capacity => 1)}

	it "should allow setting default capacity on initializing" do
		expect(garage.capacity).to eq(20)
	end

	it "should fix bikes instantly after being docked" do
		working_bike, broken_bike1, broken_bike2 = Bike.new, Bike.new, Bike.new
		broken_bike1.break
		broken_bike2.break
		garage.dock(working_bike)
		garage.dock(broken_bike1)
		garage.dock(broken_bike2)
		expect(garage.broken_bikes).to eq([])
		expect(garage.available_bikes).to eq([working_bike, broken_bike1, broken_bike2])
	end

	it "should release fixed bikes to the van" do
		working_bike, broken_bike1, broken_bike2 = Bike.new, Bike.new, Bike.new
		broken_bike1.break
		broken_bike2.break
		garage.dock(working_bike)
		garage.dock(broken_bike1)
		garage.dock(broken_bike2)
		garage.unload_to(van)
		expect(garage.available_bikes).to eq([])
	end

	it "should dock the bikes back in the garage if they do not all fit to the van" do
		working_bike, broken_bike1, broken_bike2 = Bike.new, Bike.new, Bike.new
		broken_bike1.break
		broken_bike2.break
		garage.dock(working_bike)
		garage.dock(broken_bike1)
		garage.dock(broken_bike2)
		garage.unload_to(smallvan)
		expect(garage.available_bikes.size).to eq(2)
		expect(smallvan.available_bikes.size).to eq(1)
	end
end
