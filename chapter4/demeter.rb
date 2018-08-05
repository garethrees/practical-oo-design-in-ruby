# Bad
def depart
  customer.bicycle.wheel.rotate
end

# Good
def depart
  customer.ride
end

class Customer
  def ride
    bicycle.propel
  end
end

class Bicycle
  def propel
    wheel.rotate
  end
end

# Later
class Customer
  def depart
    bicycle.try(:ride) || walk
  end
end
