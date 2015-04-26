# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Seed default starting point and hashtags
s = Startingpoint.create
start = %w[ Technology Smartphone Phone Tablet Mobile Wireless PC TV Bluetooth WiFi Notebook Laptop Computer Web Electronics VR Watch Portable Processor Internet Robotics Drone CPU GSM LTE LCD Nano LED OLED HD Cmos Digital SLR DSLR Smart Screen Microphone Speaker ]

start.each do |p|
  h = Hashtag.create(text: "##{p}")
  s.hashtags<<h
end

