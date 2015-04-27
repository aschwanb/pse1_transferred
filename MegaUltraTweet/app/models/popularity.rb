class Popularity < ActiveRecord::Base
  belongs_to :popular, polymorphic: true
  serialize :times_used, Array

  @short_interval = 1 # Number of elements in one interval
  @long_interval = 20 # Number of elements in one interval

  # Newest times_used is always at index 0
  # Use unshift to guarantee this
  def get_times_used
    self.times_used[0]
  end

  def set_times_used(usage)
    self.times_used[0] = usage
    self.save
  end

  def get_trend_short
    # TODO: Fix nil values
    current = self.times_used[0, 1]  # 10 being the length of the intervall
    old = self.times_used[0+1, 1]     # Starting Point and Length
    if old.nil?
      return current.inject(:+)
    else
      return current.inject(:+) - old.inject(:+)
    end
  end

  def get_trend_long
    # TODO: What to do if interval is not jet full ?
    current = self.times_used[0, 10]  # 10 being the length of the intervall
    old = self.times_used[0+ 10, 10]     # Starting Point and Length
    if old.nil?
      return current.inject(:+)
    else
      return current.inject(:+) - old.inject(:+)
    end
  end

  # Add new times_used entry
  def rollover
    self.times_used.unshift(0)
    self.save
  end

  # Delete oldest times_used entry
  def delete_oldest
    self.times_used.pop
    self.save
  end

end
