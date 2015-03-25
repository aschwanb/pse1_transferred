class Tweet < ActiveRecord::Base
  belongs_to :author
  has_and_belongs_to_many :hashtags
end
