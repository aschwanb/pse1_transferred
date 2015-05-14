class HashtagHashtag < ActiveRecord::Base
  belongs_to :hashtag_first, class_name: :Hashtag, foreign_key: :hashtag_first_id
  belongs_to :hashtag_second, class_name: :Hashtag, foreign_key: :hashtag_second_id
  has_one :popularity, as: :popular

  validates :hashtag_first_id, :hashtag_second_id, presence: true

  def get_rank
    self.popularity.get_times_used
  end

  def set_rank(number)
    self.popularity.set_times_used(number)
  end

  def get_trend_short
    self.popularity.get_trend_short
  end

  def get_trend_long
    self.popularity.get_trend_long
  end

  # TODO: Comment this!
  def get_new_short?
    self.new_short?
  end

  # TODO: Comment this!
  def set_new_short(bool)
    self.update(new_short: bool)
  end

  # TODO: Comment this!
  def get_new_long?
    self.new_long?
  end

  # TODO: Comment this!
  def set_new_long(bool)
    self.update(new_long: bool)
  end

end