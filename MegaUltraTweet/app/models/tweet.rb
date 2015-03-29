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
    return self.webpages
  end

  def getText
    return self.text
  end

end
