class Tweet < ActiveRecord::Base
  belongs_to :author
  has_and_belongs_to_many :webpages
  has_and_belongs_to_many :hashtags

  validates :id, :text, :retweets, :twitter_id, :author_id, :created_at, :updated_at, presence: true

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
    webpages_array.each do |url|
      nailer = LinkThumbnailer.generate(url)
      if Webpage.where(url: url).blank?
        webpage = Webpage.create(
            url: url,
            title: nailer.title,
            description: nailer.description
        )
      else
        webpage = Webpage.find_by_url(url)
      end
      self.webpages<<webpage
    end if !webpages_array.nil?
  rescue LinkThumbnailer::Exceptions => e
    Rails.logger.debug "DEBUG: Error in LinkThumbnailer" if Rails.logger.debug?
    Rails.logger.debug "DEBUG: #{self.inspect} #{caller(0).first}" if Rails.logger.debug?
    Rails.logger.debug "DEBUG: #{e.message}" if Rails.logger.debug?
  rescue Net::HTTPExceptions => e
    Rails.logger.debug "DEBUG: HTTP Error while thumbnailing" if Rails.logger.debug?
    Rails.logger.debug "DEBUG: #{self.inspect} #{caller(0).first}" if Rails.logger.debug?
    Rails.logger.debug "DEBUG: #{e.message}" if Rails.logger.debug?
  # TODO: Find the specific exception and rescue it. The current state is bad practice
  rescue Exception => e
    Rails.logger.debug "DEBUG: Unknown error while thumbnailing. Possibly ill formated url?" if Rails.logger.debug?
    Rails.logger.debug "DEBUG: #{self.inspect} #{caller(0).first}" if Rails.logger.debug?
    Rails.logger.debug "DEBUG: #{e.message}" if Rails.logger.debug?
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
