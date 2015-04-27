class Popularity < ActiveRecord::Base
  belongs_to :popular, polymorphic: true
  serialize :times_used, Array

  def get_times_used
    self.times_used[0]
  end

  def set_times_used(usage)
    self.times_used[0] = usage
    self.save
  end

  def get_trend_short
    # TODO: Read interval length from config file
    return self.get_trend(1)
  end

  def get_trend_long
    # TODO: Read interval length from config file
    return self.get_trend(10)
  end

  def get_trend(interval)
    current = self.times_used[0, interval]  # Starting Point and Length
    old = self.times_used[0+interval, interval]
    if old.nil?
      return current.inject(:+)
    else
      return current.inject(:+) - old.inject(:+)
    end
  end

  # Newest times_used is always at index 0
  # Use unshift to guarantee this
  def add_new
    self.times_used.unshift(0)
    self.save
  end

  # Delete oldest times_used entry
  def delete_oldest
    self.times_used.pop
    self.save
  end

end
