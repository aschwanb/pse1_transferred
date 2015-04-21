class HashtagPair < ActiveRecord::Base
  has_one :popularity, as: :popular

  belongs_to :hashtag_first, class_name: :Hashtag, foreign_key: :hashtag_first_id
  belongs_to :hashtag_second, class_name: :Hashtag, foreign_key: :hashtag_second_id

  def get_popularity_now
    return self.popularity.now
  end

  def get_popularity_old_1
    return self.popularity.old_1
  end

  def get_popularity_old_2
    return self.popularity.old_2
  end

  def get_popularity_old_3
    return self.popularity.old_3
  end

  def set_popularity_now(popularity)
    self.popularity.now = popularity
  end

  def set_popularity_old1(popularity)
    self.popularity.old_1 = popularity
  end

  def set_popularity_old2(popularity)
    self.popularity.old_2 = popularity
  end

  def set_popularity_old3(popularity)
    self.popularity.old_3 = popularity
  end


end