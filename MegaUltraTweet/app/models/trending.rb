class Trending < ActiveRecord::Base
has_and_belongs_to_many :hashtags

  def get_popular
    # TODO
  end

  def get_unpopular
    # TODO
  end

  def reset_hashtags
    self.hashtags.clear
  end

  def set_hashtags(hashtags)
    Array(hashtags).each { |h| self.hashtags<<h }
  end

  def build_new
    hashtags = Hashtag.all
    hashtags = hashtags.sort_by{ |hashtag| hashtag.get_trend_short }.reverse
    # TODO: Move number to config file
    top = hashtags.first(10)
    bottom = hashtags.last(10)
    @trending.reset_hashtags
    @trending.set_hashtags(top)
    @trending.set_hashtags(bottom)
  end

end
