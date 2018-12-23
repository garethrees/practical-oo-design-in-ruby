# Original; Chapter 6
class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(args = {})
    @size = args[:size]
    @chain = args[:chain] || default_chain
    @tire_size = args[:tire_size] || default_tire_size

    post_initialize(args)
  end

  def spares
    { tire_size: tire_size,
      chain:     chain }.merge(local_spares)
  end

  def default_tire_size
    raise NotImplementedError,
          "This #{self.class} cannot respond to: default_tire_size"
  end

  def post_initialize(args)
    nil
  end

  def local_spares
    {}
  end

  def default_chain
    '10-speed'
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def post_initialize(args)
    @tape_color = args[:tape_color]
  end

  def local_spares
    { tape_color: tape_color }
  end

  def default_tire_size
    '23'
  end
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  def post_initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
  end

  def local_spares
    { rear_shock: rear_shock }
  end

  def default_tire_size
    '2.1'
  end
end

# ---

# 8.2
class Parts
  attr_reader :chain, :tire_size

  def initialize(args = {})
    @chain = args[:chain] || default_chain
    @tire_size = args[:tire_size] || default_tire_size
    post_initialize(args)
  end

  def spares
    { tire_size: tire_size,
      chain:     chain }.merge(local_spares)
  end

  def default_tire_size
    raise NotImplementedError,
          "This #{self.class} cannot respond to: default_tire_size"
  end

  def post_initialize(args)
    nil
  end

  def local_spares
    {}
  end

  def default_chain
    '10-speed'
  end
end

class RoadBikeParts < Parts
  attr_reader :tape_color

  def post_initialize(args)
    @tape_color = args[:tape_color]
  end

  def local_spares
    { tape_color: tape_color }
  end

  def default_tire_size
    '23'
  end
end

class MountainBikeParts < Parts
  attr_reader :front_shock, :rear_shock

  def post_initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
  end

  def local_spares
    { rear_shock: rear_shock }
  end

  def default_tire_size
    '2.1'
  end
end

class Bicycle
  attr_reader :size, :parts

  def initialize(args = {})
    @size = args[:size]
    @parts = args[:parts]
  end

  def spares
    parts.spares
  end
end

# Without reading ahead

class Parts
  attr_reader :parts

  def initialize(*args)
    @parts = args
  end

  def spares
    parts.select(&:needs_spare?)
  end
end

class Part
  def needs_spare?
    false
  end
end

class FrontShock < Part
  def needs_spare?
    true
  end
end

# ---

# 8.4

class Bicycle
  attr_reader :size, :parts

  def initialize(args = {})
    @size = args[:size]
    @sparts = args[:parts]
  end

  def spares
    parts.spares
  end
end

class Parts
  attr_reader :parts

  def initialize(parts)
    @parts = parts
  end

  def spares
    parts.select { |part| part.needs_spare }
  end
end

class Part
  attr_reader :name, :description, :needs_spare

  def initialize(args)
    @name = args[:name]
    @description = args[:description]
    @needs_spare = args.fetch(:needs_spare, true)
  end
end

chain = Part.new(name: 'chain', description: '10-speed')
road_bike_parts = Parts.new([chain, road_tire, tape])

# p175

require 'forwardable'
class Parts
  extend Forwardable
  def_delegators :@parts, :size, :each

  include Enumerable

  def initialize(parts)
    @parts = parts
  end

  def spares
    select { |part| part.needs_spare }
  end
end

# p176 – Parts Factory

road_config =
  [['chain',        '10-speed'],
   ['tire_size',    '23'],
   ['tape_color',   'red']]

mountain_config =
  [['chain',        '10-speed'],
   ['tire_size',    '2.1'],
   ['front_shock',  'Manitou', false],
   ['rear_shock',   'Fox']]


module PartsFactory
  def self.build(config, part_class = Part, parts_class = Parts)
    parts = config.map do |part_config|
      part_class.new(name: part_config[0],
                     description: part_config[1],
                     needs_spare: part_config.fetch(2, true))
    end
 
    parts_class.new(parts)
  end
end

# Complete composed bicycle
class Bicycle
  attr_reader :size, :parts

  def initialize(args = {})
    @size = args[:size]
    @parts = args[:parts]
  end

  def spares
    parts.spares
  end
end

require 'forwardable'
class Parts
  extend Forwardable
  def_delegators :@parts, :size, :each

  include Enumerable

  def initialize(parts)
    @parts = parts
  end

  def spares
    select { |part| part.needs_spare }
  end
end

require 'ostruct'
module PartsFactory
  def self.build(config, parts_class = Parts)
    parts = config.map { |part_config| create_part(part_config) }
    parts_class.new(parts)
  end

  def self.create_part(part_config)
    OpenStruct.new(name: part_config[0],
                   description: part_config[1],
                   needs_spare: part_config.fetch(2, true))
  end
end

road_config =
  [['chain',        '10-speed'],
   ['tire_size',    '23'],
   ['tape_color',   'red']]

mountain_config =
  [['chain',        '10-speed'],
   ['tire_size',    '2.1'],
   ['front_shock',  'Manitou', false],
   ['rear_shock',   'Fox']]

road_bike = Bicycle.new(size: 'L', parts: PartsFactory.build(road_config))

# How I'd write this
class Bicycle
  attr_reader :size, :parts

  def initialize(args = {})
    @size = args[:size]
    @parts = args[:parts]
  end

  def spares
    parts.spares
  end
end

require 'ostruct'
module PartsFactory
  def build(config, parts_class = self)
    parts = config.map { |part_config| create_part(part_config) }
    parts_class.new(parts)
  end

  def create_part(part_config)
    OpenStruct.new(name: part_config[0],
                   description: part_config[1],
                   needs_spare: part_config.fetch(2, true))
  end
end

require 'forwardable'
class PartsCollection
  extend PartsFactory
  extend Forwardable
  include Enumerable

  DEFAULT_CONFIGS = {
    road_config: [['chain',        '10-speed'],
                  ['tire_size',    '23'],
                  ['tape_color',   'red']],
    mountain_config: [['chain',        '10-speed'],
                      ['tire_size',    '2.1'],
                      ['front_shock',  'Manitou', false],
                      ['rear_shock',   'Fox']]
  }

  def_delegators :@parts, :size, :each

  def self.build_from_default(parts_config)
    build(DEFAULT_CONFIGS[parts_config])
  end

  def initialize(parts)
    @parts = parts
  end

  def spares
    select { |part| part.needs_spare }
  end
end

road_bike = Bicycle.new(size: 'L', parts: PartsCollection.build_from_default(:road_config))

recumbent_config =
        [['chain',        '9-speed'],
         ['tire_size',    '28'],
         ['flag',         'tall and orange']]

recumbent_bike = Bicycle.new(size: 'L', parts: PartsCollection.build(recumbent_config))

# p188
# is-a:           Inheritance
# behaves-like-a: Duck Types
# has-a:          Composition
