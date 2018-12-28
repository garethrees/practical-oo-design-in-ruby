# Tests:
# * Find bugs
# * Supply documentation
# * Defer design decisions (test interface; refactor implementation later)
# * Support absractions (test interactions between components)
# * Expose design flaws

# Query: test of state
# Command: test of behaviour

# Incoming messages should be tested for the state they return
# Outgoing command messages should be tested to ensure they get sent
# Outgoing query messages should not be tested

# BDD: Outside in testing
# TDD: Inside out testing

# When the application code can only be written one way, mirroring that
# arrangement is often the most effective way to write tests.

# stub: implements a method on an object that returns a canned answer
# mock: defines an expectation that a message will get sent

# Roles need tests of their own – share tests for duck-type interface. Treat
# test doubles as you would any other role player and test them to prove their
# correctness.

# If your object has so many private methods that you dare not leave them
# untested, consider extracting the methods into new object. The extracted
# methods form the core of the responsibilities of the new object and so make
# up its public interface – providing the interface is indeed stable.

# Testing abstract superclass: Manufacture a testable instance of the superclass
# by creating a new subclass for use solely by the test.

class StubbedBike < Bicycle
  def default_tire_size
    0
  end

  def local_spares
    { saddle: 'painful' }
  end
end

class BicycleTest < MiniTest::Unit::TestCase include BicycleInterfaceTest
  def setup
    @stubbed_bike = StubbedBike.new
  end

  # Includes subclass contributions to the spares list
  def test_includes_local_spares_in_spares
    assert_equal @stubbed_bike.spares, { tire_size: 0,
                                         chain: '10-speed',
                                         saddle: 'painful' }
end

# Prove the test double honors the interface expected by a Bicycle subclass
class StubbedBikeTest < MiniTest::Unit::TestCase
  include BicycleSubclassTest

  def setup
    @object = StubbedBike.new
  end
end


