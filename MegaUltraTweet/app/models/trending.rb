class Trending < ActiveRecord::Base
has_and_belongs_to_many :hashtags

  # TODO: Find a better solution for trending hashtags long/short
  def set_hashtags(hashtags)
    Array(hashtags).each { |h| self.hashtags<<h }
  end

  def reset_hashtags
    if !self.hashtags.nil?
      self.hashtags.clear
    end
  end

# TODO: Comment on time interval
  def get_popular_short
  validates :id, :created_at, :updated_at, presence: true

  def get_popular
    hashtags = self.hashtags.sort_by{ |hashtag| hashtag.get_trend_short }.reverse
    return hashtags.first(MegaUltraTweet::Application::TRENDING_HASHTAGS_NUMBER)
  end

  def get_unpopular_short
    hashtags = self.hashtags.sort_by{ |hashtag| hashtag.get_trend_short }.reverse
    return hashtags.last(MegaUltraTweet::Application::TRENDING_HASHTAGS_NUMBER)
  end

  def build_new_short
    hashtags = Hashtag.all
    hashtags = hashtags.sort_by{ |hashtag| hashtag.get_trend_short }.reverse
    top = hashtags.first(MegaUltraTweet::Application::TRENDING_HASHTAGS_NUMBER)
    bottom = hashtags.last(MegaUltraTweet::Application::TRENDING_HASHTAGS_NUMBER)
    reset_hashtags
    set_hashtags(top)
    set_hashtags(bottom)
  end

  def get_popular_long
    hashtags = self.hashtags.sort_by{ |hashtag| hashtag.get_trend_long }.reverse
    return hashtags.first(MegaUltraTweet::Application::TRENDING_HASHTAGS_NUMBER)
  end

  def get_unpopular_long
    hashtags = self.hashtags.sort_by{ |hashtag| hashtag.get_trend_long }.reverse
    return hashtags.last(MegaUltraTweet::Application::TRENDING_HASHTAGS_NUMBER)
  end

  def build_new_long
    hashtags = Hashtag.all
    hashtags = hashtags.sort_by{ |hashtag| hashtag.get_trend_long }.reverse
    top = hashtags.first(MegaUltraTweet::Application::TRENDING_HASHTAGS_NUMBER)
    bottom = hashtags.last(MegaUltraTweet::Application::TRENDING_HASHTAGS_NUMBER)
    reset_hashtags
    set_hashtags(top)
    set_hashtags(bottom)
  end

end
