require_relative "../lib/bike.rb"
require_relative "../lib/docking_station.rb"

describe Bike do 

	let(:bike) {Bike.new}

	it "should not be broken after we create it" do 
		expect(bike).not_to be_broken
    end

    it "should be able to break" do
    	bike.break
    	expect(bike).to be_broken 
    end

    it "should be able to be fixed" do 
    	bike.break
    	bike.fix
    	expect(bike).not_to be_broken
    end
end

describe DockingStation do

	let(:bike) {Bike.new}
	let(:station) {DockingStation.new(:capacity => 20)}

	it "should accept a bike" do
		expect(station.bike_count).to eq(0)
		station.dock(bike) 
		expect(station.bike_count).to eq(1)
	end

	it "should release a bike" do
		station.dock(bike)
		station.release(bike)
		expect(station.bike_count).to eq(0)
	end

	it "should know when it is full" do
		expect(station).not_to be_full
		20.times {station.dock(Bike.new)}
		expect(station).to be_full
	end
end

