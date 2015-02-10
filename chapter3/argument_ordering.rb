# Bad
# Gear.new(52,11,Wheel.new(26, 1.5))
class Gear
  def initialize(chainring, cog, wheel)
    @chainring = chainring
    @cog       = cog
    @wheel     = wheel
  end
end

# Good
# Gear.new(chainring: 52, cog: 11, wheel: Wheel.new(26, 1.5))
class Gear
  def initialize(args)
    @chainring = args[:chainring]
    @cog       = args[:cog]
    @wheel     = args[:wheel]
  end
end

# Flexible
class Widget
  def initialize(required, optional = {})
    @required = required
    @option1  = optional[:option1]
    @option2  = optional[:option2]
  end
end

# Defaults
class Widget
  def initialize(required, optional = {})
    @required = required
    @option1  = optional.fetch(:option1, 'default_value')
    @option2  = optional[:option2] # No default
  end
end

# Isolated Defaults
class Widget
  def initialize(args)
    args = defaults.merge(args)
    @chainring = args[:chainring]
  end

  def defaults
    { chainring: 40, cog: 18 }
  end
end


# Factories

# When Gear is part of an external interface
module SomeFramework
  class Gear
    attr_reader :chainring, :cog, :wheel

    def initialize(chainring, cog, wheel)
      @chainring = chainring
      @cog       = cog
      @wheel     = wheel
    end
  end
end

# GearWrapper.gear(chainring: 52, cog: 11, wheel: Wheel.new(26, 1.5))
# => Gear
module GearWrapper
  def self.gear(args)
    SomeFramework::Gear.new(args[:chainring], args[:cog], args[:wheel])
  end
end


