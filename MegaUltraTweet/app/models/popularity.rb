class Popularity < ActiveRecord::Base
  belongs_to :popular, polymorphic: true
  serialize :usage, Array
end
