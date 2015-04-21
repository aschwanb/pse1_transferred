class AuthorHashtagPair < ActiveRecord::Base
  has_and_belongs_to_many :authors
  has_and_belongs_to_many :hashtags
  has_one :popularity, as: :popular

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
    self.popularity.update(now: popularity)
  end

  def set_popularity_old_1(popularity)
    self.popularity.update(old_1: popularity)
  end

  def set_popularity_old_2(popularity)
    self.popularity.update(old_2: popularity)
  end

  def set_popularity_old_3(popularity)
    self.popularity.update(old_3: popularity)
  end
end
