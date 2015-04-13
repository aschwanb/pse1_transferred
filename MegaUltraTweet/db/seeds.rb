# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Seed default starting point and hashtags
h1 = Hashtag.create(text: "#technology", populairity_old: 0, popularity_now: 0)
h2 = Hashtag.create(text: "#technologie", populairity_old: 0, popularity_now: 0)

s = Startingpoint.create

s.hashtags<<h1
s.hashtags<<h2

