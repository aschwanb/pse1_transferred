class AuthorHashtag < ActiveRecord::Base
  belongs_to :author
  belongs_to :hashtag
  has_one :popularity, as: :popular

 validates :author_id, :hashtag_id, presence: true

  def get_rank
    return self.popularity.get_times_used
  end

  def set_rank(number)
    self.popularity.set_times_used(number)
  end

  def get_trend_short
    return self.popularity.get_trend_short
  end

  def get_trend_long
    return self.popularity.get_trend_long
  end

  # Is this author/hashtag pair new (short term as defined in MegaUltraTweet::Application::INTERVAL_SHORT_TIME )?
  # One of the project requirements was to determine,
  # if a combination of hashtags was new or already present.
  def get_new_short?
    return self.new_short?
  end

  def set_new_short(bool)
    self.update(new_short: bool)
  end

  # Is this author/hashtag pair new (short term as defined in MegaUltraTweet::Application::INTERVAL_LONG_TIME )?
  # One of the project requirements was to determine,
  # if a combination of hashtags was new or already present.
  def get_new_long?
    return self.new_long?
  end

  def set_new_long(bool)
    self.update(new_long: bool)
  end

end
