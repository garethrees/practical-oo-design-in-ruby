# 4.8
class Customer
  attr_reader :trip_date, :skill_level, :need_bike

  def initialize(args)
    @trip_date   = args[:trip_date]
    @skill_level = args[:skill_level]
    @need_bike   = args[:need_bike]
  end
end

class TripFinder
  def suitable_trips(customer)
    trips = Trip.suitable_trips(customer.trip_date, customer.skill_level)

    if customer.need_bike
      trips.select do |trip|
        Bicycle.suitable_bicycle(trip.trip_date, trip.route_type)
      end
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

tripfinder = TripFinder.new
moe = Customer.new(trip_date: Date.today, skill_level: 'M', need_bike: true)
trip_finder.suitable_trips(moe)


