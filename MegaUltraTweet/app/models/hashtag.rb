class Hashtag < ActiveRecord::Base
  has_and_belongs_to_many :tweets
  has_and_belongs_to_many :startingpoints

  scope :by_hashtag, -> (hashtag) { where text: hashtag}

  def get_text
    return self.text.to_s
  end

  def get_tweets(*args)
    return self.tweets.to_a if args.size > 1 || args.size < 1
    return self.tweets.take(args[0]).to_a
  end
end
