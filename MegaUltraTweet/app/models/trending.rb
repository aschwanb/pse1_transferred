class Trending < ActiveRecord::Base
has_and_belongs_to_many :hashtags

  validates :id, :created_at, :updated_at, presence: true

  def get_popular
    hashtags = self.hashtags.sort_by{ |hashtag| hashtag.get_trend_short }.reverse
    return hashtags.first(MegaUltraTweet::Application::TRENDING_HASHTAGS_NUMBER)
  end

  def get_unpopular
    hashtags = self.hashtags.sort_by{ |hashtag| hashtag.get_trend_short }.reverse
    return hashtags.last(MegaUltraTweet::Application::TRENDING_HASHTAGS_NUMBER)
  end

  def reset_hashtags
    if !self.hashtags.nil?
      self.hashtags.clear
    end
  end

  def set_hashtags(hashtags)
    Array(hashtags).each { |h| self.hashtags<<h }
  end

  def build_new
    hashtags = Hashtag.all
    hashtags = hashtags.sort_by{ |hashtag| hashtag.get_trend_short }.reverse
    top = hashtags.first(MegaUltraTweet::Application::TRENDING_HASHTAGS_NUMBER)
    bottom = hashtags.last(MegaUltraTweet::Application::TRENDING_HASHTAGS_NUMBER)
    reset_hashtags
    set_hashtags(top)
    set_hashtags(bottom)
  end

end
