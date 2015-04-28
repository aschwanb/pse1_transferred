class Webpage < ActiveRecord::Base
  has_and_belongs_to_many :tweets

  validates :id, :url, :title, :description, :created_at, :updated_at, presence: true

  def get_url
    return self.url
  end

  def get_tweets
    return self.tweets
  end

  def get_title
    return self.title
  end

  def get_description
    return self.description
  end

end
