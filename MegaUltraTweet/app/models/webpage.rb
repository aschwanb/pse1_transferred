class Webpage < ActiveRecord::Base
  belongs_to :tweet

  def get_url
    return self.url
  end

  def get_tweet
    return self.tweet
  end
end
