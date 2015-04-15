class Webpage < ActiveRecord::Base
  belongs_to :tweet

  def get_url
    return self.url
  end

  def get_tweet
    return self.tweet
  end

  def get_title
    return self.title
  end

  def get_description
    return self.description
  end

end
