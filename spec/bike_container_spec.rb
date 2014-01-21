require_relative "../lib/bike_container"

class ContainerHolder; include BikeContainer; end

describe BikeContainer do

	let(:bike) {Bike.new}
	let(:holder) {ContainerHolder.new}

	def fill_holder(holder)
		holder.capacity.times { holder.dock(Bike.new)}
	end

	it "should accept a bike" do
		expect(holder.bike_count).to eq(0)
		holder.dock(bike) 
		expect(holder.bike_count).to eq(1)
	end

	it "should release a bike" do
		holder.dock(bike)
		holder.release(bike)
  		#expect(holder.available_bikes.length).to eq(0)
		expect(holder.bike_count).to eq(0)
	end

	it "should know when it is full" do
		expect(holder).not_to be_full
		fill_holder holder
		expect(holder).to be_full
	end

	it "should not accept a bike if it is full" do
		fill_holder holder
		expect{holder.dock(bike)}.to raise_error(RuntimeError)
	end

	it "should provide the list of available bikes" do
		working_bike, broken_bike = Bike.new, Bike.new
		broken_bike.break
		holder.dock(working_bike)
		holder.dock(broken_bike)
		expect(holder.available_bikes).to eq([working_bike])
	end

	it "should not release a bike that is not there or not available" do
		docked_bike = Bike.new
		holder.dock(docked_bike)
		expect{holder.release(bike)}.to raise_error(RuntimeError)
	end

	it "should not release a bike if asked to release nothing" do
      	expect{holder.release()}.to raise_error(ArgumentError)
	end

	it "should not release a bike if asked to release something that is not docked" do
		expect{holder.release("orange")}.to raise_error(RuntimeError)
	end 

	it "should not dock if asked to dock an empty thing" do
      	expect{holder.dock()}.to raise_error(ArgumentError)
	end

	it "should not dock if asked to dock nil" do
		expect{holder.dock(nil)}.to raise_error(RuntimeError)
	end

	it "should know when it is empty" do
		holder.dock(bike)
		holder.release(bike)
		expect(holder.empty?).to eq(true)
	end

	it "should provide the list of broken bikes" do
		working_bike, broken_bike = Bike.new, Bike.new
		broken_bike.break
		holder.dock(working_bike)
		holder.dock(broken_bike)
		expect(holder.broken_bikes).to eq([broken_bike])
	end

	it "should release all broken bikes when asked" do 
		working_bike, broken_bike1, broken_bike2 = Bike.new, Bike.new, Bike.new
		broken_bike1.break
		broken_bike2.break
		holder.dock(broken_bike1)
		holder.dock(broken_bike2)
		holder.dock(working_bike)
		expect(holder.release_broken).to eq([broken_bike1, broken_bike2])
		expect(holder.available_bikes).to eq([working_bike])
	end

	it "should release all working bikes when asked" do 
		broken_bike, working_bike1, working_bike2 = Bike.new, Bike.new, Bike.new
		broken_bike.break
		holder.dock(broken_bike)
		holder.dock(working_bike1)
		holder.dock(working_bike2)
		expect(holder.release_working).to eq([working_bike1, working_bike2])
		expect(holder.available_bikes).to eq([])
	end


end

