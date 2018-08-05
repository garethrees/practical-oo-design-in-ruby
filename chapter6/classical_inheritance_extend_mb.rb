# 6.1
class Bicycle
  attr_reader :size, :tape_color

  def initialize(args)
    @size       = args[:size]
    @tape_color = args[:tape_color]
  end

  # Every bike has the same defatils for tire and chain size
  def spares
    { chain:      '10-speed',
      tire_size:  '23',
      tape_color: tape_color }
  end

end

bike = Bicycle.new(size: 'M', tape_color: 'red')
bike.size # => 'M'
bike.spares
# => { :tire_size  => '23',
#      :chain      => '10-speed',
#      :tape_color => 'red' }

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  def initialize(args)
   @front_shock = args[:front_shock]
   @rear_shock = args[:rear_shock]
   super(args)
  end

  # Every bike has the same defatils for tire and chain size
  def spares
    { chain:      '10-speed',
      tire_size:  '2.1',
      front_shock: front_shock,
      rear_shock: rear_shock }
  end

end

class RoadBike < Bicycle
  # Every bike has the same defatils for tire and chain size
  def spares
    { chain:      '10-speed',
      tire_size:  '23',
      tape_color: tape_color }
  end

end
