class Startingpoint < ActiveRecord::Base
  has_and_belongs_to_many :hashtags

  # TODO: Validation fails if standard Object.create function is used.
  # Fix validation to validate after creation before inserting into db?
  # validates :id, :created_at, :updated_at, presence: true

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

  # If a hashtag is re-added, a less popular one is removed
  def repair_defaults
    MegaUltraTweet::Application::DEFAULT_STARTING_VALUES.each do |s|
      hashtag = Hashtag.find_by_text("##{s}")
      if !self.hashtags.exists?(hashtag.id)
        self.hashtags<<hashtag
        self.remove_unpopular_hashtags(1)
      end
    end
  end

end
