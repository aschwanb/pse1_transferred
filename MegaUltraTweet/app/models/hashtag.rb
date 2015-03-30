class Hashtag < ActiveRecord::Base
  has_and_belongs_to_many :tweets
  has_and_belongs_to_many :startingpoints

  def getText
    return self.text.to_s
  end

  def getTweets
    return self.tweets.to_a
  end
end
