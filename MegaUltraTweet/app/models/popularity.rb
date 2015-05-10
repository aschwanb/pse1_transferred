class Popularity < ActiveRecord::Base
  belongs_to :popular, polymorphic: true
  serialize :times_used, Array

  # TODO: Validation fails if standard Object.create function is used.
  # Fix validation to validate after creation before inserting into db?
  # validates :id, :popular_id, :popular_type, :times_used, :created_at, :updated_at, presence: true

  def get_times_used
    self.times_used[0]
  end

  def set_times_used(usage)
    self.times_used[0] = usage
    self.save
  end

  # TODO: comment on time interval
  def get_trend_short
    return self.get_trend(MegaUltraTweet::Application::POPULARITY_SHORT_INTERVAL)
  end

  # TODO: comment on time interval
  def get_trend_long
    return self.get_trend(MegaUltraTweet::Application::POPULARITY_LONG_INTERVAL)
  end

  def get_trend(interval)
    current = self.times_used[0, interval] # Starting Point and Length
    old = self.times_used[0+interval, interval]

    if !old.nil? && old.any?
      return current.inject(:+) - old.inject(:+)
    else
      return current.inject(:+)
    end
  end

  # Newest times_used is always at index 0
  # Use unshift to guarantee this
  def add_new
    self.times_used.unshift(0)
    self.save
  end

  def delete_oldest
    self.times_used.pop
    self.save
  end

end
