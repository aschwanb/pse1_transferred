class Hashtag < ActiveRecord::Base
  has_and_belongs_to_many :tweets
  has_and_belongs_to_many :startingpoints

  # For hashtag pairs
  has_many :hashtag_pairs_first, class_name: :HashtagPair, foreign_key: :hashtag_first_id
  has_many :hashtag_pairs_second, class_name: :HashtagPair, foreign_key: :hashtag_second_id

  scope :by_hashtag, -> (hashtag) { where text: hashtag}

  def get_text
    return self.text.to_s
  end

  def get_popularity_now
    return self.popularity_now
  end

  def get_popularity_old
    return self.populairity_old
  end

  def get_tweets(*args)
    return self.tweets.to_a if args.size > 1 || args.size < 1
    return self.tweets.take(args[0]).to_a
  end

  def set_popularity_now(popularity)
    self.popularity_now = popularity
  end

  def set_popularity_old(popularity)
    self.populairity_old = popularity
  end


end
