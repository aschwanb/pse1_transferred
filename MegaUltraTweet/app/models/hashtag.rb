class Hashtag < ActiveRecord::Base
  has_and_belongs_to_many :tweets
  has_and_belongs_to_many :startingpoints

  def get_text
    return self.text.to_s
  end

  def get_tweets
    return self.tweets.to_a
  end
end
