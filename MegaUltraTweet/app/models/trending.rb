class Trending < ActiveRecord::Base
has_and_belongs_to_many :hashtags

  def set_hashtags(hashtags)
    Array(hashtags).each { |h| self.hashtags<<h }
  end

  def reset_hashtags
    if !self.hashtags.nil?
      self.hashtags.clear
    end
  end

  def get_hashtags_with_tweets(hashtag_array)
    Array(hashtag_array).each do |hashtag|
      if !hashtag.get_tweets.any?
        hashtag_array.delete(hashtag)
      end
    end
    return hashtag_array
  end

# Short and long intervals are defined in MegaUltraTweet::Application
# The short/long functions are similar but take advantage of the different intervals
# It is recommended to use two different objects for the two intervals (see seeds.rb)
# TODO: This could be solved more elegantly
  def get_popular_short
    hashtags = self.hashtags.sort_by{ |hashtag| hashtag.get_trend_short }.reverse
    return hashtags.first(MegaUltraTweet::Application::TRENDING_HASHTAGS_NUMBER)
  end

  def get_unpopular_short
    hashtags = self.hashtags.sort_by{ |hashtag| hashtag.get_trend_short }.reverse
    return hashtags.last(MegaUltraTweet::Application::TRENDING_HASHTAGS_NUMBER)
  end

  # Clear hashtags for this object and at the ones that have been used the most/least in the given interval: short
  # Hashtags are only added if they have tweets. (Relevant for small databases)
  def build_new_short
    hashtags = self.get_hashtags_with_tweets(Hashtag.all)
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

# Clear hashtags for this object and at the ones that have been used the most/least in the given interval: long
# Hashtags are only added if they have tweets. (Relevant for small databases)
  def build_new_long
    hashtags = self.get_hashtags_with_tweets(Hashtag.all)
    hashtags = hashtags.sort_by{ |hashtag| hashtag.get_trend_long }.reverse
    top = hashtags.first(MegaUltraTweet::Application::TRENDING_HASHTAGS_NUMBER)
    bottom = hashtags.last(MegaUltraTweet::Application::TRENDING_HASHTAGS_NUMBER)
    reset_hashtags
    set_hashtags(top)
    set_hashtags(bottom)
  end

end
