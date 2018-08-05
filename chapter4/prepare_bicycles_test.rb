# 4.6
describe Mechanic do
  describe '#prepare_bicycle' do
    # it…
    # it…
    # it…
  end
end

describe Trip do
  describe '#prepare' do
    it 'prepares the bicycles' do
      bicycles = 3.times.map { |_| double }
      mechanic = double
      trip = Trip.new(mechanic: mechanic, bicycles: bicycles)

      bicycles.each do |bicycle|
        expect(mechanic).to receive(:prepare_bicycle).with(bicycle)
      end

      trip.prepare
    end
  end
end


# 4.7
describe Mechanic do
  describe '#prepare_trip' do
    it 'prepares bicycles' do
      trip = double(bicycles: [double, double])
      mechanic = Mechanic.new

      trip.bicycles.each do |bicycle|
        expect(mechanic).to receive(:prepare_bicycle).with(bicycle)
      end

      mechanic.prepare_trip(trip) 
    end
  end

  describe '#prepare_bicycle' do
    # it…
    # it…
  end
end

describe Trip do
  describe '#prepare' do
    it 'prepares the bicycles' do
      mechanic = double(prepare_trip: true)
      trip = Trip.new(mechanic: mechanic)
      expect(mechanic).to receive(:prepare_trip).with(trip)
      trip.prepare
    end
  end
end
