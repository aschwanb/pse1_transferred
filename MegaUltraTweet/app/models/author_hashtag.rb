class AuthorHashtag < ActiveRecord::Base
  belongs_to :author
  belongs_to :hashtag
  has_one :popularity, as: :popular

  validates :id, :author_id, :hashtag_id, presence: true

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

  def get_new_short?
    self.new_short?
  end

  def set_new_short(bool)
    self.update(new_short: bool)
  end

  def get_new_long?
    self.new_long?
  end

  def set_new_long(bool)
    self.update(new_long: bool)
  end

end
