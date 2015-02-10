class Gear
 
  attr_reader :chainring, :cog, :rim, :tire
 
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog       = cog
    @rim       = rim
    @tire      = tire
  end
 
  def ratio
    chainring / cog.to_f
  end
 
  def gear_inches
    ratio * (rim + (tire * 2))
  end
 
end

# Use a Struct to provide a better interface to Wheel information
class Gear
 
  attr_reader :chainring, :cog, :wheel
 
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog       = cog
    @wheel     = wheelify(rim, tire)
  end
 
  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    ratio * (wheel.rim + (wheel.tire * 2))
  end

  Wheel = Struct.new(:rim, :tire)
  def wheelify(rim, tire)
    Wheel.new(rim, tire) }
  end

end

# Encapsulate Wheel behaviour in a Struct
#
# We can now send messages to `@wheel` without changing the interface to Gear
# Can also abstract Wheel to a class if/when necessary
class Gear

  attr_reader :chainring, :cog, :wheel

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog       = cog
    @wheel     = Wheel.new(rim, tire)
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    ratio * wheel.diameter
  end

  Wheel = Struct.new(:rim, :tire) do
    def diameter
      rim + (tire * 2)
    end
  end

end
