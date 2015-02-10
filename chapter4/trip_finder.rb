# 4.3
class Customer
  def trips
    Trip.suitable_trips(on_date, of_difficulty, need_bike)
  end
end

class Trip
  def self.suitable_trips(on_date, of_difficulty, need_bike)
    # ...
  end
end

moe = Customer.new
moe.trips

# 4.4
class Customer
  def trips
    trips = Trip.suitable_trip(on_date, of_difficulty).each do |trip|
    trips.each do |trip|
      Bike.suitable_bicycle(trip.date, trip.difficulty)
    end
  end
end

class Trip
  def self.suitable_trip(on_date, of_difficulty)
    # ...
  end
end

class Bicycle
  def self.suitable_bicycle(trip_date, route_type)
    # ...
  end
end

moe = Customer.new
moe.trips

# 4.8
class Customer
  attr_reader :trip_date, :skill_level, :need_bike

  def initialize(args)
    @trip_date   = args[:trip_date]
    @skill_level = args[:skill_level]
    @need_bike   = args[:need_bike]
    @tripfinder  = args[:tripfinder]
  end

  def trips
    tripfinder.suitable_trips(on_date, of_difficulty, need_bike)
  end
end

class TripFinder
  def suitable_trips(on_date, of_difficulty, need_bike)
    Trip.suitable_trips(on_date, of_difficulty).select do |trip|
      Bicycle.suitable_bicycle(trip.date, trip.route_type)
    end
  end
end

class Trip
  def self.suitable_trip(on_date, of_difficulty)
    # ...
  end
end

class Bicycle
  def self.suitable_bicycle(trip_date, route_type)
    # ...
  end
end

tripfinder = Tripfinder.new
moe = Customer.new(tripfinder: tripfinder)
moe.trips

