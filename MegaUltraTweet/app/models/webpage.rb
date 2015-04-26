class Webpage < ActiveRecord::Base
  has_and_belongs_to_many :tweets

  def get_url
    return self.url
  end

  def get_tweets
    return self.tweets
  end

  def get_title
    return self.title
  end

  def get_description
    return self.description
  end

end
