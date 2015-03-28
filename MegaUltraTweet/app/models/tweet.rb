class Tweet < ActiveRecord::Base
  belongs_to :author
  has_and_belongs_to_many :hashtags

  def addHashtags(hashtagsArray)
    hashtagsArray.each do |tag|
      if Hashtag.where(text: tag).blank?
        hashtag = Hashtag.create(text: tag)
      else
        hashtag = Hashtag.find_by_text(tag)
      end
      self.hashtags<<hashtag
    end
  end

end
