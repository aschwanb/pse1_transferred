class Tweet < ActiveRecord::Base
  has_many :Tweet_has_Hashtag
  has_many :Hashtag, through: :Tweet_has_Hashtag
end