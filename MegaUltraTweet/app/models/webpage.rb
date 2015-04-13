class Webpage < ActiveRecord::Base
  belongs_to :tweet

  def get_url
    return self.url
  end

  def get_tweet
    return self.tweet
  end

  def get_title
    # TODO
  end

  def get_description
    # TODO
  end
  # TODO use link_thumbnailer to write title and descrption to webpage
end
