class Tweet < ActiveRecord::Base
  belongs_to :author
  has_many :webpages
  has_and_belongs_to_many :hashtags

  def setHashtags(hashtagsArray)
    hashtagsArray.each do |tag|
      if Hashtag.where(text: tag).blank?
        hashtag = Hashtag.create(text: tag)
      else
        hashtag = Hashtag.find_by_text(tag)
      end
      self.hashtags<<hashtag
    end
  end

  def setWebpages(webpagesArray)
    if !webpagesArray.nil?
      puts "Inserting webpage into tweet"
      webpagesArray.each { |webpage| self.webpages.create(url: webpage)  }
    end
  end

  def getWebpages
    return self.webpages.to_a
  end

  def getText
    return self.text
  end

  def getHashtags
    return self.hashtags.to_a
  end

  def getRetweetsCount
    return self.retweets
  end

  def getAuthor
    return self.author
  end

end
