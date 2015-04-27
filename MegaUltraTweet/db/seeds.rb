# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Seed default starting point and hashtags
t = Trending.create
s = Startingpoint.create

MegaUltraTweet::Application::DEFAULT_STARTING_VALUES.each do |p|
  h = Hashtag.create(text: "##{p}")
  h.create_popularity(times_used: [0])
  s.hashtags<<h
end

