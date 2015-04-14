class Hashtag < ActiveRecord::Base
  has_and_belongs_to_many :tweets
  has_and_belongs_to_many :startingpoints

  # TODO: Add has many for hashtag pairs ?
  # has_many :hashtag_pairs, :as => :hashtag_first
  # has_many :hashtag_pairs, :as => :hashtag_second

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
