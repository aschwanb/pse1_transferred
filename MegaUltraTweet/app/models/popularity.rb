class Popularity < ActiveRecord::Base
  belongs_to :popular, polymorphic: true
  serialize :times_used, Array
end
