require_relative "../lib/docking_station"

describe DockingStation do

	let(:station) {DockingStation.new(:capacity => 123)}

	it "should allow setting default capacity on initializing" do
		expect(station.capacity).to eq(123)
	end

	it "should fix the bike when it is docked" do
		bike = Bike.new
		bike.break
		station.dock(bike)
		expect(bike).not_to be_broken 
	end

end

