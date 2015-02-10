class Gear
  attr_reader :chainring, :cog

  def initialize(chainring, cog)
    @chainring = chainring
    @cog = cog
  end

  def ratio
    chainring / cog.to_f
  end
end

puts Gear.new(52, 11).ratio
puts Gear.new(30, 27).ratio

class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim, @tire = rim, tire
  end

end

class Bicycle
  attr_reader :gear, :wheel
  
  def initialize(gear, wheel)
    @gear, @wheel = gear, wheel
  end

  def gear_inches
    gear.ratio * (wheel.rim + (wheel.tire * 2))
  end

end

gear = Gear.new(52, 11)
wheel = Wheel.new(26, 1.5)

puts Bicycle.new(gear, wheel).gear_inches