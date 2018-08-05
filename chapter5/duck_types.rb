# 5.1
class Trip
  attr_reader :bicycles, :customers, :vehicle

  def prepare(mechanic)
    mechanic.prepare_bicycles(bicycles)
  end
end

class Mechanic
  def prepare_bicycles(bicycles)
    bicycles.each { |bicycle| prepare_bicycle(bicycle) }
  end

  def prepare_bicycle(bicycle)
    # ...
  end

end

# 5.3
class Trip
  attr_reader :bicycles, :customers, :vehicle

  def prepare(preparers)
    preparers.each do |preparer|
      case preparer
      when Mechanic
        preparer.prepare_bicycles(bicycles)
      when TripCoordinator
        preparer.buy_food(customers)
      when Driver
        preparer.gas_up(vehicle)
        preparer.fill_water_tank(vehicle)
      end
    end
  end
end

class TripCoordinator
  def buy_food(customers)
    # ...
  end
end

class Driver
  def gas_up(vehicle)
    # ...
  end

  def fill_water_tank(vehicle)
    # ...
  end
end

# 5.4
class Trip
  attr_reader :bicycles, :customers, :vehicle

  def prepare(preparers)
    preparers.each { |preparer| preparer.prepare_trip(self) }
  end
end

class Mechanic
  def prepare_trip(trip)
    trip.bicycles.each do |bicycle|
      prepare_bicycle(bicycle)
    end
  end
end

class TripCoordinator
  def prepare_trip(trip)
    buy_food(trip.customers)
  end
end

class Driver
  def prepare_trip(trip)
    vehicle = trip.vehicle
    gas_up(vehicle)
    fill_water_tank(vehicle)
  end
end

# Recognising Ducks

# case blah when SomeClass
# kind_of?
# is_a?
# responds_to?
