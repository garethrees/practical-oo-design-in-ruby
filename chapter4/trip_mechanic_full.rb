# 4.7
# Better
module Sputs
  def sputs(msg)
    puts "#{ self }: #{ msg }"
  end
end

class Bicycle
  def self.all
    3.times.map { |_| new }
  end
end

class Trip
  attr_reader :bicycles, :preparer

  def initialize(bicycles:, preparer:)
    @bicycles = bicycles
    @preparer = preparer
  end

  def prepare
    preparer.prepare_trip(self)
  end
end

class Mechanic
  include Sputs

  def prepare_trip(trip)
    sputs "Preparing #{trip}"
    prepared_bikes = bicycles(trip).map do |bike|
      prepare_bicycle(bike)
    end

    sputs 'Here they are!'
    prepared_bikes
  end

  private

  def bicycles(trip)
    sputs 'OK. Gimme ur bikes!'
    trip.bicycles
  end

  def prepare_bicycle(bike)
    sputs "Preppin' #{bike}"
    bike
  end

end

class Cowboy
  include Sputs

  def prepare_trip(trip)
    sputs "Preparing #{trip}"
    sputs "Yeah whatever, have your bikes"
    trip.bicycles
  end
end

puts "WITH MECHANIC:"
trip = Trip.new(preparer: Mechanic.new, bicycles: Bicycle.all)
puts trip.prepare

puts "\nWITH COWBOY:"
trip = Trip.new(preparer: Cowboy.new, bicycles: Bicycle.all)
puts trip.prepare

