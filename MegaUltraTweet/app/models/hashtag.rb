class Hashtag < ActiveRecord::Base
  has_many :Tweet_has_Hashtag
  has_many :Tweet, through: :Tweet_has_Hashtag
end