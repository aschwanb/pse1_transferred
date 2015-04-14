require 'link_thumbnailer'

class Tweet < ActiveRecord::Base
  belongs_to :author
  has_many :webpages
  has_and_belongs_to_many :hashtags

  def by_hashtags(hashtags)
    where(:hashtags => hashtags.map(:text))
  end

  def set_hashtags(hashtags_array)
    hashtags_array.each do |tag|
      if Hashtag.where(text: tag).blank?
        hashtag = Hashtag.create(text: tag, populairity_old: 0, popularity_now: 0)
      else
        hashtag = Hashtag.find_by_text(tag)
      end
      self.hashtags<<hashtag
      # Update hashtag popularity
      hashtag.update(popularity_now: hashtag.get_popularity_now + 1 )
      # If popularity exceedes a certain threshold -> ad hashtag to starting points
      if hashtag.get_popularity_now >= 50 && !Startingpoint.first.hashtags.include?(hashtag)
        Startingpoint.first.hashtags<<hashtag
      end
      # TODO: In implement downvoting
      # TODO: Move logic somewhere els
      # TODO: Create hashtag pairs and update their popularity


    end
  end

  def set_webpages(webpages_array)
    webpages_array.each do |webpage|
      nailer = LinkThumbnailer.generate(webpage)
      puts "Inserting webpage into tweet"
      self.webpages.create(
          url: webpage,
          title: nailer.title,
          description: nailer.description
      )
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
    return self.get_author.get_followers_count + self.get_retweets_count
  end
end
