class Author < ActiveRecord::Base
  has_many :Tweet
end