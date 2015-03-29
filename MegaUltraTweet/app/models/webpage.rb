class Webpage < ActiveRecord::Base
  belongs_to :tweet

  def getUrl
    return self.url
  end

  def getTweet
    return self.tweet
  end
end
