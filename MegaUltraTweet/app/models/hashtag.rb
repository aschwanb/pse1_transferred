class Hashtag < ActiveRecord::Base
  has_and_belongs_to_many :tweets
  has_and_belongs_to_many :startingpoints
  has_and_belongs_to_many :author_hashtag_pairs
  has_one :popularity, as: :popular

  # For hashtag pairs
  has_many :hashtag_pairs_first, class_name: :HashtagPair, foreign_key: :hashtag_first_id
  has_many :hashtag_pairs_second, class_name: :HashtagPair, foreign_key: :hashtag_second_id

  scope :by_hashtag, -> (hashtag) { where text: hashtag}

  def get_text
    return self.text.to_s
  end

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

  def get_tweets(*args)
    return self.tweets.to_a if args.size > 1 || args.size < 1
    return self.tweets.take(args[0]).to_a
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
