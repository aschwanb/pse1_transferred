class Tweet < ActiveRecord::Base
  belongs_to :author
  has_many :webpages
  has_and_belongs_to_many :hashtags

  def set_hashtags(hashtagsArray)
    hashtagsArray.each do |tag|
      if Hashtag.where(text: tag).blank?
        hashtag = Hashtag.create(text: tag)
      else
        hashtag = Hashtag.find_by_text(tag)
      end
      self.hashtags<<hashtag
    end
  end

  def set_webpages(webpagesArray)
    if !webpagesArray.nil?
      puts "Inserting webpage into tweet"
      webpagesArray.each { |webpage| self.webpages.create(url: webpage)  }
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
    return self.get_author.getFriendsCount + self.get_retweets_count
  end
end
