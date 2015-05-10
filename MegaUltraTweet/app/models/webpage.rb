class Webpage < ActiveRecord::Base
  has_and_belongs_to_many :tweets

  # TODO: Validation fails if standard Object.create function is used.
  # Fix validation to validate after creation before inserting into db?
  # validates :id, :url, :title, :description, :created_at, :updated_at, presence: true

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
