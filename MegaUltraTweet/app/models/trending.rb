class Trending < ActiveRecord::Base
  has_many :Hashtag
  has_many :Hashtag
end