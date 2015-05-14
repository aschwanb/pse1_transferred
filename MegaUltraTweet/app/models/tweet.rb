class Tweet < ActiveRecord::Base
  belongs_to :author
  has_and_belongs_to_many :webpages
  has_and_belongs_to_many :hashtags

  validates :text, :retweets, :twitter_id, :author_id, presence: true

  # TODO: Still used ?
  def by_hashtags(hashtags)
    where(:hashtags => hashtags.map(:text))
  end

  def set_hashtags(hashtags_array)
    Array(hashtags_array).each do |hashtag|
      if !self.hashtags.include?(hashtag)
        self.hashtags<<hashtag
        hashtag.set_rank(hashtag.get_rank + 1)
      end
    end
  end

  def set_webpages(webpages_array)
    Array(webpages_array).each do |webpage|
      if !self.webpages.include?(webpage)
        self.webpages<<webpage
      end
    end
  end

  def get_webpages
    return self.webpages.to_a
  end

  def get_text
    return self.text
  end

  def get_hashtags
    return self.hashtags.to_a
  end

  def get_retweets_count
    return self.retweets
  end

  def get_author
    return self.author
  end

  def get_rank
    return self.get_retweets_count + self.get_author.get_rank
  end

end
