class Wheel

  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim, @tire = rim, tire
  end

  def diameter
    rim + (tire * 2)
  end

end

# Hard Coupling
# ==============================================================================

# Gear.new(52, 11, 26, 1.5).gear_inches
class Gear

  # Change: `:rim` and `:tire` may change with a change to Wheel
  attr_reader :chainring, :cog, :rim, :tire

  # Change: `:rim` and `:tire` may change with a change to Wheel
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog       = cog
    # Change: `:rim` and `:tire` may change with a change to Wheel
    @rim       = rim
    @tire      = tire
  end

  # Change: method may change if message to obtain diameter changes
  def gear_inches
    # Dependency: Name of Wheel class. What if it changes or you want a
    #             different type of wheel?
    # Dependency: Name of message to send to the Wheel instance (`diameter`)
    # Dependency: The arguments that the messages (`#new`, `#diameter`) require
    # Dependency: The order of the arguments
    ratio * Wheel.new(rim, tire).diameter
  end

  def ratio
    chainring / cog.to_f
  end

end

# Loose Coupling
# ==============================================================================

# Gear.new(52, 11, Wheel.new(26, 1.5)).gear_inches
class Gear

  attr_reader :chainring, :cog, :wheel

  def initialize(chainring, cog, wheel)
    @chainring = chainring
    @cog       = cog
    @wheel     = wheel
  end

  def gear_inches
    ratio * wheel.diameter
  end

  def ratio
    chainring / cog.to_f
  end

end
