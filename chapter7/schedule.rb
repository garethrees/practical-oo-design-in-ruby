# 7.1
class Schedule
  def scheduled?(target, starting, ending)
  end

  def add(target, starting, ending)
  end

  def remove(target, starting, ending)
  end

  def schedulable?(target, starting, ending)
    lead_days =
      case target
      when Bicycle then 1
      when Mechanic then 4
      when Vehicle then 3
      end

    !scheduled?(target, starting + lead_days, ending)
  end
end

# 7.2
class Schedule
  def scheduled?(target, starting, ending)
  end

  def add(target, starting, ending)
  end

  def remove(target, starting, ending)
  end

  def schedulable?(target, starting, ending)
    !scheduled?(target, starting + target.lead_days, ending)
  end
end

# Improvement without reading ahead
class Schedule
  def scheduled?(target, starting, ending)
  end

  def add(target, starting, ending)
  end

  def remove(target, starting, ending)
  end

  def schedulable?(target, starting, ending)
    target.schedulable(starting, ending)
  end
end

class Foo
  def lead_days
    3
  end

  def schedulable?(starting, ending)
    # ? starting - lead_days
  end
end

module Scheduleable
  def lead_days
    raise NotImplementedError
  end

  def schedulable?(starting, ending)
    # ?
  end
end

# ---

# p148
class Schedule
  def scheduled?(schedulable, start_date, end_date)
    puts "Nope"
    false
  end
end

class Bicycle
  attr_reader :schedule

  def initialize(args = {})
    @schedule = args[:schedule] || Schedule.new
  end

  def schedulable?(start_date, end_date)
    !scheduled?(start_date - lead_days, end_date)
  end

  def scheduled?(start_date, end_date)
    schedule.scheduled?(self, start_date, end_date)
  end

  def lead_days
    1
  end
end

# p150 – extracting Scheduleable

module Scheduleable
  attr_writer :schedule

  def schedule
    @schedule ||= ::Schedule.new
  end

  def schedulable?(start_date, end_date)
    !scheduled?(start_date - lead_days, end_date)
  end

  def scheduled?(start_date, end_date)
    schedule.scheduled?(self, start_date, end_date)
  end

  # includers may override
  def lead_days
    0
  end
end

class Bicycle
  include Scheduleable

  def lead_days
    1
  end
end

class Mechanic
  include Scheduleable

  def lead_days
    4
  end
end

































