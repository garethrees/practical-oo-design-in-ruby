# 4.5
# Bad
class Trip
  attr_reader :mechanic, :bicycles

  def prepare_bicycles
    bicycles.each do |bike|
      mechanic.clean_bike(bike)
      mechanic.pump_tires(bike)
      mechanic.lube_chain(bike)
      mechanic.check_breaks(bike)
    end
  end

end

class Mechanic
  def clean_bike(bike); end
  def pump_tires(bike); end
  def lube_chain(bike); end
  def check_breaks(bike); end
end

# 4.6
# Good
class Trip
  attr_reader :mechanic, :bicycles

  def prepare_bicycles
    bicycles.each do |bike|
      mechanic.prepare_bike(bike)
    end
  end

end

class Mechanic

  def prepare_bike(bike)
    clean_bike(bike)
    pump_tires(bike)
    lube_chain(bike)
    check_breaks(bike)
  end

  private

  def clean_bike(bike); end
  def pump_tires(bike); end
  def lube_chain(bike); end
  def check_breaks(bike); end
end

# 4.7
# Better
class Trip

  attr_reader :bicycles, :mechanic

  def prepare
    mechanic.prepare_trip(self)
  end

end

class Mechanic

  def prepare_trip(trip)
    trip.bicycles.each do |bike|
      prepare_bicycle(bike)
    end
  end

  def prepare_bicycle(bike)
    # preppin
  end

end

trip = Trip.new(mechanic: Mechanic.new, bicycles: Bicycles.all)
trip.prepare

