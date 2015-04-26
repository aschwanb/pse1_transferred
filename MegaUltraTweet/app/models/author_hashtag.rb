class AuthorHashtag < ActiveRecord::Base
  has_and_belongs_to_many :authors
  has_and_belongs_to_many :hashtags
  has_one :popularity, as: :popular

end
