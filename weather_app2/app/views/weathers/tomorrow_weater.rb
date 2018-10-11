require "json"
require "open-uri"
require 'time'

unixtime_tomorrow = (Date.today+1).to_s
unixtime_tomorrow = Time.parse(unixtime_tomorrow).to_i
response_tomorrow = open("https://api.darksky.net/forecast/080fa7f90e3e587b2de824aa0bcc0dd4/" + "35.6895,139.6917,#{unixtime_tomorrow}").read

weather_tomorrow = JSON.parse(response_tomorrow)
tomorrow_weather = weather_tomorrow["currently"]["icon"]

puts "明日の天気:#{tomorrow_weather}"
