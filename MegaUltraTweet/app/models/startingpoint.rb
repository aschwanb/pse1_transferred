class Startingpoint < ActiveRecord::Base
  has_and_belongs_to_many :hashtags

  # Search terms that are used for scraping twitter
  # Output as Array of Strings
  def get_start
    out = []
    self.hashtags.to_a.each { |t| out.push(t.get_text) }
    return out
  end

  def add_popular_hashtags(number)
    hashtags = Hashtag.all
    hashtags = hashtags.sort_by{ |hashtag| hashtag.get_rank }.reverse
    hashtags.first(number).each do |hashtag|
      if !self.hashtags.include?(hashtag)
        self.hashtags<<hashtag
      end
    end
  end

  def remove_unpopular_hashtags(number)
    hashtags = self.hashtags.sort_by{ |hashtag| hashtag.get_rank}.reverse
    hashtags.last(number).each do |hashtag|
      self.hashtags.delete(hashtag)
    end
  end

  def repair_defaults
    MegaUltraTweet::Application::DEFAULT_STARTING_VALUES.each do |s|
      hashtag = Hashtag.find_by_text("##{s}")
      # TODO: If a hashtag is added, should a less popular one be removed?
      if !self.hashtags.exists?(hashtag.id)
        self.hashtags<<hashtag
      end
    end
  end

end
