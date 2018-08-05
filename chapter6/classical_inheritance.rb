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


# 6.2
# Bad
class Bicycle
  attr_reader :style, :size, :tape_color, :front_shock, :rear_shock

  def initialize(args)
    @type = args[:style]
    @size = args[:size]
    @tape_color = args[:tape_color]
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
  end

  # checking "style" starts down a slippery slope
  def spares
    if style == :road
      { chain: '10-speed',
        tire_size: '23', # mm
        tape_color: tape_color }
    else
      { chain: '10-speed',
        tire_size: '2.1', # inch
        rear_shock: rear_shock }
    end
  end
end

bike = Bicycle.new(style: :mountain,
                   size: 'S',
                   front_shock:  'Manitou',
                   rear_shock:   'Fox')
bike.spares
# -> {:tire_size   => "2.1",
#     :chain       => "10-speed",
#     :rear_shock  => 'Fox'}
