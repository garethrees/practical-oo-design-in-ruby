# External Messages:
# A message sent to anything other than self

# Bad
def gear_inches
#... a few lines of scary math
foo = some_intermediate_result * wheel.diameter #... more lines of scary math
end

# Better
def gear_inches
#... a few lines of scary math
foo = some_intermediate_result * diameter #... more lines of scary math
end

def diameter # preemptively create to remove dependency from other methods
  wheel.diameter
end
