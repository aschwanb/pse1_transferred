class Popularity < ActiveRecord::Base
  belongs_to :popular, polymorphic: true

end
